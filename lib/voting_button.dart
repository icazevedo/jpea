import 'package:flutter/material.dart';

class VotingButton extends StatefulWidget {
  final bool isYes;
  final bool isSelected;
  final VoidCallback onTap;

  VotingButton({
    this.isYes = false,
    this.isSelected = false,
    this.onTap,
  });

  @override
  _VotingButtonState createState() => _VotingButtonState();
}

class _VotingButtonState extends State<VotingButton> {
  @override
  Widget build(BuildContext context) {
    String buttonText = widget.isYes ? "Sim" : "Não";
    IconData buttonIcon =
        widget.isYes ? Icons.check_circle_outline : Icons.cancel_outlined;

    Color backgroundColor = widget.isSelected
        ? widget.isYes
            ? Colors.green
            : Colors.red[400]
        : Colors.grey;
    Color textColor = widget.isSelected ? Colors.white : Colors.black;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: AnimatedContainer(
        curve: Curves.ease,
        duration: Duration(milliseconds: 300),
        height: 100,
        width: 100,
        color: backgroundColor,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: widget.onTap ?? () => {},
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    buttonIcon,
                    size: 42,
                    color: textColor,
                  ),
                  Text(
                    buttonText,
                    style: TextStyle(
                      fontSize: 20,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
