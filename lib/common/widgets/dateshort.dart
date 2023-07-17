import 'package:intl/intl.dart';

class DateShort {
  late String dateString;

  DateShort({required this.dateString});

  String dateSh() {
    DateTime date = DateTime.parse(dateString);
    String formattedDate = DateFormat('E MMMM d hh:mm a ').format(date);
    return formattedDate;
  }
}
