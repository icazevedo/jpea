import 'package:flutter/material.dart';

import 'diagnostic_card.dart';

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

  // Removes and adds card from array
  void _selectCard(cardIndex) {
    setState(() {
      if (selectedCards.contains(cardIndex)) {
        selectedCards.remove(cardIndex);
      } else {
        selectedCards.add(cardIndex);
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
            "Jogador X",
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
        appBar: AppBar(
          title: Text("Distribuição de pontos"),
        ),
        body: Column(children: [
          _buildAboveTheCardContent(),
          Expanded(
            child: ListView.builder(
                itemCount: widget.topCards.length,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.only(left: 15),
                itemBuilder: (buildContext, index) => Stack(
                      children: [
                        CheckboxListTile(
                          value: selectedCards.contains(widget.topCards[index]),
                          activeColor: Colors.cyan,
                          onChanged: (bool val) {
                            _selectCard(widget.topCards[index]);
                          },
                          title: Text("CheckBox Text",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17)),
                        ),
                        Align(
                            alignment: Alignment.topCenter,
                            child: TextButton(
                              onPressed: () {
                                _selectCard(widget.topCards[index]);
                              },
                              child: DiagnosticCard(id: widget.topCards[index]),
                            )),
                      ],
                    )),
          ),
          TextButton(
            onPressed: () {},
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 50))),
            child: Text("Confirmar"),
          )
        ]));
  }
}
