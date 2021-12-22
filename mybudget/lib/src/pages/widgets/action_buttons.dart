import 'package:flutter/material.dart';
import 'package:mybudget/src/blocs/app_provider.dart';
import 'package:mybudget/src/utils/colors.dart';
import 'package:mybudget/src/widgets/buttons/add_button.dart';
import 'package:mybudget/src/widgets/dialogs/add_income__outcome_dialog.dart';
import 'package:provider/provider.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appProvider = Provider.of<AppProvider>(context);

    void onPressIncome() async {
      List<dynamic> response = await AddIncomeOutcomeDialog.addIncomeOutcomeDialog(context, "income");
      if (response.length > 1 && response[0] == AddIncomeOutcomeAction.ok) {
        _appProvider.addIncome(response[1]);
      }
    }

    void onPressOutcome() async {
      List<dynamic> response = await AddIncomeOutcomeDialog.addIncomeOutcomeDialog(context, "outcome");
      if (response.length > 1 && response[0] == AddIncomeOutcomeAction.ok) {
        _appProvider.addOutcome(response[1]);
      }
    }

    return SizedBox(
      height: 70,
      child: Row(
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
      ),
    );
  }
}
