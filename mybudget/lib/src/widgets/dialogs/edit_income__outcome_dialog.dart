import 'package:flutter/services.dart';
import 'package:mybudget/src/classes/money_movement.dart';
import 'package:mybudget/src/utils/colors.dart';
import 'package:mybudget/src/widgets/dialogs/blured_dialog.dart';
import 'package:flutter/material.dart';

enum EditIncomeOutcomeAction { ok, cancel }

class EditIncomeOutcomeDialog {
  static Future<List<dynamic>> editIncomeOutcomeDialog(BuildContext context, String type, MoneyMovement itemToEdit) async {
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
                  EditIncomeOutcomeForm(
                    type: type,
                    itemToEdit: itemToEdit,
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
    return action ?? [EditIncomeOutcomeAction.cancel];
  }
}

class EditIncomeOutcomeForm extends StatefulWidget {
  final String type;
  final MoneyMovement itemToEdit;
  const EditIncomeOutcomeForm({Key? key, required this.type, required this.itemToEdit}) : super(key: key);

  @override
  _EditIncomeOutcomeFormState createState() => _EditIncomeOutcomeFormState();
}

class _EditIncomeOutcomeFormState extends State<EditIncomeOutcomeForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _detailController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  void _handleOnSave() async {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop([
        EditIncomeOutcomeAction.ok,
        MoneyMovement(
          date: DateTime.now(),
          detail: _detailController.text,
          amount: double.parse(_amountController.text),
        ),
      ]);
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _detailController.text = widget.itemToEdit.detail;
      _amountController.text = widget.itemToEdit.amount.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 25, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.type == 'income' ? 'EDIT INCOME' : 'EDIT OUTCOME',
            style: const TextStyle(
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
                  ),
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 20),
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
                          child: Text(
                            widget.type == 'income' ? 'Edit Income' : 'Edit Outcome',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: ThemeColors.white, fontSize: 20),
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