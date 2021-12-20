import 'package:mybudget/src/classes/money_movement.dart';
import 'package:mybudget/src/utils/colors.dart';
import 'package:mybudget/src/widgets/dialogs/blured_dialog.dart';
import 'package:flutter/material.dart';

enum AddIncomeAction { ok, cancel }

class AddIncomeDialog {
  static Future<List<dynamic>> addIncomeDialog(BuildContext context) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return BluredDialog(
          child: SimpleDialog(
            contentPadding: const EdgeInsets.all(25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    height: 10,
                  ),
                  AddIncomeForm(),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
    return action ?? [AddIncomeAction.cancel];
  }
}

class AddIncomeForm extends StatefulWidget {
  const AddIncomeForm({Key? key}) : super(key: key);

  @override
  _AddIncomeFormState createState() => _AddIncomeFormState();
}

class _AddIncomeFormState extends State<AddIncomeForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  void _handleOnSave() async {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop([
        AddIncomeAction.ok,
        MoneyMovement(
          date: DateTime.now(),
          detail: _noteController.text,
          amount: double.parse(_amountController.text),
        ),
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 25, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "ADD INCOME",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              children: [
                TextFormField(
                  controller: _noteController,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    labelText: 'Detail',
                    contentPadding: EdgeInsets.only(left: 0),
                  ),
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _amountController,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Income',
                    contentPadding: EdgeInsets.only(left: 0),
                    prefixText: '฿',
                  ),
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 20),
                  validator: (String? value) {
                    if (value != null && value.trim().isEmpty) {
                      return "Income is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: ThemeColors.blue,
                          ),
                          onPressed: _handleOnSave,
                          child: const Text(
                            "Add Income",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: ThemeColors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
