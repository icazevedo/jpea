import 'package:flutter/material.dart';
import 'diagnostic_cards_data.dart';

class DiagnosticCard extends StatelessWidget {
  final int id;

  const DiagnosticCard({@required this.id, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      alignment: Alignment.center,
      child: Image.asset(
        DiagnosticCardsData.diagnosticCards[id],
      ),
    );
  }
}
