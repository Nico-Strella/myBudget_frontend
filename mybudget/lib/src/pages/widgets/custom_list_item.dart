import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mybudget/src/blocs/app_provider.dart';
import 'package:mybudget/src/classes/money_movement.dart';
import 'package:mybudget/src/utils/colors.dart';
import 'package:mybudget/src/widgets/dialogs/edit_income__outcome_dialog.dart';
import 'package:provider/provider.dart';

class CustomListItem extends StatefulWidget {
  final MoneyMovement item;
  final bool isEven;
  final String type;
  const CustomListItem({Key? key, required this.item, required this.isEven, required this.type}) : super(key: key);

  @override
  _CustomListItemState createState() => _CustomListItemState();
}

class _CustomListItemState extends State<CustomListItem> {
  void editItem() async {
    List<dynamic> response = await EditIncomeOutcomeDialog.editIncomeOutcomeDialog(context, widget.type, widget.item);
    if (response.length > 1 && response[0] == EditIncomeOutcomeAction.ok) {
      try {
        Provider.of<AppProvider>(context).editIncome(response[1]);
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => editItem(),
      child: Container(
        color: widget.isEven ? ThemeColors.transparentBlue : Colors.transparent,
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
    );
  }
}
