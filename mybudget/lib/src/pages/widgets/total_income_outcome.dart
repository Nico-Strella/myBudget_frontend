import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mybudget/src/blocs/app_provider.dart';
import 'package:mybudget/src/utils/colors.dart';
import 'package:provider/provider.dart';

class TotalIncomeOutcome extends StatefulWidget {
  const TotalIncomeOutcome({Key? key}) : super(key: key);

  @override
  State<TotalIncomeOutcome> createState() => _TotalIncomeOutcomeState();
}

class _TotalIncomeOutcomeState extends State<TotalIncomeOutcome> {
  @override
  Widget build(BuildContext context) {
    final _appProvider = Provider.of<AppProvider>(context);

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        color: ThemeColors.white,
      ),
      padding: const EdgeInsets.all(10),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const Text(
                  'Total Income:',
                  style: TextStyle(fontWeight: FontWeight.bold, color: ThemeColors.lightgrey),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '฿ ${NumberFormat("#,##0.00", "en_US").format(_appProvider.totalIncome)}',
                  style: const TextStyle(color: ThemeColors.green),
                ),
              ],
            ),
            const VerticalDivider(
              width: 20,
            ),
            Column(
              children: [
                const Text(
                  'Total Outcome:',
                  style: TextStyle(fontWeight: FontWeight.bold, color: ThemeColors.lightgrey),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '฿ ${NumberFormat("#,##0.00", "en_US").format(_appProvider.totalOutcome)}',
                  style: const TextStyle(color: ThemeColors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
