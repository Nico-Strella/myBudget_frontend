import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
import 'package:mybudget/src/blocs/app_provider.dart';
import 'package:mybudget/src/utils/colors.dart';
import 'package:provider/provider.dart';

class DateFilter extends StatefulWidget {
  const DateFilter({Key? key}) : super(key: key);

  @override
  State<DateFilter> createState() => _DateFilterState();
}

class _DateFilterState extends State<DateFilter> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Filter')),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(0),
          color: ThemeColors.yellow,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () async {
                      await Provider.of<AppProvider>(context, listen: false).clearFilter();
                      Navigator.pop(context);
                    },
                    child: const Text('Clear Filter'),
                  ),
                ],
              ),
              dp.MonthPicker.single(
                selectedDate: Provider.of<AppProvider>(context, listen: false).selectedFilter ?? DateTime.now(),
                firstDate: DateTime(2021),
                lastDate: DateTime.now(),
                onChanged: (dateTime) {
                  setState(() {
                    Provider.of<AppProvider>(context, listen: false).setFilter(dateTime);
                    Timer(const Duration(milliseconds: 50), () {
                      Navigator.pop(context);
                    });
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
