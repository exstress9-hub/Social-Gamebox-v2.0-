import 'dart:math';
import 'package:flutter/material.dart';
import 'i18n.dart';
import 'net.dart';
import 'home.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) => ValueListenableBuilder<String>(
        valueListenable: lang,
        builder: (_, __, ___) => MaterialApp(
          title: 'Muhammetaly',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(colorSchemeSeed: Colors.deepPurple, brightness: Brightness.dark, useMaterial3: true),
          home: Home(),
        ),
      );
}

class JoinScreen extends StatefulWidget {
  final String name;
  const JoinScreen({super.key, required this.name});
  @override
  State<JoinScreen> createState() => _JoinState();
}

class _JoinState extends State<JoinScreen> {
  final disc = Discovery();
  final ipC = TextEditingController();

  @override
  void initState() {
    super.initState();
    disc.start();
  }

  @override
  void dispose() {
    disc.stop();
    super.dispose();
  }

  Future<void> go(String ip) async {
    final c = ClientNet();
    try {
      await c.connect(ip, widget.name);
      if (!mounted) return;
      Navigator.push(context, MaterialPageRoute(builder: (_) => Lobby(name: widget.name, client: c)));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t('fail'))));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(t('join'))),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          Text(t('searching')),
          StreamBuilder<List<Room>>(
            stream: disc.stream,
            initialData: const [],
            builder: (_, s) => Column(children: [
              for (final r in s.data!)
                ListTile(
                  leading: const Icon(Icons.wifi),
                  title: Text(r.host),
                  subtitle: Text('${r.ip} • ${r.players}'),
                  onTap: () => go(r.ip),
                ),
            ]),
          ),
          const Divider(height: 32),
          Text(t('manual')),
          const SizedBox(height: 8),
          TextField(controller: ipC, keyboardType: TextInputType.number, decoration: const InputDecoration(hintText: '192.168.43.1', border: OutlineInputBorder())),
          const SizedBox(height: 8),
          FilledButton(onPressed: () => go(ipC.text.trim()), child: Text(t('connect'))),
        ]),
      );
}

class Lobby extends StatefulWidget {
  final String name;
  final String? game;
  final ClientNet? client;
  const Lobby({super.key, required this.name, this.game, this.client});
  @override
  State<Lobby> createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> {
  HostNet? host;
  Beacon? beacon;
  List<String> players = [];
  List<String> ips = [];
  String? word;
  bool dealt = false;
  bool get isHost => widget.client == null;

  @override
  void initState() {
    super.initState();
    if (isHost) {
      _startHost();
    } else {
      widget.client!.listen(_onMsg, () {
        if (mounted) Navigator.pop(context);
      });
    }
  }

  Future<void> _startHost() async {
    host = HostNet(widget.name, () {
      if (mounted) setState(() => players = host!.names);
    });
    await host!.start();
    ips = await localIps();
    beacon = Beacon();
    await beacon!.start(widget.name, ips, () => host!.names.length);
    if (mounted) setState(() => players = host!.names);
  }

  void _onMsg(Map m) {
    if (!mounted) return;
    if (m['t'] == 'players') setState(() => players = List<String>.from(m['list'] as List));
    if (m['t'] == 'role') {
      setState(() {
        word = m['word'] as String?;
        dealt = true;
      });
    }
  }

  void _deal() {
    final rnd = Random();
    final list = lang.value == 'ru' ? ruWords : trWords;
    final w = list[rnd.nextInt(list.length)];
    final imp = rnd.nextInt(players.length);
    for (var i = 0; i < players.length; i++) {
      final pw = i == imp ? null : w;
      if (i == 0) {
        setState(() {
          word = pw;
          dealt = true;
        });
      } else {
        host!.sendTo(players[i], {'t': 'role', 'word': pw});
      }
    }
  }

  @override
  void dispose() {
    host?.close();
    beacon?.stop();
    widget.client?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      appBar: AppBar(title: Text(widget.game != null ? t(widget.game!) : 'Muhammetaly')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: dealt
            ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                RoleCard(word: word),
                const SizedBox(height: 16),
                OutlinedButton(onPressed: () => setState(() => dealt = false), child: Text(t('back'))),
              ])
            : ListView(children: [
                if (isHost) Text('${t('ipinfo')}${ips.join(', ')}'),
                const SizedBox(height: 12),
                Text('${t('players')} (${players.length})', style: title),
                for (final p in players) ListTile(leading: const Icon(Icons.person), title: Text(p)),
                const SizedBox(height: 12),
                if (isHost) ...[
                  FilledButton(onPressed: players.length >= 3 ? _deal : null, child: Text(t('start'))),
                  if (players.length < 3) Padding(padding: const EdgeInsets.only(top: 8), child: Text(t('need3'))),
                ] else
                  Text(t('waiting')),
              ]),
      ),
    );
  }
}

class RoleCard extends StatefulWidget {
  final String? word;
  const RoleCard({super.key, this.word});
  @override
  State<RoleCard> createState() => _RoleCardState();
}

class _RoleCardState extends State<RoleCard> {
  bool show = false;
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTapDown: (_) => setState(() => show = true),
        onTapUp: (_) => setState(() => show = false),
        onTapCancel: () => setState(() => show = false),
        child: Card(
          child: SizedBox(
            width: double.infinity,
            height: 220,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  show ? (widget.word == null ? t('impWord') : '${t('word')}: ${widget.word}') : t('hold'),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
          ),
        ),
      );
}
