import 'package:intl/intl.dart';

String formateDate(DateTime date) {
  final formatedDate = DateFormat('dd MMMM, yyyy').format(date);

  return formatedDate;
}
