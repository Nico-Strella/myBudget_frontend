import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mybudget/src/classes/money_movement.dart';
import 'package:mybudget/src/utils/preferences.dart';

class AppProvider with ChangeNotifier {
  final List<MoneyMovement> _incomeList = [];
  final List<MoneyMovement> _outcomeList = [];
  double _totalIncome = 0;
  double _totalOutcome = 0;
  double _myBudget = 0;

  List<MoneyMovement> get incomeList => _incomeList;
  List<MoneyMovement> get outcomeList => _outcomeList;
  double get totalIncome => _totalIncome;
  double get totalOutcome => _totalOutcome;
  double get myBudget => _myBudget;

  Future<void> init() async {
    String incomes = await getIncomes();
    if (incomes.isNotEmpty) {
      dynamic savedIncomeList = incomes.isEmpty ? [] : json.decode(incomes)['incomes'];

      if (savedIncomeList != null && _incomeList.isEmpty) {
        for (var element in savedIncomeList) {
          MoneyMovement mappedElement = MoneyMovement(
            date: DateTime.fromMillisecondsSinceEpoch(element['date']),
            detail: element['detail'],
            amount: element['amount'],
          );
          _totalIncome += mappedElement.amount;
          _incomeList.add(mappedElement);
        }
      }
    }

    String outcomes = await getOutcomes();
    if (outcomes.isNotEmpty) {
      dynamic savedOutcomeList = outcomes.isEmpty ? [] : json.decode(outcomes)['outcomes'];

      if (savedOutcomeList != null && _outcomeList.isEmpty) {
        for (var element in savedOutcomeList) {
          MoneyMovement mappedElement = MoneyMovement(
            date: DateTime.fromMillisecondsSinceEpoch(element['date']),
            detail: element['detail'],
            amount: element['amount'],
          );
          _totalOutcome += mappedElement.amount;
          _outcomeList.add(mappedElement);
        }
      }
    }

    _myBudget = _totalIncome - _totalOutcome;

    notifyListeners();
  }

  // ------- ADD -------

  void addIncome(MoneyMovement income) async {
    _incomeList.add(income);

    List<Map<String, dynamic>> incomeJson = [];

    for (var element in _incomeList) {
      incomeJson.add(element.toMap());
    }

    _totalIncome += income.amount;
    _myBudget = _totalIncome - _totalOutcome;

    setIncome(json.encode({'incomes': incomeJson}));
    notifyListeners();
  }

  void addOutcome(MoneyMovement outcome) async {
    _outcomeList.add(outcome);

    List<Map<String, dynamic>> outcomeJson = [];

    for (var element in _outcomeList) {
      outcomeJson.add(element.toMap());
    }

    _totalOutcome += outcome.amount;
    _myBudget = _totalIncome - _totalOutcome;

    setOutcome(json.encode({'outcomes': outcomeJson}));
    notifyListeners();
  }

  void _updateCookies(String type) {
    switch (type) {
      case 'income':
        {
          List<Map<String, dynamic>> incomeJson = [];

          for (var element in _incomeList) {
            incomeJson.add(element.toMap());
          }

          setIncome(json.encode({'incomes': incomeJson}));
        }
        break;
      case 'outcome':
        {
          List<Map<String, dynamic>> outcomeJson = [];

          for (var element in _outcomeList) {
            outcomeJson.add(element.toMap());
          }

          setOutcome(json.encode({'outcomes': outcomeJson}));
        }
        break;
      default:
        break;
    }
  }

  // ------- EDIT -------

  void editIncomeOutcome(MoneyMovement editedItem, int index, String type) async {
    if (type == 'income') {
      _totalIncome += editedItem.amount - _incomeList[index].amount;

      _incomeList[index] = editedItem;
    } else if (type == 'outcome') {
      _totalOutcome += editedItem.amount - _outcomeList[index].amount;

      _outcomeList[index] = editedItem;
    }

    _myBudget = _totalIncome - _totalOutcome;

    _updateCookies(type);
    notifyListeners();
  }

  // ------- DELETE -------

  void deleteIncomeOutcome(int index, String type) {
    if (type == 'income') {
      _totalIncome -= _incomeList[index].amount;
      _incomeList.removeAt(index);
    } else if (type == 'outcome') {
      _totalOutcome -= _outcomeList[index].amount;
      _outcomeList.removeAt(index);
    }
    _myBudget = _totalIncome - _totalOutcome;
    _updateCookies(type);
    notifyListeners();
  }

  void deleteAllIncomeOutcome({required String type}) {
    if (type == 'Income') {
      _totalIncome = 0;
      _incomeList.clear();
    } else if (type == 'Outcome') {
      _totalOutcome = 0;
      _outcomeList.clear();
    }
    _myBudget = _totalIncome - _totalOutcome;
    _updateCookies(type);
    notifyListeners();
  }
}
