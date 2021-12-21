import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mybudget/src/utils/colors.dart';
import 'package:mybudget/src/utils/csv_converter.dart';
import 'package:mybudget/src/utils/email_client.dart';
import 'package:mybudget/src/utils/preferences.dart';
import 'package:path_provider/path_provider.dart';

class SubActionButtons extends StatelessWidget {
  const SubActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void sendEmail() async {
      String today = DateTime.now().millisecondsSinceEpoch.toString();
      List<String> attachmentPaths = [];

      String appDocumentsDirectory = await getTemporaryDirectory().then((directory) => directory.path);

      // INCOMES
      String incomes = await getIncomes();
      dynamic incomeList = json.decode(incomes)['incomes'];
      final incomeFilePath = "$appDocumentsDirectory/IncomeLogs_$today.csv";
      final incomeFile = File(incomeFilePath);

      // OUTCOMES
      String outcomes = await getOutcomes();
      dynamic outcomeList = json.decode(outcomes)['outcomes'];
      final outcomeFilePath = "$appDocumentsDirectory/OutcomeLogs_$today.csv";
      final outcomeFile = File(outcomeFilePath);

      String incomeCsv = CsvConverter.buildCsv(data: incomeList);
      await incomeFile.writeAsString(incomeCsv);
      if (incomeCsv != "") {
        attachmentPaths.add(incomeFilePath);
      }

      String outcomeCsv = CsvConverter.buildCsv(data: outcomeList);
      await outcomeFile.writeAsString(outcomeCsv);
      if (outcomeCsv != "") {
        attachmentPaths.add(outcomeFilePath);
      }

      EmailClient.sendEmail(attachmentPaths: attachmentPaths);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(10),
            primary: ThemeColors.blue,
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: () => sendEmail(),
          child: const Icon(
            Icons.email,
            size: 40,
            color: ThemeColors.white,
          ),
        ),
      ],
    );
  }
}
