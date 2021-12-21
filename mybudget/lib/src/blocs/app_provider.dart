import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mybudget/src/classes/money_movement.dart';
import 'package:mybudget/src/utils/preferences.dart';

class AppProvider with ChangeNotifier {
  final List<MoneyMovement> _incomeList = [];
  final List<MoneyMovement> _outcomeList = [];

  List<MoneyMovement> get incomeList => _incomeList;
  List<MoneyMovement> get outcomeList => _outcomeList;

  Future<void> init() async {
    String incomes = await getIncomes();
    if (incomes.isNotEmpty) {
      dynamic incomeList = incomes.isEmpty ? [] : json.decode(incomes)['incomes'];

      if (incomeList != null) {
        for (var element in incomeList) {
          MoneyMovement mappedElement = MoneyMovement(
            date: DateTime.fromMillisecondsSinceEpoch(element['date']),
            detail: element['detail'],
            amount: element['amount'],
          );
          _incomeList.add(mappedElement);
        }
      }
    }

    String outcomes = await getOutcomes();
    if (outcomes.isNotEmpty) {
      dynamic outcomeList = outcomes.isEmpty ? [] : json.decode(outcomes)['outcomes'];

      if (outcomeList != null) {
        for (var element in outcomeList) {
          MoneyMovement mappedElement = MoneyMovement(
            date: DateTime.fromMillisecondsSinceEpoch(element['date']),
            detail: element['detail'],
            amount: element['amount'],
          );
          _outcomeList.add(mappedElement);
        }
      }
    }

    notifyListeners();
  }

  // ------- ADD -------

  void addIncome(MoneyMovement income) async {
    _incomeList.add(income);

    List<Map<String, dynamic>> incomeJson = [];

    for (var element in _incomeList) {
      incomeJson.add(element.toMap());
    }

    setIncome(json.encode({'incomes': incomeJson}));
    notifyListeners();
  }

  void addOutcome(MoneyMovement outcome) async {
    _outcomeList.add(outcome);

    List<Map<String, dynamic>> outcomeJson = [];

    for (var element in _outcomeList) {
      outcomeJson.add(element.toMap());
    }

    setOutcome(json.encode({'outcomes': outcomeJson}));
    notifyListeners();
  }

  // ------- EDIT -------

  void editIncome(MoneyMovement income) async {
    print(income);
    // _incomeList.add(income);

    // List<Map<String, dynamic>> incomeJson = [];

    // for (var element in _incomeList) {
    //   incomeJson.add(element.toMap());
    // }

    // setIncome(json.encode({'incomes': incomeJson}));
    // notifyListeners();
  }
}