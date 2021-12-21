import 'package:flutter/material.dart';
import 'package:mybudget/src/blocs/app_provider.dart';
import 'package:mybudget/src/utils/colors.dart';
import 'package:mybudget/src/widgets/buttons/add_button.dart';
import 'package:mybudget/src/widgets/dialogs/add_income__outcome_dialog.dart';

class ActionButtons extends StatelessWidget {
  final AppProvider appProvider;
  const ActionButtons({Key? key, required this.appProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onPressIncome() async {
      List<dynamic> response = await AddIncomeOutcomeDialog.addIncomeOutcomeDialog(context, "income");
      if (response.length > 1 && response[0] == AddIncomeOutcomeAction.ok) {
        appProvider.addIncome(response[1]);
      }
    }

    void onPressOutcome() async {
      List<dynamic> response = await AddIncomeOutcomeDialog.addIncomeOutcomeDialog(context, "outcome");
      if (response.length > 1 && response[0] == AddIncomeOutcomeAction.ok) {
        appProvider.addOutcome(response[1]);
      }
    }

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
