import 'package:flutter/material.dart';

import 'diagnostic_card.dart';
import 'diagnostic_card_screen.dart';
import 'main.dart';

class GameMapScreen extends StatefulWidget {
  final int playerCount;
  final String educationalPolicy;
  final int diagnosticCardToAddToTop;
  final int diagnosticCardToAddToBottom;

  GameMapScreen({
    @required this.playerCount,
    @required this.educationalPolicy,
    this.diagnosticCardToAddToTop,
    this.diagnosticCardToAddToBottom,
  });

  @override
  _GameMapScreenState createState() => _GameMapScreenState();
}

class _GameMapScreenState extends State<GameMapScreen> {
  @override
  void initState() {
    super.initState();

    // TODO: add card to bottom in case there is
    // TODO: add card to top in case there is
  }

  Future<void> _cancelGameDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cancelar jogo?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Todo o progresso do jogo será perdido.'),
                Text('Você tem certeza que deseja voltar à tela inicial e cancelar o jogo atual?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Continuar jogando'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Cancelar jogo'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MyHomePage(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapa do jogo"),
        leading: IconButton(
          tooltip: "Cancelar jogo",
          icon: RotatedBox(
            quarterTurns: 2,
            child: Icon(Icons.exit_to_app),
          ),
          onPressed: () => {_cancelGameDialog()},
        ),
        actions: [
          IconButton(
            tooltip: "Finalizar jogo",
            icon: Icon(Icons.check_circle),
            onPressed: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => MyHomePage(),
                ),
              ),
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Flex(
            direction: Axis.vertical,
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Estão presentes na PEA",
                          maxLines: 1,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (_, index) => DiagnosticCard(id: index),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Color(0xffB2D5D4),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            widget.educationalPolicy,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "Política de Educação Aberta (PEA) escolhida",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlineButton(
                            borderSide: BorderSide(
                              color: Colors.blueGrey[500],
                              style: BorderStyle.solid,
                              width: 1,
                            ),
                            highlightedBorderColor: Colors.blueGrey[800],
                            onPressed: () => {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DiagnosticCardScreen(
                                    playerCount: widget.playerCount,
                                    educationalPolicy: widget.educationalPolicy,
                                  ),
                                ),
                              ),
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Puxar carta diagnóstico",
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.arrow_forward)
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    verticalDirection: VerticalDirection.up,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Não estão presentes na PEA",
                          maxLines: 1,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (_, index) => DiagnosticCard(id: index),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
