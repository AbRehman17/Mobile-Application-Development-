// main.dart - Team Board lab
import 'dart:async';

import 'package:flutter/material.dart';

const String studentName = 'Muhammad Hussain Abdul Rehman';
const String rollNo = '04072313047';

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit

const List<String> courses = [
  'Mobile Dev',
  'Data Structures',
  'Operating Systems',
  'Databases',
  'Networks',
  'Software Eng',
  'AI',
  'Web Engineering',
  'Graphics',
  'Security',
];
const List<String> names = ['Ali', 'Sara', 'Omar', 'Hina', 'Zain', 'Maya'];
const List<String> mains = [
  'start',
  'center',
  'end',
  'spaceBetween',
  'spaceAround',
  'spaceEvenly',
];
const List<String> crosses = ['start', 'center', 'end'];
const List<String> hues = ['teal', 'indigo', 'orange', 'pink', 'green'];
const Map<String, MaterialColor> swatches = {
  'teal': Colors.teal,
  'indigo': Colors.indigo,
  'orange': Colors.orange,
  'pink': Colors.pink,
  'green': Colors.green,
};

final String course = courses[u];

// Steps 1-2: the clock
final int startSec = 5 * (1 + t % 5); // where the clock starts
final int tick = 1 + u % 3; // how much it adds every second
final int ticks = 4 + u % 4; // how many ticks until it stops
final int stopAt = startSec + ticks * tick; // the clock stops here

// Steps 4-5: the tiles
final String tileA = names[u % 6];
final String tileB = names[(u + 2) % 6];
final String tileC = names[(u + 4) % 6];
final int tapsToMake = 2 + t % 3; // used by the experiment in Step 5

// Step 6: axes (the NAMES are printed on the settings card; you type the enum)
final String mainName = mains[u % 6];
final String crossName = crosses[t % 3];

// Step 8: Expanded and Flexible
final double fixedW = 70.0 + 10 * u;
final int flexA = 1 + t % 3;
final int flexB = 1 + u % 2;

// Step 9: Container
final double boxMargin = 4.0 + 2 * (t % 5);
final double boxPad = 8.0 + 2 * (u % 5);
final double boxRadius = 4.0 * (1 + (t + u) % 4);
final double boxBorder = 1.0 + t % 3;
final String hue = hues[(t + u) % 5]; // use swatches[hue]!.shade100

// Step 10: Stack
final double dotTop = 4.0 + 4 * (t % 4);
final double dotRight = 4.0 + 4 * (u % 4);
final double dotBottom = 4.0 + 4 * ((t + u) % 4);
final double dotLeft = 4.0 + 4 * ((t + 2 * u) % 4);
// ===========================================================================

// Step 2 writes to this list from initState and dispose.
final List<String> lifecycleLog = <String>[];

void main() => runApp(const LabApp());

// Keep the name LabApp and its const constructor: the checker uses them.
class LabApp extends StatelessWidget {
  const LabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Team Board', home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Team Board: $course')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SettingsCard(),
            const SizedBox(height: 12),
            const Welcome(),
            const SizedBox(height: 12),
            const Clock(),
            const SizedBox(height: 12),
            const SwapBoard(),
            const SizedBox(height: 12),
            const InfoPanel(),
            const SizedBox(height: 12),
            const SummaryRow(),
          ],
        ),
      ),
    );
  }
}

// ---- Provided: shows YOUR numbers. Keep it on the page. Do not rename.
class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'YOUR SETTINGS (seed $seed)\n'
      'clock: start $startSec, tick $tick, stop at $stopAt\n'
      'tiles: $tileA, $tileB, $tileC (taps for the Step 5 experiment: $tapsToMake)\n'
      'row main axis: $mainName | column cross axis: $crossName\n'
      'flex: $flexA and $flexB | fixed width: ${fixedW.toStringAsFixed(0)}\n'
      'box: margin $boxMargin, padding $boxPad, radius $boxRadius, '
      'border $boxBorder, colour $hue\n'
      'stamp: top $dotTop, right $dotRight, bottom $dotBottom, left $dotLeft',
      key: const Key('settings'),
      style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
    );
  }
}

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  late Timer _timer;
  int _seconds = startSec;
  int _builds = 0; // Step 2

  @override
  void initState() {
    super.initState();
    lifecycleLog.add('initState'); // Step 2
    // Why start the Timer in initState and not inside build?
    // initState runs only once when the State is created.
    // If we started the Timer in build(), a new Timer would be created
    // on every rebuild → many timers running at the same time →
    // the clock would speed up dramatically.
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _seconds += tick);
      if (_seconds >= stopAt) timer.cancel();
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Step 2
    lifecycleLog.add('dispose'); // Step 2
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _builds++; // Step 2 – counts every rebuild

    // Why does Builds go up by one per second and not by two?
    // setState() triggers exactly one rebuild per tick.
    // The framework does not rebuild twice for a single setState.
    //
    // What error would you see if the widget left the screen
    // and _timer.cancel() was missing from dispose?
    // You would get: "setState() called after dispose()"
    // because the Timer would keep running and try to call setState
    // on a disposed State object.

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Session: $_seconds s', key: const Key('clock')),
        Text('Builds: $_builds', key: const Key('builds')),
        Probe(seconds: _seconds), // Step 3 ← add this (no const!)
      ],
    );
  }
}

// ---- Step 3: Probe ----
class Probe extends StatelessWidget {
  final int seconds;

  const Probe({super.key, required this.seconds});

  @override
  Widget build(BuildContext context) {
    // Which of the two, Widget or Element, is “cheap and thrown away”
    // and which one keeps the State?
    // Widget is cheap and thrown away on every rebuild.
    // Element stays alive and keeps the State.
    //
    // Where is the third one, the RenderObject, and what is its job?
    // The RenderObject lives below the Element in the tree.
    // Its job is layout, painting and hit-testing (the actual rendering).

    final bool above =
        context.findAncestorWidgetOfExactType<Scaffold>() != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Seen at: $seconds s', key: const Key('probe-seen')),
        Text(
          'Widget #${identityHashCode(this)}',
          key: const Key('probe-widget'),
        ),
        Text(
          'Element #${identityHashCode(context)}',
          key: const Key('probe element'),
        ),
        Text(
          'Context belongs to: ${context.widget.runtimeType}',
          key: const Key('probe-context'),
        ),
        Text('Scaffold above me: $above', key: const Key('probe-above')),
      ],
    );
  }
}

class SummaryRow extends StatelessWidget {
  const SummaryRow({super.key});

  @override
  Widget build(BuildContext context) {
    // Why does wrapping a Text in Expanded make it wrap its words?
    // Constraints go down, sizes go up.
    // Expanded forces the Text to take only 1/3 of the available width
    // (tight width constraint). When the Text receives a limited max width,
    // it wraps its text onto multiple lines instead of overflowing.

    return Row(
      children: [
        Expanded(
          child: Text(
            'Part A: read the widget tree of the $course board from top to bottom.',
            key: const Key('sum-a'),
          ),
        ),
        Expanded(
          child: Text(
            'Part B: build each box from small widgets and never extend a built-in class.',
            key: const Key('sum-b'),
          ),
        ),
        Expanded(
          child: Text(
            'Part C: break the layout on purpose, then fix it with Expanded or Wrap.',
            key: const Key('sum-c'),
          ),
        ),
      ],
    );
  }
}

// ---- Step 4: Welcome ----
class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Welcome, $studentName', key: const Key('welcome')),
    );
  }
}

// ---- Step 4: Tile ----
class Tile extends StatefulWidget {
  final String label;

  const Tile(this.label, {super.key});

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  int taps = 0;

  @override
  Widget build(BuildContext context) {
    // You built Tile out of an ElevatedButton without writing extends ElevatedButton.
    // What is this style called, and why does Flutter prefer it?
    // This style is called composition (or "composition over inheritance").
    // Flutter prefers it because it is more flexible, avoids deep inheritance trees,
    // and lets you combine small, reusable widgets instead of creating many subclasses.

    return ElevatedButton(
      onPressed: () => setState(() => taps++),
      child: Text('${widget.label}: $taps'),
    );
  }
}

// ---- Step 5: SwapBoard ----
class SwapBoard extends StatefulWidget {
  const SwapBoard({super.key});

  @override
  State<SwapBoard> createState() => _SwapBoardState();
}

class _SwapBoardState extends State<SwapBoard> {
  var tiles = [
    Tile(tileA, key: ValueKey(tileA)),
    Tile(tileB, key: ValueKey(tileB)),
    Tile(tileC, key: ValueKey(tileC)),
    // Tile(tileA),
    // Tile(tileB),
    // Tile(tileC),
  ];

  void swap() => setState(() => tiles = tiles.reversed.toList());

  @override
  Widget build(BuildContext context) {
    // Without keys, why did the number stay at the left even though the label moved?
    // Flutter matches widgets by type and position. Without keys, the Element (and its State)
    // at position 0 stays in place. When the list is reversed, the new widget at position 0
    // is given the old Element/State, so the count stays on the left while only the label changes.

    return Column(
      children: [
        Row(children: tiles),
        ElevatedButton(
          key: const Key('swap'),
          onPressed: swap,
          child: const Text('Swap'),
        ),
      ],
    );
  }
}

class InfoPanel extends StatelessWidget {
  const InfoPanel({super.key});

  @override
  Widget build(BuildContext context) {
    // In a Column, which axis is the main axis?
    // The main axis of a Column is the vertical axis (top to bottom).
    //
    // Why does crossAxisAlignment: CrossAxisAlignment.center in a Column
    // move the children left or right and not up or down?
    // Because the cross axis is the horizontal axis. crossAxisAlignment
    // controls positioning along the cross axis, so in a Column it moves
    // children horizontally (left / center / right).

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The Row
        Row(
          key: const Key('info-row'),
          mainAxisAlignment: MainAxisAlignment.center, // from YOUR SETTINGS
          children: [
            Text('Start: $startSec s', key: const Key('row-a')),
            Text('Tick: $tick s', key: const Key('row-b')),
            Text('Stop: $stopAt s', key: const Key('row-c')),
          ],
        ),
        const SizedBox(height: 12),
        // The inner Column
        Column(
          key: const Key('info-col'),
          crossAxisAlignment: CrossAxisAlignment.center, // from YOUR SETTINGS
          children: [
            Text('Name: $studentName', key: const Key('col-a')),
            Text('Roll no: $rollNo', key: const Key('col-b')),
            Text('Course: $course', key: const Key('col-c')),
          ],
        ),
      ],
    );
  }
}
