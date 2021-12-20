import 'package:intl/intl.dart';

class MoneyMovement {
  late DateTime date;
  late String? detail = '';
  late double amount;

  MoneyMovement({required this.date, required this.amount, this.detail});

  MoneyMovement.fromMap(Map<String, dynamic> result)
      : date = DateTime(result['date']),
        detail = result['detail'],
        amount = double.parse(result['amount']);

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'formattedDate': DateFormat('dd/MM/yyyy').format(date),
      'detail': detail,
      'amount': amount,
    };
  }
}
