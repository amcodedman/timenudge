import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateShort {
  late String dateString;

  DateShort({required this.dateString});

  String dateSh() {
    String dat = "";
    if (!dateString.isNull) {
      DateTime date = DateTime.parse(dateString);
      dat = DateFormat('E MMMM d hh:mm a ').format(date);
    }

    return dat;
  }
}
