import 'package:flutter/material.dart';

import 'diagnostic_card.dart';
import 'finished_voting_screen.dart';
import 'voting_button.dart';

class VotingScreen extends StatefulWidget {
  final int playerCount;
  final String educationalPolicy;

  const VotingScreen({
    @required this.playerCount,
    @required this.educationalPolicy,
  });

  @override
  _VotingScreenState createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  List<int> submittedVotes = [];
  int currentVote = -1;

  void _selectNo() {
    setState(() => {currentVote = 0});
  }

  void _selectYes() {
    setState(() => {currentVote = 1});
  }

  void _submitVote() {
    if (submittedVotes.length + 1 == widget.playerCount) {
      submittedVotes.add(currentVote);

      int voteSum = submittedVotes.reduce((value, element) => value + element);

      bool shouldAddCardToTop = false;

      if (voteSum > (widget.playerCount / 2).floor()) {
        shouldAddCardToTop = true;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => FinishedVotingScreen(
            playerCount: widget.playerCount,
            educationalPolicy: widget.educationalPolicy,
            shouldAddCardToTop: shouldAddCardToTop,
          ),
        ),
      );

      return;
    }

    setState(() {
      submittedVotes.add(currentVote);
      currentVote = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Votação"),
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
                          "Jogador ${submittedVotes.length + 1} - Realize seu voto",
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
                          "Você acredita que o conteúdo da carta diagnóstico está presente na " +
                              "Política de Educação Aberta escolhida (${widget.educationalPolicy})?",
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        VotingButton(
                          isYes: false,
                          isSelected: currentVote == 0,
                          onTap: _selectNo,
                        ),
                        VotingButton(
                          isYes: true,
                          isSelected: currentVote == 1,
                          onTap: _selectYes,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.fromLTRB(25, 0, 25, 25),
                child: Column(
                  children: [
                    if (widget.playerCount > submittedVotes.length + 1)
                      Text(
                        "Após submeter seu voto, passe o celular para o próximo jogador",
                        textAlign: TextAlign.center,
                      ),
                    SizedBox(
                      height: 5,
                    ),
                    ElevatedButton(
                      onPressed: currentVote != -1 ? _submitVote : null,
                      child: Text(
                        "Submeter voto",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
