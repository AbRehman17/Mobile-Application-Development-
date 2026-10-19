import 'package:flutter/material.dart';

import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Timer? _timer;
  void _increment() {
    setState(() {
      _counter++;
    });
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  void _decrement() {
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
    }
  }

  @override
  void initState() {
    super.initState(); // pehle
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        _counter++;
      });
      debugPrint('tick ${timer.tick}');
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // timer roko
    super.dispose(); // aakhir mein
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$_counter',
              style: const TextStyle(fontSize: 40, color: Colors.blue),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: _increment, child: Text("+")),
                const SizedBox(width: 12),
                ElevatedButton(onPressed: _reset, child: Text("Reset")),
                const SizedBox(width: 12),
                if (_counter > 0)
                  ElevatedButton(onPressed: _decrement, child: Text('-')),
                const SizedBox(width: 12),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
