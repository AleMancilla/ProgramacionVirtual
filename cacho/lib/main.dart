import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Widget> dadosBase = [
    SizedBox(
        width: 100,
        height: 100,
        child: Image.asset('src/images/dadomoviendose.gif')),
    SizedBox(width: 100, height: 100, child: Image.asset('src/images/uno.png')),
    SizedBox(width: 100, height: 100, child: Image.asset('src/images/dos.png')),
    SizedBox(
        width: 100, height: 100, child: Image.asset('src/images/tres.png')),
    SizedBox(
        width: 100, height: 100, child: Image.asset('src/images/cuatro.png')),
    SizedBox(
        width: 100, height: 100, child: Image.asset('src/images/cinco.png')),
    SizedBox(
        width: 100, height: 100, child: Image.asset('src/images/seis.png')),
  ];

  List<Dado> dadosToShow = [];

  var rng = Random();
  @override
  void initState() {
    // _reordenar();
    super.initState();
  }

  _reordenar() {
    dadosToShow = [
      Dado(dadosBase[0], 0),
      Dado(dadosBase[0], 0),
      Dado(dadosBase[0], 0),
      Dado(dadosBase[0], 0),
      Dado(dadosBase[0], 0),
    ];
    setState(() {});
    Future.delayed(const Duration(seconds: 1), () {
      dadosToShow = [];
      for (var i = 0; i < 5; i++) {
        int indice = rng.nextInt(6) + 1;
        dadosToShow.add(
          Dado(dadosBase[indice], indice),
        );
      }
      setState(() {});
    });
  }

  Widget _unDado(int posicion) {
    return GestureDetector(
      child: dadosToShow[posicion].widget,
      onTap: () {
        recargarDado(posicion);
      },
    );
  }

  recargarDado(int index) {
    dadosToShow[index] = Dado(dadosBase[0], 0);

    setState(() {});
    Future.delayed(const Duration(seconds: 1), () {
      int indice = rng.nextInt(4) + 1;
      dadosToShow[index] = Dado(dadosBase[indice], indice);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cacho',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Cacho'),
            backgroundColor: Colors.blueGrey[900],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Text(
                'Alejandro Mancilla Huanca',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text('JUEGO DEL CACHO'),
              if (dadosToShow.isNotEmpty) _cuerpoDados(),
              if (dadosToShow.isEmpty)
                Expanded(child: Image.asset('src/images/cacho.png')),
              const Text('<Lanzar para comenzar>'),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          _reordenar();
                        },
                        label: const Text('Lanzar'),
                        heroTag: 'uno',
                        backgroundColor: Colors.blueGrey[900],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          dadosToShow = [];
                          setState(() {});
                        },
                        label: const Text('Inicializar'),
                        backgroundColor: Colors.blueGrey[900],
                        heroTag: 'uno',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
            ],
          )),
    );
  }

  _cuerpoDados() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _unDado(0),
            _unDado(1),
          ],
        ),
        _unDado(2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _unDado(3),
            _unDado(4),
          ],
        ),
        Text(
            'Dados = ${dadosToShow[0].position} - ${dadosToShow[1].position} - ${dadosToShow[2].position} - ${dadosToShow[3].position} - ${dadosToShow[4].position} - '),
        Text(
          _mensaje(),
          style: TextStyle(
              color: Colors.red, fontSize: 25, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  String _mensaje() {
    List<int> dadosToShowNumbers = dadosToShow.map((e) => e.position).toList();
    dadosToShowNumbers.sort();
    if (_esCero(dadosToShowNumbers)) return '.....';
    if (_esGrande(dadosToShowNumbers)) return 'GRANDE';
    if (_esPoker(dadosToShowNumbers)) return 'POKER';
    if (_esFull(dadosToShowNumbers)) return 'FULL';
    if (_esEscalera(dadosToShowNumbers)) return 'ESCALERA';
    return 'SIGA PARTICIPANDO';
  }

  bool _esCero(List<int> dadosToShowNumbers) {
    bool esCero = false;
    int base = dadosToShowNumbers[0];
    for (var dado in dadosToShowNumbers) {
      if (dado == base && base == 0) {
        esCero = true;
      }
    }
    return esCero;
  }

  bool _esGrande(List<int> dadosToShowNumbers) {
    bool esGrande = true;
    int base = dadosToShowNumbers[0];
    for (var dado in dadosToShowNumbers) {
      if (dado != base) {
        esGrande = false;
      }
    }
    return esGrande;
  }

  bool _esPoker(List<int> dadosToShowNumbers) {
    bool esPoker = false;
    List<int> base = [0, 0, 0, 0, 0, 0];
    for (var dado in dadosToShowNumbers) {
      base[dado - 1]++;
    }

    if (base.contains(4) && base.contains(1)) {
      esPoker = true;
    }

    print(esPoker);
    return esPoker;
  }

  bool _esFull(List<int> dadosToShowNumbers) {
    bool esFull = false;
    List<int> base = [0, 0, 0, 0, 0, 0];
    for (var dado in dadosToShowNumbers) {
      base[dado - 1]++;
    }

    if (base.contains(3) && base.contains(2)) {
      esFull = true;
    }

    print(esFull);
    return esFull;
  }

  bool _esEscalera(List<int> dadosToShowNumbers) {
    bool esEscalera = false;
    List<int> base = [0, 0, 0, 0, 0, 0];
    for (var dado in dadosToShowNumbers) {
      base[dado - 1]++;
    }

    if (base[0] == 1 &&
        base[1] == 1 &&
        base[2] == 1 &&
        base[3] == 1 &&
        base[4] == 1) {
      esEscalera = true;
    }
    if (base[1] == 1 &&
        base[2] == 1 &&
        base[3] == 1 &&
        base[4] == 1 &&
        base[5] == 1) {
      esEscalera = true;
    }
    if (base[0] == 1 &&
        base[2] == 1 &&
        base[3] == 1 &&
        base[4] == 1 &&
        base[5] == 1) {
      esEscalera = true;
    }

    print(esEscalera);
    return esEscalera;
  }
}

class Dado {
  late Widget widget;
  late int position;

  Dado(this.widget, this.position);
}
