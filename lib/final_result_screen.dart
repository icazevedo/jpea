import 'package:flutter/material.dart';
import 'package:jpea/diagnostic_card.dart';
import 'package:jpea/main.dart';

class FinalResultScreen extends StatelessWidget {
  final String educationalPolicy;
  final Map<int, List<int>> votes;

  const FinalResultScreen({
    Key key,
    @required this.educationalPolicy,
    @required this.votes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Resultados finais')),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                Text(
                  "Votação encerrada!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Todos os jogadores votaram em cartas distintas que ele as considera como mais importantes entre as aprovadas pelos participantes.",
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 15),
                Text(
                  "A seguir, as três cartas mais votadas!",
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                ...generateTop3List(),
                const SizedBox(height: 30),
                RaisedButton(
                  child: Text('Começar um novo jogo!'),
                  onPressed: () {
                    // TODO
                    _cancelGameDialog(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<MapEntry<int, int>> getTop3Cards() {
    List<int> flatMapVotes = <int>[];
    for (List<int> selectedCards in votes.values) {
      flatMapVotes.addAll(selectedCards);
    }
    flatMapVotes.sort();
    Set<int> uniqueCards = Set<int>.from(flatMapVotes);
    Map<int, int> cardsVotes = <int, int>{};
    for (int card in uniqueCards) {
      cardsVotes[card] = countVotes(card, List<int>.from(flatMapVotes));
    }

    List<MapEntry<int, int>> sorted = cardsVotes.entries.toList();
    sorted.sort((MapEntry<int, int> first, MapEntry<int, int> second) =>
        first.value < second.value ? 1 : -1);
    return sorted.sublist(0, 3);
  }

  int countVotes(int id, List<int> rawVotes) {
    rawVotes.removeWhere((int card) => card != id);
    return rawVotes.length;
  }

  List<Widget> generateTop3List() {
    final List<MapEntry<int, int>> scoreboard = getTop3Cards();

    final List<Widget> cards = <Widget>[];

    for (MapEntry<int, int> score in scoreboard) {
      int position = scoreboard.indexOf(score) + 1;
      cards.add(
        Container(
          padding: const EdgeInsets.all(15),
          color: position.isEven
              ? Colors.black.withOpacity(0.05)
              : Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    '#$position',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '(${score.value} votos)',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Align(
                  child: DiagnosticCard(id: score.key),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return cards;
  }

  void _cancelGameDialog(BuildContext context)  {
    // Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => MyHomePage(),
      ),
    );
  }
}
