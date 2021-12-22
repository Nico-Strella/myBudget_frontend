import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mybudget/src/blocs/app_provider.dart';
import 'package:mybudget/src/classes/money_movement.dart';
import 'package:mybudget/src/utils/colors.dart';
import 'package:mybudget/src/widgets/dialogs/edit_income__outcome_dialog.dart';
import 'package:provider/provider.dart';

class CustomListItem extends StatefulWidget {
  final MoneyMovement item;
  final int index;
  final String type;
  const CustomListItem({Key? key, required this.item, required this.index, required this.type}) : super(key: key);

  @override
  _CustomListItemState createState() => _CustomListItemState();
}

class _CustomListItemState extends State<CustomListItem> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool isDeleteIconShown = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void editItem() async {
      if (isDeleteIconShown) {
        setState(() {
          _animationController.reverse();
          isDeleteIconShown = false;
        });
      }
      List<dynamic> response = await EditIncomeOutcomeDialog.editIncomeOutcomeDialog(context, widget.type, widget.item);
      if (response.length > 1 && response[0] == EditIncomeOutcomeAction.ok) {
        Provider.of<AppProvider>(context, listen: false).editIncomeOutcome(response[1], widget.index, widget.type);
      }
    }

    void _deleteItem() async {
      setState(() {
        _animationController.reverse();
        isDeleteIconShown = false;
      });
      Provider.of<AppProvider>(context, listen: false).deleteIncomeOutcome(widget.index, widget.type);
    }

    return GestureDetector(
      onTap: () => editItem(),
      onPanUpdate: (details) {
        // Swiping in right direction.
        if (details.delta.dx > 0) {
          setState(() {
            _animationController.reverse();
            isDeleteIconShown = false;
          });
        }

        // Swiping in left direction.
        if (details.delta.dx < 0) {
          setState(() {
            _animationController.forward();
            isDeleteIconShown = true;
          });
        }
      },
      child: Container(
        color: widget.index.isEven ? ThemeColors.transparentBlue : Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('dd/MM').format(widget.item.date),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        widget.item.detail,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('฿ ${NumberFormat("#,##0.00", "en_US").format(widget.item.amount)}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isDeleteIconShown)
              FadeTransition(
                opacity: _animationController,
                child: InkWell(
                  onTap: () => _deleteItem(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    color: ThemeColors.red,
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
    );
  }
}
