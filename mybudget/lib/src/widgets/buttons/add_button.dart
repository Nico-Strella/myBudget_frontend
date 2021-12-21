import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AddButton extends StatefulWidget {
  final Color bgColor;
  final String text;
  final Function callback;

  // ignore: prefer_const_constructors_in_immutables
  AddButton({
    Key? key,
    required this.bgColor,
    required this.text,
    required this.callback,
  }) : super(key: key);

  @override
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(20),
        primary: widget.bgColor,
        textStyle: const TextStyle(fontSize: 20),
      ),
      onPressed: () => widget.callback(),
      child: AutoSizeText(
        'Add ${widget.text}',
        textAlign: TextAlign.center,
      ),
    );
  }
}
