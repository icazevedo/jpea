import 'package:flutter/material.dart';

import 'diagnostic_card.dart';
import 'game_map_screen.dart';

class FinishedVotingScreen extends StatefulWidget {
  final int playerCount;
  final String educationalPolicy;
  final bool shouldAddCardToTop;

  FinishedVotingScreen({
    this.playerCount,
    this.educationalPolicy,
    this.shouldAddCardToTop,
  });

  @override
  _FinishedVotingScreenState createState() => _FinishedVotingScreenState();
}

class _FinishedVotingScreenState extends State<FinishedVotingScreen> {
  @override
  Widget build(BuildContext context) {
    String title = "A carta diagnóstico foi " +
        (widget.shouldAddCardToTop ? "aprovada!" : "rejeitada!");

    String description;

    if (widget.shouldAddCardToTop) {
      description =
          "A maioria dos participantes acreditam que o conteúdo da carta diagnóstico está presente na " +
              "Política de Educação Aberta escolhida. Ela será adicionada na lista superior do mapa do jogo.";
    } else {
      description =
          "A maioria dos participantes acreditam que o conteúdo da carta diagnóstico não está presente na " +
              "Política de Educação Aberta escolhida. Ela será adicionada na lista inferior do mapa do jogo.";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Resultado da votação"),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  DiagnosticCard(id: 0),
                  Container(
                    padding: EdgeInsets.all(25),
                    child: Column(
                      children: [
                        Text(
                          title,
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
                          description,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.fromLTRB(25, 0, 25, 25),
                child: ElevatedButton(
                  onPressed: () => {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GameMapScreen(
                          // TODO: add to bottom or top according to shouldAddCardToTop
                          educationalPolicy: widget.educationalPolicy,
                          playerCount: widget.playerCount,
                        ),
                      ),
                    ),
                  },
                  child: Text(
                    "Voltar ao mapa",
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
