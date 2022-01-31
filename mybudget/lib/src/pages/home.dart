import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mybudget/src/blocs/app_provider.dart';
import 'package:mybudget/src/pages/widgets/action_buttons.dart';
import 'package:mybudget/src/pages/widgets/body.dart';
import 'package:mybudget/src/pages/widgets/filter.dart';
import 'package:mybudget/src/pages/widgets/my_budget.dart';
import 'package:mybudget/src/pages/widgets/sub_action_buttons.dart';
import 'package:mybudget/src/pages/widgets/total_income_outcome.dart';
import 'package:mybudget/src/utils/colors.dart';

class Home extends StatelessWidget {
  final AppProvider appProvider;
  const Home({Key? key, required this.appProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          padding: const EdgeInsets.all(20),
          color: ThemeColors.yellow,
          child: Column(
            children: [
              const ActionButtons(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: appProvider.selectedFilter == null
                        ? Container()
                        : Text(
                            DateFormat.yMMMM().format(
                              appProvider.selectedFilter ?? DateTime.now(),
                            ),
                            style: const TextStyle(color: ThemeColors.blue, fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DateFilter(appProvider: appProvider)),
                      );
                    },
                    style: TextButton.styleFrom(backgroundColor: ThemeColors.green),
                    child: const Text(
                      'Filter',
                      style: TextStyle(color: ThemeColors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Body(appProvider: appProvider),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const TotalIncomeOutcome(),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Expanded(child: MyBudget()),
                      SizedBox(
                        width: 10,
                      ),
                      SubActionButtons(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
