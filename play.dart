import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'games.dart';
import 'i18n.dart' show lang;

final _rnd = Random();

Widget shell(Game g, Widget body, {String? title}) {
  final col = catColor[g.cat]!;
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [col.withOpacity(.6), const Color(0xFF14111F)]),
    ),
    child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(backgroundColor: Colors.transparent, title: Text(title ?? g.name)),
      body: SafeArea(child: Padding(padding: const EdgeInsets.all(20), child: body)),
    ),
  );
}

Widget bigBtn(String label, VoidCallback? f) =>
    SizedBox(width: double.infinity, height: 56, child: FilledButton(onPressed: f, child: Text(label, style: const TextStyle(fontSize: 18))));

Widget bigText(BuildContext c, String s) => Text(s, textAlign: TextAlign.center, style: Theme.of(c).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold));

// ---------- Oyuncu ekleme ----------
class PlayersScreen extends StatefulWidget {
  final Game g;
  const PlayersScreen({super.key, required this.g});
  @override
  State<PlayersScreen> createState() => _PS();
}

class _PS extends State<PlayersScreen> {
  final c = TextEditingController();
  void add() {
    final n = c.text.trim();
    if (n.isEmpty || roster.contains(n)) return;
    setState(() => roster.add(n));
    c.clear();
  }

  void start() {
    final g = widget.g;
    final Widget w = g.kind == 'role' ? RoleDeal(g: g) : g.kind == 'deck' ? DeckScreen(g: g) : g.kind == 'word' ? WordTimer(g: g) : BombScreen(g: g);
    Navigator.push(context, MaterialPageRoute(builder: (_) => w));
  }

  @override
  Widget build(BuildContext context) => shell(
        widget.g,
        Column(children: [
          bigText(context, L('Oyuncuları ekle', 'Добавь игроков')),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: TextField(controller: c, onSubmitted: (_) => add(), decoration: InputDecoration(hintText: L('İsim', 'Имя'), filled: true, border: const OutlineInputBorder()))),
            const SizedBox(width: 8),
            IconButton.filled(onPressed: add, icon: const Icon(Icons.add)),
          ]),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(spacing: 8, runSpacing: 8, children: [
                for (final p in roster) InputChip(label: Text(p), onDeleted: () => setState(() => roster.remove(p))),
              ]),
            ),
          ),
          Text('${roster.length} / ${widget.g.min}+'),
          const SizedBox(height: 8),
          bigBtn(L('Başla', 'Начать'), roster.length >= widget.g.min ? start : null),
        ]),
      );
}

// ---------- Rol dağıtma (Impostor, Werewolf, Mafia, Murder, Timer, Fake Story) ----------
List<String> assign(String id, int n) {
  final r = <String>[];
  List<String> town(String bad, String seer, String good) {
    r.addAll(List.filled(max(1, n ~/ 4), bad));
    if (n >= 5) r.add(seer);
    if (n >= 6) r.add('doctor');
    while (r.length < n) {
      r.add(good);
    }
    return r;
  }

  if (id == 'werewolf') {
    town('wolf', 'seer', 'villager');
  } else if (id == 'mafia') {
    town('mafia', 'cop', 'citizen');
  } else if (id == 'murder') {
    r.add('killer');
    if (n >= 4) r.add('detective');
    while (r.length < n) {
      r.add('innocent');
    }
  } else {
    r.add(id == 'fakestory' ? 'fake' : 'imp');
    while (r.length < n) {
      r.add('word');
    }
  }
  r.shuffle();
  return r;
}

class RoleDeal extends StatefulWidget {
  final Game g;
  const RoleDeal({super.key, required this.g});
  @override
  State<RoleDeal> createState() => _RD();
}

class _RD extends State<RoleDeal> {
  late List<String> rl;
  late String secret;
  int i = 0;
  bool seen = false, all = false;

  @override
  void initState() {
    super.initState();
    _new();
  }

  void _new() {
    rl = assign(widget.g.id, roster.length);
    final w = words();
    secret = widget.g.id == 'timer' ? '${5 + _rnd.nextInt(11)}' : w[_rnd.nextInt(w.length)];
    i = 0;
    seen = false;
    all = false;
  }

  String text(String r) {
    final id = widget.g.id;
    if (r == 'imp') return L('IMPOSTOR\nBlöf yap, yakalanma!', 'ИМПОСТОР\nБлефуй, не попадись!');
    if (r == 'fake') return L('Hikâyeyi UYDUR!\nKimse anlamasın.', 'ВЫДУМАЙ историю!\nЧтобы никто не понял.');
    if (r == 'word') {
      if (id == 'timer') return L('Süre: $secret sn', 'Время: $secret с');
      if (id == 'fakestory') return L('Konu: $secret\nGerçek bir hikâye anlat', 'Тема: $secret\nРасскажи настоящую историю');
      return L('Kelime: $secret', 'Слово: $secret');
    }
    return roles[r]![lang.value == 'ru' ? 1 : 0];
  }

  @override
  Widget build(BuildContext context) {
    final g = widget.g;
    if (i >= roster.length) {
      return shell(
        g,
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          bigText(context, L('Herkes rolünü gördü.\nOyun başlasın!', 'Все увидели роли.\nИгра началась!')),
          const SizedBox(height: 24),
          if (all)
            for (var k = 0; k < roster.length; k++) Text('${roster[k]} — ${text(rl[k]).replaceAll('\n', ' ')}'),
          const SizedBox(height: 24),
          bigBtn(all ? L('Gizle', 'Скрыть') : L('Rolleri göster', 'Показать роли'), () => setState(() => all = !all)),
          const SizedBox(height: 8),
          bigBtn(L('Yeni tur', 'Новый раунд'), () => setState(_new)),
        ]),
      );
    }
    final name = roster[i];
    return shell(
      g,
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        if (!seen) ...[
          Text(L('Telefonu şu kişiye ver:', 'Передай телефон:')),
          const SizedBox(height: 12),
          bigText(context, name),
          const SizedBox(height: 32),
          bigBtn(L('Ben $name', 'Я $name'), () => setState(() => seen = true)),
        ] else ...[
          Card(child: Padding(padding: const EdgeInsets.all(32), child: SizedBox(width: double.infinity, child: bigText(context, text(rl[i]))))),
          const SizedBox(height: 32),
          bigBtn(L('Gizle ve devam', 'Скрыть и дальше'), () => setState(() {
                i++;
                seen = false;
              })),
        ],
      ]),
    );
  }
}

// ---------- Kart destesi (Truth or Dare, Never Have I Ever, ...) ----------
class DeckScreen extends StatefulWidget {
  final Game g;
  const DeckScreen({super.key, required this.g});
  @override
  State<DeckScreen> createState() => _DS();
}

class _DS extends State<DeckScreen> {
  final pool = <String, List<String>>{};
  int turn = 0;
  String? card;
  List<String> get keys => widget.g.id == 'tod' ? ['truth', 'dare'] : [widget.g.id];

  @override
  void initState() {
    super.initState();
    if (keys.length == 1) card = _draw(keys[0]);
  }

  String _draw(String k) {
    var p = pool[k];
    if (p == null || p.isEmpty) {
      p = List<String>.of(decks[k]![lang.value == 'ru' ? 1 : 0])..shuffle();
      pool[k] = p;
    }
    return p.removeLast();
  }

  @override
  Widget build(BuildContext context) {
    final player = roster[turn % roster.length];
    return shell(
      widget.g,
      Column(children: [
        Text('👉 $player', style: Theme.of(context).textTheme.headlineSmall),
        Expanded(child: Center(child: card == null ? const Text('🎲', style: TextStyle(fontSize: 64)) : bigText(context, card!))),
        if (keys.length > 1 && card == null)
          Row(children: [
            Expanded(child: bigBtn(L('Doğruluk', 'Правда'), () => setState(() => card = _draw('truth')))),
            const SizedBox(width: 8),
            Expanded(child: bigBtn(L('Cesaret', 'Действие'), () => setState(() => card = _draw('dare')))),
          ])
        else
          bigBtn(L('Sıradaki', 'Дальше'), () => setState(() {
                turn++;
                card = keys.length == 1 ? _draw(keys[0]) : null;
              })),
      ]),
    );
  }
}

// ---------- Süreli kelime (Charades, Who Am I, Tilt It) ----------
class WordTimer extends StatefulWidget {
  final Game g;
  const WordTimer({super.key, required this.g});
  @override
  State<WordTimer> createState() => _WT();
}

class _WT extends State<WordTimer> {
  int turn = 0, left = 60, score = 0;
  String phase = 'ready', word = '';
  Timer? t;
  List<String> pool = [];

  void _w() {
    if (pool.isEmpty) pool = List<String>.of(words())..shuffle();
    word = pool.removeLast();
  }

  void start() {
    setState(() {
      score = 0;
      left = 60;
      _w();
      phase = 'play';
    });
    t?.cancel();
    t = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        left--;
        if (left <= 0) {
          t?.cancel();
          phase = 'done';
        }
      });
    });
  }

  @override
  void dispose() {
    t?.cancel();
    super.dispose();
  }

  String get how {
    switch (widget.g.id) {
      case 'charades':
        return L('Kelimeyi hareketle anlat, konuşmak yok!', 'Покажи слово жестами, без слов!');
      case 'whoami':
        return L('Ekibin evet/hayır ile sana ipucu versin', 'Друзья отвечают «да/нет»');
      default:
        return L('Telefonu alnına tut, ekibin anlatsın', 'Приложи телефон ко лбу, друзья объясняют');
    }
  }

  @override
  Widget build(BuildContext context) {
    final player = roster[turn % roster.length];
    Widget body;
    if (phase == 'ready') {
      body = Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        bigText(context, player),
        const SizedBox(height: 12),
        Text(how, textAlign: TextAlign.center),
        const SizedBox(height: 32),
        bigBtn(L('Başla (60 sn)', 'Старт (60 с)'), start),
      ]);
    } else if (phase == 'play') {
      body = Column(children: [
        Text('⏳ $left   ✅ $score', style: Theme.of(context).textTheme.headlineSmall),
        Expanded(child: Center(child: Text(word, textAlign: TextAlign.center, style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold)))),
        Row(children: [
          Expanded(child: bigBtn('⏭', () => setState(_w))),
          const SizedBox(width: 8),
          Expanded(child: bigBtn('✅', () => setState(() {
                score++;
                _w();
              }))),
        ]),
      ]);
    } else {
      body = Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        bigText(context, '$player: $score ✅'),
        const SizedBox(height: 32),
        bigBtn(L('Sıradaki oyuncu', 'Следующий игрок'), () => setState(() {
              turn++;
              phase = 'ready';
            })),
      ]);
    }
    return shell(widget.g, body);
  }
}

// ---------- Hot Bomb / Hot Bomb Duel ----------
class BombScreen extends StatefulWidget {
  final Game g;
  const BombScreen({super.key, required this.g});
  @override
  State<BombScreen> createState() => _BS();
}

class _BS extends State<BombScreen> {
  late String cat;
  int holder = 0;
  bool boom = false;
  Timer? t;
  int get n => widget.g.id == 'duel' ? 2 : roster.length;

  @override
  void initState() {
    super.initState();
    _new();
  }

  void _new() {
    t?.cancel();
    cat = bombCats()[_rnd.nextInt(6)];
    boom = false;
    t = Timer(Duration(seconds: 12 + _rnd.nextInt(24)), () {
      if (mounted) setState(() => boom = true);
    });
  }

  @override
  void dispose() {
    t?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final name = roster[holder % n];
    return shell(
      widget.g,
      boom
          ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('💥', style: TextStyle(fontSize: 96)),
              bigText(context, '${L('PATLADI!', 'БУМ!')}\n$name'),
              const SizedBox(height: 32),
              bigBtn(L('Yeni tur', 'Новый раунд'), () => setState(_new)),
            ])
          : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              bigText(context, cat),
              const Text('💣', style: TextStyle(fontSize: 96)),
              bigText(context, name),
              const SizedBox(height: 32),
              bigBtn(L('Geçir ➡️', 'Передать ➡️'), () => setState(() => holder = (holder + 1) % n)),
            ]),
    );
  }
}
