import 'package:flutter/services.dart';
import 'package:mybudget/src/classes/money_movement.dart';
import 'package:mybudget/src/utils/colors.dart';
import 'package:mybudget/src/widgets/dialogs/blured_dialog.dart';
import 'package:flutter/material.dart';

enum AddIncomeOutcomeAction { ok, cancel }

class AddIncomeOutcomeDialog {
  static Future<List<dynamic>> addIncomeOutcomeDialog(BuildContext context, String type) async {
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
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  AddIncomeOutcomeForm(
                    type: type,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
    return action ?? [AddIncomeOutcomeAction.cancel];
  }
}

class AddIncomeOutcomeForm extends StatefulWidget {
  final String type;
  const AddIncomeOutcomeForm({Key? key, required this.type}) : super(key: key);

  @override
  _AddIncomeOutcomeFormState createState() => _AddIncomeOutcomeFormState();
}

class _AddIncomeOutcomeFormState extends State<AddIncomeOutcomeForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _detailController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  void _handleOnSave() async {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop([
        AddIncomeOutcomeAction.ok,
        MoneyMovement(
          date: DateTime.now(),
          detail: _detailController.text,
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
          Text(
            widget.type == 'income' ? 'ADD INCOME' : 'ADD OUTCOME',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: widget.type == 'income' ? ThemeColors.green : ThemeColors.red,
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
                  controller: _detailController,
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
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  decoration: InputDecoration(
                    labelText: widget.type == 'income' ? 'Income' : 'Outcome',
                    contentPadding: const EdgeInsets.only(left: 0),
                    prefixText: '฿',
                    prefixStyle: TextStyle(
                      fontSize: 18,
                      color: widget.type == 'income' ? ThemeColors.green : ThemeColors.red,
                    ),
                  ),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20,
                    color: widget.type == 'income' ? ThemeColors.green : ThemeColors.red,
                  ),
                  validator: (String? value) {
                    if (value != null && value.trim().isEmpty) {
                      return widget.type == 'income' ? 'Income is required' : 'Outcome is required';
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
                            'SAVE',
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
