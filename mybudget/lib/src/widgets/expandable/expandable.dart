import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mybudget/src/utils/colors.dart';

class Expandable extends StatefulWidget {
  final String text;
  final Widget child;

  const Expandable({Key? key, required this.text, required this.child}) : super(key: key);

  @override
  _ExpandableState createState() => _ExpandableState();
}

class _ExpandableState extends State<Expandable> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ThemeColors.blue,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 5, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    widget.text,
                    style: TextStyle(
                      color: ThemeColors.blue,
                      fontWeight: isExpanded ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  Icon(isExpanded ? Icons.expand_less : Icons.expand_more, color: ThemeColors.blue),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  widget.child,
                ],
              ),
            ),
        ],
      ),
    );
  }
}
