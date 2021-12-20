import 'package:flutter/material.dart';
import 'package:mybudget/src/blocs/Provider.dart';
import 'package:mybudget/src/utils/colors.dart';
import 'package:mybudget/src/widgets/buttons/add_button.dart';
import 'package:mybudget/src/widgets/dialogs/add_income_dialog.dart';
import 'package:provider/provider.dart';

class ActionButtons extends StatelessWidget {
  final appProvider;
  const ActionButtons({Key? key, required this.appProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onPressIncome(BuildContext context) async {
      List<dynamic> response = await AddIncomeDialog.addIncomeDialog(context);
      if (response.length > 1 && response[0] == AddIncomeAction.ok) {
        appProvider.addIncome(response[1]);
      }
    }

    void onPressOutcome() {}

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: AddButton(
            text: 'Income',
            bgColor: ThemeColors.green,
            callback: onPressIncome,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: AddButton(
            text: 'Outcome',
            bgColor: ThemeColors.red,
            callback: onPressOutcome,
          ),
        ),
      ],
    );
  }
}
