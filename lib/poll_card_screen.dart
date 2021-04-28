import 'package:flutter/material.dart';
import 'package:jpea/final_result_screen.dart';

import 'diagnostic_card.dart';
import 'package:toast/toast.dart';

class PollCardScreen extends StatefulWidget {
  final int playerCount;
  final String educationalPolicy;
  final List<int> topCards;

  const PollCardScreen({
    @required this.playerCount,
    @required this.educationalPolicy,
    @required this.topCards,
  });

  @override
  _PollCardScreenState createState() => _PollCardScreenState();
}

class _PollCardScreenState extends State<PollCardScreen> {
  List<int> selectedCards = [];
  Map<int, List<int>> playerPlays = <int, List<int>>{};
  int currentPlayer = 1;

  // Removes and adds card from array
  void _selectCard(cardIndex) {
    setState(() {
      if (selectedCards.contains(cardIndex)) {
        selectedCards.remove(cardIndex);
      } else {
        if (selectedCards.length < 2) {
          selectedCards.add(cardIndex);
        } else {
          Toast.show('Você já marcou 2 cartas!', context, duration: 2);
        }
      }
    });
  }

  Widget _buildAboveTheCardContent() {
    return Container(
      padding: EdgeInsets.all(25),
      child: Column(
        children: [
          Text(
            "Votação das cartas aprovadas",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            "Cada jogador deve votar em duas cartas distintas que ele considera mais importantes entre as aprovadas pelos participantes.",
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 15),
          Text(
            "Jogador $currentPlayer",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Distribuição de pontos")),
      body: Column(
        children: [
          _buildAboveTheCardContent(),
          Expanded(
            child: ListView.builder(
              itemCount: widget.topCards.length,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.only(left: 15),
              itemBuilder: (buildContext, index) => Stack(
                children: <Widget>[
                  CheckboxListTile(
                    value: selectedCards.contains(widget.topCards[index]),
                    activeColor: Colors.cyan,
                    onChanged: (bool val) {
                      _selectCard(widget.topCards[index]);
                    },
                    title: Text(
                      "CheckBox Text",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: TextButton(
                      onPressed: () => _selectCard(widget.topCards[index]),
                      child: DiagnosticCard(id: widget.topCards[index]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: saveVotesForPlayer,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(horizontal: 50),
              ),
            ),
            child: Text("Confirmar"),
          )
        ],
      ),
    );
  }

  void saveVotesForPlayer() {
    playerPlays[currentPlayer] = List.from(selectedCards);
    print('current player plays: $playerPlays');

    setState(() {
      selectedCards.clear();
    });

    goToNextPlayer();
  }

  void goToNextPlayer() {
    if (currentPlayer == widget.playerCount) {
      goToResumePage();
      // setState(() => currentPlayer = 1); // temporary
    } else {
      setState(() => currentPlayer++);
    }
  }

  void goToResumePage() {
    // Navigator.of(context).push()
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => FinalResultScreen(
          educationalPolicy: widget.educationalPolicy,
          votes: playerPlays,
        ),
      ),
    );
  }
}
