import 'package:flutter/material.dart';

import 'game_map_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo da Política de Educação Aberta',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _playerCountController = new TextEditingController();
  TextEditingController _educationalPolicyController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jogo da Política de Educação Aberta"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(25),
        children: <Widget>[
          Text(
            "Bem vindo ao Jogo da Política de Educação Aberta",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 25),
          Text(
            "Para começar, preencha os campos abaixo e clique em \"Começar\"",
            textAlign: TextAlign.center,
          ),
          TextField(
            controller: _playerCountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Número de jogadores",
            ),
          ),
          TextField(
            controller: _educationalPolicyController,
            decoration: InputDecoration(
              labelText: "Política de Educação Aberta",
            ),
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => GameMapScreen(
                    playerCount: int.parse(_playerCountController.text),
                    educationalPolicy: _educationalPolicyController.text,
                  ),
                ),
              ),
            },
            child: Text("Começar"),
          )
        ],
      ),
    );
  }
}
