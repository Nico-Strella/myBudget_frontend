import 'package:csv/csv.dart';
import 'package:intl/intl.dart';

class CsvConverter {
  static String buildCsv({dynamic data}) {
    List<List<dynamic>> listToBeConverted = _getList(data);

    String csv = const ListToCsvConverter().convert(listToBeConverted);
    return csv;
  }

  static List<List<dynamic>> _getList(dynamic data) {
    List<List<dynamic>> resultList = [];

    if (data != null) {
      for (var element in data) {
        List<dynamic> row = [
          DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(element['date'])),
          element['detail'],
          element['amount'],
        ];

        resultList.add(row);
      }
    }

    return resultList;
  }
}
