// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mybudget/src/classes/money_movement.dart';
import 'package:mybudget/src/utils/preferences.dart';

class AppProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Map<String, dynamic>> _incomeList = [];
  List<Map<String, dynamic>> _outcomeList = [];

  List<Map<String, dynamic>> get incomeList => _incomeList;
  List<Map<String, dynamic>> get outcomeList => _outcomeList;

  Future<void> init() async {
    String incomes = await getIncomes();
    List<Map<String, dynamic>> incomeList = incomes.isEmpty ? [] : json.decode(incomes);

    String outcomes = await getOutcomes();
    List<Map<String, dynamic>> outcomeList = outcomes.isEmpty ? [] : json.decode(outcomes);

    _incomeList = incomeList;
    _outcomeList = outcomeList;

    notifyListeners();
  }

  void addIncome(MoneyMovement income) async {
    String incomes = await getIncomes();
    List<dynamic> incomeList = incomes.isEmpty ? [] : json.decode(incomes);

    Map<String, dynamic> incomeJson = {
      'date': income.date.millisecondsSinceEpoch,
      'formattedDate': DateFormat('dd/MM/yyyy').format(income.date),
      'detail': income.detail,
      'amount': income.amount,
    };

    incomeList.add(incomeJson);

    setIncome(json.encode(incomeList));

    incomeList = incomeList;
    notifyListeners();
  }
}
