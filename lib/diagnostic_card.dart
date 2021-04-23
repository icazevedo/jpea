import 'package:flutter/material.dart';

class DiagnosticCard extends StatelessWidget {
  final int id;

  const DiagnosticCard({@required this.id, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      width: 300,
      height: 300,
      color: Colors.red[300],
    );
  }
}
