import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

import 'diagnostic_card.dart';
import 'voting_screen.dart';

class DiagnosticCardScreen extends StatefulWidget {
  final int playerCount;
  final String educationalPolicy;

  const DiagnosticCardScreen({
    @required this.playerCount,
    @required this.educationalPolicy,
  });

  @override
  _DiagnosticCardScreenState createState() => _DiagnosticCardScreenState();
}

class _DiagnosticCardScreenState extends State<DiagnosticCardScreen> {
  bool isInDiscussion = false;
  bool discussionTimeEnded = false;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  void _startDiscussion() {
    setState(() {
      isInDiscussion = true;
      endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
    });
  }

  void _startVoting() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => VotingScreen(
          playerCount: widget.playerCount,
          educationalPolicy: widget.educationalPolicy,
        ),
      ),
    );
  }

  Widget _buildBelowTheCardContent() {
    if (isInDiscussion) {
      return Container(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Text(
              "Discussão da carta diagnóstico",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "O temporizador abaixo indica o tempo sugerido para discussão a respeito da carta diagnóstico acima.",
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 30,
            ),
            CountdownTimer(
              endTime: endTime,
              endWidget: Text(
                "00 : 00 : 00",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textStyle: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(25),
      child: Column(
        children: [
          Text(
            "Leitura da carta diagnóstico",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text.rich(
            TextSpan(
              text: "Leia em ",
              style: TextStyle(
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'voz alta',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: " a carta diagnóstico acima sem manifestar sua opinião. " +
                      "\n\nTodos devem entender claramente o conteúdo da carta para que, na próxima etapa, " +
                      "possam discutir e opinar quanto ao conteúdo da carta diagnóstico: se está presente " +
                      "ou não na política que está sendo analisada no jogo.",
                ),
              ],
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _buildNextStepsContent() {
    if (isInDiscussion) {
      return Container(
        padding: EdgeInsets.fromLTRB(25, 0, 25, 25),
        child: Column(
          children: [
            Text(
              "Ao terminar a discussão, clique no botão abaixo. " +
                  "Cada jogador irá votar e passar o celular para outro jogador fazer o mesmo.",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () => _startVoting(),
              child: Text("Iniciar votação"),
            )
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.fromLTRB(25, 0, 25, 25),
      child: Column(
        children: [
          Text(
            "Ao terminar a leitura, clique no botão abaixo para iniciar a discussão a respeito da carta diagnóstico",
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 5,
          ),
          ElevatedButton(
            onPressed: () => _startDiscussion(),
            child: Text("Iniciar discussão"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carta diagnóstico"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DiagnosticCard(
                  id: 0,
                ),
                _buildBelowTheCardContent()
              ],
            ),
            _buildNextStepsContent()
          ],
        ),
      ),
    );
  }
}
