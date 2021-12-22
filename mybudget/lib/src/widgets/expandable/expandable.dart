import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mybudget/src/blocs/app_provider.dart';
import 'package:mybudget/src/utils/colors.dart';

class Expandable extends StatefulWidget {
  final String text;
  final Widget child;
  final AppProvider appProvider;

  const Expandable({Key? key, required this.text, required this.appProvider, required this.child}) : super(key: key);

  @override
  _ExpandableState createState() => _ExpandableState();
}

class _ExpandableState extends State<Expandable> with TickerProviderStateMixin {
  late AnimationController _deleteIconAnimationController;
  late AnimationController _expandAnimationController;
  bool isExpanded = false;
  bool isDeleteIconShown = false;

  @override
  void initState() {
    _deleteIconAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _expandAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  void dispose() {
    _deleteIconAnimationController.dispose();
    _expandAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _deleteAll() {
      widget.appProvider.deleteAllIncomeOutcome(type: widget.text);
      setState(() {
        _deleteIconAnimationController.reverse();
        isDeleteIconShown = false;
      });
    }

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
          GestureDetector(
            onPanUpdate: (details) {
              if ((widget.text == "Income" && widget.appProvider.incomeList.isNotEmpty) || (widget.text == "Outcome" && widget.appProvider.outcomeList.isNotEmpty)) {
                // Swiping in right direction.
                if (details.delta.dx > 0) {
                  setState(() {
                    _deleteIconAnimationController.reverse();
                    isDeleteIconShown = false;
                  });
                }

                // Swiping in left direction.
                if (details.delta.dx < 0) {
                  setState(() {
                    _deleteIconAnimationController.forward();
                    isDeleteIconShown = true;
                  });
                }
              }
            },
            child: InkWell(
              onTap: () {
                setState(() {
                  if (isDeleteIconShown) {
                    setState(() {
                      _deleteIconAnimationController.reverse();
                      isDeleteIconShown = false;
                    });
                  }
                  if (isExpanded) {
                    _expandAnimationController.reverse();
                  } else {
                    _expandAnimationController.forward();
                  }
                  isExpanded = !isExpanded;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 5, top: 10, bottom: 10),
                      color: isExpanded ? ThemeColors.blue : Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText(
                            widget.text,
                            style: TextStyle(
                              color: isExpanded ? ThemeColors.white : ThemeColors.blue,
                              fontWeight: isExpanded ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          Icon(isExpanded ? Icons.expand_less : Icons.expand_more, color: isExpanded ? ThemeColors.white : ThemeColors.blue),
                        ],
                      ),
                    ),
                  ),
                  if (isDeleteIconShown)
                    FadeTransition(
                      opacity: _deleteIconAnimationController,
                      child: InkWell(
                        onTap: () => _deleteAll(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(4),
                            ),
                            color: ThemeColors.red,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.delete,
                              color: ThemeColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            SizeTransition(
              sizeFactor: CurvedAnimation(
                parent: _expandAnimationController,
                curve: Curves.fastOutSlowIn,
              ),
              child: Column(
                children: [
                  widget.child,
                ],
              ),
            ),
        ],
      ),
    );
  }
}
