import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mybudget/src/blocs/app_provider.dart';
import 'package:mybudget/src/utils/colors.dart';
import 'package:provider/provider.dart';

class MyBudget extends StatelessWidget {
  const MyBudget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appProvider = Provider.of<AppProvider>(context);
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        color: ThemeColors.white,
      ),
      child: Row(
        children: [
          const AutoSizeText(
            'My Budget:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: ThemeColors.blue, letterSpacing: -1),
            maxLines: 2,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: AutoSizeText(
              '฿ ${NumberFormat("#,##0.00", "en_US").format(_appProvider.myBudget)}',
              style: TextStyle(
                color: _appProvider.myBudget < 0 ? ThemeColors.red : ThemeColors.green,
                fontSize: 20,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
