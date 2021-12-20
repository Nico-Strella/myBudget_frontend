import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mybudget/src/utils/colors.dart';
import 'package:mybudget/src/widgets/expandable/expandable.dart';

class Body extends StatelessWidget {
  final appProvider;
  const Body({Key? key, required this.appProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        color: ThemeColors.white,
      ),
      child: Column(
        children: [
          Expandable(
            text: 'Income',
            child: ListView.builder(
              itemBuilder: (BuildContext ctxt, int index) {
                return Row(
                  children: [
                    Text(
                      DateFormat('dd/MM').format(appProvider.incomeList[index]['date']),
                    ),
                    Text(
                      appProvider.incomeList[index]['detail'],
                    ),
                    Expanded(
                      child: Text('฿ ${appProvider.incomeList[index]['amount']}'),
                    ),
                  ],
                );
              },
              itemCount: appProvider.incomeList.length,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expandable(
            text: 'Outcome',
            child: ListView.builder(
              itemBuilder: (BuildContext ctxt, int index) {
                return Row(
                  children: [
                    Text(
                      DateFormat('dd/MM').format(appProvider.outcomeList[index]['date']),
                    ),
                    Text(
                      appProvider.outcomeList[index]['detail'],
                    ),
                    Expanded(
                      child: Text('฿ ${appProvider.outcomeList[index]['amount']}'),
                    ),
                  ],
                );
              },
              itemCount: appProvider.outcomeList.length,
            ),
          ),
        ],
      ),
    );
  }
}
