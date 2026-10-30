import 'package:flutter/material.dart';

void main() => runApp(const CounterApp());

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF4F5F7),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1B2A41)),
      ),
      home: const CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  static const _tinta = Color(0xFF1B2A41);
  static const _tintaPudar = Color(0xFF5C6B80);
  static const _garis = Color(0xFFE1E5EB);

  int _hitung = 0;

  void _tambah() => setState(() => _hitung++);

  void _kurang() {
    if (_hitung > 0) setState(() => _hitung--);
  }

  void _reset() => setState(() => _hitung = 0);

  @override
  Widget build(BuildContext context) {
    final bisaKurang = _hitung > 0;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Hitungan',
                    style: TextStyle(color: _tintaPudar, fontSize: 15),
                  ),
                  const SizedBox(height: 12),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 180),
                    transitionBuilder: (child, anim) => FadeTransition(
                      opacity: anim,
                      child: ScaleTransition(
                        scale: Tween(begin: 0.9, end: 1.0).animate(anim),
                        child: child,
                      ),
                    ),
                    child: Text(
                      '$_hitung',
                      key: ValueKey(_hitung),
                      style: const TextStyle(
                        color: _tinta,
                        fontSize: 112,
                        fontWeight: FontWeight.w300,
                        height: 1.1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 64,
                        height: 64,
                        child: OutlinedButton(
                          onPressed: bisaKurang ? _kurang : null,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: _tinta,
                            side: const BorderSide(color: _garis, width: 1.5),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: const Icon(Icons.remove, size: 26),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: 112,
                        height: 64,
                        child: FilledButton(
                          onPressed: _tambah,
                          style: FilledButton.styleFrom(
                            backgroundColor: _tinta,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: const Icon(Icons.add, size: 28),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: bisaKurang ? _reset : null,
                    style: TextButton.styleFrom(foregroundColor: _tintaPudar),
                    child: const Text('Reset'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}