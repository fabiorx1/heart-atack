import 'dart:math';

import 'package:flutter/material.dart';
import 'package:heart_atack/balloon.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heart Atack!',
      theme:
          ThemeData(primarySwatch: Colors.deepPurple, fontFamily: 'Beautiful'),
      home: Scaffold(
        body: Stack(
          children: const [
            Center(
              child: Text(
                'you\'re so cute\nthat is causing me heart atacks!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(bottom: 12, right: 16),
                child: Text(
                  'por: xuxa dev',
                  style: TextStyle(
                    fontSize: 21,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      routes: {
        '/bday-aline': (_) => const AlinePage(),
      },
    );
  }
}

class AlinePage extends StatefulWidget {
  const AlinePage({Key? key}) : super(key: key);

  @override
  State<AlinePage> createState() => _AlinePageState();
}

class _AlinePageState extends State<AlinePage> with TickerProviderStateMixin {
  int _index = 0;

  late final AnimationController _throwController;
  late final AnimationController _throwHeartController;

  final List<AnimationController> _controllers1 = [];
  final List<AnimationController> _controllers2 = [];
  final List<AnimationController> _controllers3 = [];
  final List<AnimationController> _heartControllers = [];
  final List<int> _heartsX = [];
  final List<int> _heartsY = [];
  final _labels1 = ['F', 'E', 'L', 'I', 'Z'];
  late final _colors1 = [
    for (int i = 0; i < _labels1.length; i++)
      i < 6 ? Colors.red[400 + i * 100] : Colors.blue[300 + (i - 6) * 100],
  ];
  final arco1 = [0, 1, 1.6, 1, 0];
  final _labels2 = ['A', 'N', 'I', 'V', 'E', 'R', 'S', 'Á', 'R', 'I', 'O'];
  final arco2 = [0, 1, 2, 2.5, 3, 3.3, 3, 2.5, 2, 1, 0];
  late final _colors2 = [
    for (int i = 0; i < _labels2.length; i++)
      i < 5 ? Colors.orange[500 + i * 100] : Colors.pink[300 + (i - 5) * 100],
  ];
  final _labels3 = ['A', 'L', 'I', 'N', 'E', '!'];
  final arco3 = [0, 1, 1.6, 1.6, 1, 0];
  late final _colors3 = [
    for (int i = 0; i < _labels3.length; i++)
      i < 6
          ? Colors.purple[400 + i * 100]
          : Colors.deepPurple[300 + (i - 6) * 100],
  ];
  int _throwPos = 0;
  int _heartThrowPos = 0;
  @override
  void dispose() {
    _throwController.dispose();
    _throwHeartController.dispose();
    for (var _c in _controllers1) _c.dispose();
    for (var _c in _controllers2) _c.dispose();
    for (var _c in _controllers3) _c.dispose();
    for (var _c in _heartControllers) _c.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _throwController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..addListener(
        () => setState(
          () {
            final totalLen =
                _labels1.length + _labels2.length + _labels3.length;
            final delta = 1 / totalLen;
            if (_throwPos < _throwController.value ~/ delta) {
              _throwPos += 1;
              _incrementControllers();
            }
          },
        ),
      );
    _throwHeartController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..addListener(() {
        setState(
          () {
            final sz = MediaQuery.of(context).size;
            const delta = 1 / 15;

            if (_heartThrowPos < _throwHeartController.value ~/ delta) {
              _heartThrowPos += 1;
              _incrementHearts(sz.width, sz.height);
            }
          },
        );
        if (_throwHeartController.isCompleted) {
          _throwHeartController.reset();
          _heartThrowPos = 0;
        }
      });

    super.initState();
  }

  void _incrementControllers() {
    switch (_index) {
      case 0:
        _controllers1.add(
          AnimationController(
            duration: const Duration(seconds: 1),
            vsync: this,
          )..addListener(() => setState(() {})),
        );
        if (_controllers1.length == _labels1.length) {
          _index += 1;
        }
        _controllers1.last.forward();
        break;
      case 1:
        _controllers2.add(
          AnimationController(
            duration: const Duration(seconds: 1),
            vsync: this,
          )..addListener(() => setState(() {})),
        );
        if (_controllers2.length == _labels2.length) {
          _index += 1;
        }
        _controllers2.last.forward();
        break;
      case 2:
        _controllers3.add(
          AnimationController(
            duration: const Duration(seconds: 1),
            vsync: this,
          )..addListener(() => setState(() {})),
        );
        if (_controllers3.length == _labels3.length) {
          _index += 1;
        }
        _controllers3.last.forward();
        break;
    }
  }

  final Random _random = Random();
  void _incrementHearts(_w, _h) {
    _heartControllers.add(
      AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      )..addListener(() => setState(() {})),
    );
    _heartsX.add(_random.nextInt((_w - 12).toInt()));
    _heartsY.add(_random.nextInt((_h - 12).toInt()));
    _heartControllers.last.forward();
  }

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    final double _inicio1 = (_width / 5);
    final double _final1 = 4 * (_width / 5);
    const double _inicio2 = 0;
    final double _final2 = _width - 24;
    final double _inicio3 = (_width / 8);
    final double _final3 = 7 * (_width / 8);
    final _part1 = (_final1 - _inicio1) / _labels1.length;
    final _part2 = (_final2 - _inicio2) / _labels2.length;
    final _part3 = (_final3 - _inicio3) / _labels3.length;
    final _xpositions1 = [
      for (int i = 0; i < _labels1.length; i++) _inicio1 + i * _part1
    ];
    final _xpositions2 = [
      for (int i = 0; i < _labels2.length; i++) _inicio2 + i * _part2
    ];
    final _xpositions3 = [
      for (int i = 0; i < _labels3.length; i++) _inicio3 + i * _part3
    ];

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          for (var i = 0; i < _heartControllers.length; i++)
            Positioned(
              left: _heartsX[i].toDouble(),
              bottom: _heartsY[i].toDouble(),
              child: Visibility(
                visible: !_heartControllers[i].isDismissed,
                child: Opacity(
                  opacity: _heartControllers[i].value,
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red[400],
                  ),
                ),
              ),
            ),
          for (var i = 0; i < min(_controllers1.length, _labels1.length); i++)
            Positioned(
              bottom:
                  _height * (3 / 5) * _controllers1[i].value + arco1[i] * 20,
              left: _xpositions1[i],
              child: Opacity(
                opacity: min(1, 1.6 * _controllers1[i].value),
                child: Balloon(
                  label: _labels1[i],
                  canSplash: _controllers1[i].isCompleted,
                  positionController: _controllers1[i],
                  color: _colors1[i],
                ),
              ),
            ),
          for (var i = 0; i < min(_controllers2.length, _labels2.length); i++)
            Positioned(
              bottom:
                  _height * (2 / 5) * _controllers2[i].value + arco2[i] * 20,
              left: _xpositions2[i],
              child: Opacity(
                opacity: min(1, 1.6 * _controllers2[i].value),
                child: Balloon(
                  label: _labels2[i],
                  canSplash: _controllers2[i].isCompleted,
                  positionController: _controllers2[i],
                  color: _colors2[i],
                ),
              ),
            ),
          for (var i = 0; i < min(_controllers3.length, _labels3.length); i++)
            Positioned(
              bottom:
                  _height * (2 / 7) * _controllers3[i].value + arco3[i] * 20,
              left: _xpositions3[i],
              child: Opacity(
                opacity: min(1, 1.6 * _controllers3[i].value),
                child: Balloon(
                  label: _labels3[i],
                  canSplash: _controllers3[i].isCompleted,
                  positionController: _controllers3[i],
                  color: _colors3[i],
                ),
              ),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 64,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Material(
                      color: Colors.pink[200],
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: () {
                          _incrementHearts(_width, _height);
                        },
                        child: const SizedBox(
                          height: 48,
                          width: 48,
                          child: Icon(Icons.favorite),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Material(
                      color: Colors.deepPurple[300],
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: () {
                          if (_throwHeartController.isDismissed) {
                            _throwHeartController.forward();
                          }
                        },
                        child: SizedBox(
                          height: 48,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.play_arrow_rounded),
                                  Icon(Icons.favorite),
                                ],
                              ),
                              const Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 3.0),
                                  child: Text(
                                    '15',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Arial',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Material(
                      color: Colors.deepOrange,
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: () {
                          _throwController.forward();
                        },
                        child: const SizedBox(
                          height: 48,
                          width: 48,
                          child: Icon(Icons.play_arrow_rounded),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(bottom: 12, right: 16),
              child: Text(
                'por: xuxa dev',
                style: TextStyle(
                  fontSize: 21,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
