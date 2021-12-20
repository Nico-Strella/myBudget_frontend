import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> getSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs;
}

void setIncome(String incomes) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("incomes", incomes);
}

void setOutcome(String outcomes) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("outcomes", outcomes);
}

Future<String> getIncomes() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? incomes = prefs.getString("incomes");
  return incomes ?? '';
}

Future<String> getOutcomes() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? outcomes = prefs.getString("outcomes");
  return outcomes ?? '';
}
