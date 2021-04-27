import 'package:flutter/material.dart';

import 'diagnostic_card.dart';
import 'game_map_screen.dart';

class FinishedVotingScreen extends StatefulWidget {
  final int playerCount;
  final String educationalPolicy;
  final int cardId;
  final bool shouldAddCardToTop;
  final List<int> topCards;
  final List<int> bottomCards;

  FinishedVotingScreen({
    @required this.playerCount,
    @required this.educationalPolicy,
    @required this.cardId,
    @required this.shouldAddCardToTop,
    @required this.topCards,
    @required this.bottomCards,
  });

  @override
  _FinishedVotingScreenState createState() => _FinishedVotingScreenState();
}

class _FinishedVotingScreenState extends State<FinishedVotingScreen> {
  void _goToGameMap() {
    List<int> updatedTopCards = [...widget.topCards];
    List<int> updatedBottomCards = [...widget.bottomCards];

    if (widget.shouldAddCardToTop) {
      updatedTopCards.add(widget.cardId);
    } else {
      updatedBottomCards.add(widget.cardId);
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => GameMapScreen(
          educationalPolicy: widget.educationalPolicy,
          playerCount: widget.playerCount,
          topCards: updatedTopCards,
          bottomCards: updatedBottomCards,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String title = "A carta diagnóstico foi " +
        (widget.shouldAddCardToTop ? "aprovada!" : "rejeitada!");

    String description;

    if (widget.shouldAddCardToTop) {
      description =
          "A maioria dos participantes acredita que o conteúdo da carta diagnóstico está presente na " +
              "Política de Educação Aberta escolhida. Ela será adicionada na lista superior do mapa do jogo.";
    } else {
      description =
          "A maioria dos participantes acredita que o conteúdo da carta diagnóstico não está presente na " +
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
                  DiagnosticCard(id: widget.cardId),
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
                  onPressed: _goToGameMap,
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
