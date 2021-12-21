import 'package:intl/intl.dart';

class MoneyMovement {
  late DateTime date;
  late String detail;
  late double amount;

  MoneyMovement({
    required this.date,
    required this.detail,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date.millisecondsSinceEpoch,
      'formattedDate': DateFormat('dd/MM/yyyy').format(date),
      'detail': detail,
      'amount': amount,
    };
  }
}
