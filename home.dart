import 'package:flutter/material.dart';
import 'games.dart';
import 'i18n.dart' show lang;
import 'main.dart' show JoinScreen, Lobby;
import 'play.dart';

class Home extends StatefulWidget {
  Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String get me => roster.isNotEmpty ? roster.first : 'Host';

  void sheet(Game g) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(g.emoji, style: const TextStyle(fontSize: 48)),
          Text(g.name, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(g.desc, textAlign: TextAlign.center),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              icon: const Icon(Icons.phone_android),
              label: Text(L('Tek telefon (elden ele)', 'Один телефон (по кругу)')),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => PlayersScreen(g: g)));
              },
            ),
          ),
          if (g.hotspot) ...[
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.wifi),
                label: const Text('Hotspot'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => Lobby(name: me, game: g.id)));
                },
              ),
            ),
          ],
        ]),
      ),
    );
  }

  Widget tile(Game g) {
    final col = catColor[g.cat]!;
    final soon = g.kind == 'soon';
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        if (soon) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(L('Yakında', 'Скоро'))));
        } else {
          sheet(g);
        }
      },
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [col, Color.lerp(col, Colors.black, .5)!]),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Opacity(
            opacity: soon ? .5 : 1,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(g.emoji, style: const TextStyle(fontSize: 30)),
              const Spacer(),
              Text(g.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Text(soon ? L('Yakında', 'Скоро') : '👥 ${g.min}+', style: const TextStyle(fontSize: 12, color: Colors.white70)),
            ]),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(padding: const EdgeInsets.all(16), children: [
          Row(children: [
            Text('Muhammetaly', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            const Spacer(),
            SegmentedButton<String>(
              segments: const [ButtonSegment(value: 'tr', label: Text('TR')), ButtonSegment(value: 'ru', label: Text('RU'))],
              selected: {lang.value},
              onSelectionChanged: (s) => lang.value = s.first,
            ),
          ]),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            icon: const Icon(Icons.wifi),
            label: Text(L('Hotspot oyununa katıl', 'Присоединиться по хотспоту')),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => JoinScreen(name: me))),
          ),
          for (final c in catColor.keys) ...[
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Row(children: [
                Container(width: 6, height: 22, decoration: BoxDecoration(color: catColor[c], borderRadius: BorderRadius.circular(3))),
                const SizedBox(width: 8),
                Text(catName[c]![lang.value == 'ru' ? 1 : 0], style: Theme.of(context).textTheme.titleLarge),
              ]),
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.35,
              children: [for (final g in games.where((g) => g.cat == c)) tile(g)],
            ),
          ],
        ]),
      ),
    );
  }
}
