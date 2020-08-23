import 'package:intl/intl.dart';

class DateTimeHelper {
  static DateTime get now => DateTime.now();

  static String get nowFormatddMMyyyy => DateFormat('dd-MM-yyyy').format(now);

  static String get nowFormatyyyyMMdd => DateFormat('yyyy-MM-dd').format(now);

  static String datetimeToyyyyMMdd(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static String format12HourClock(String formattedString) {
    final date = DateTime.parse(formattedString);
    return DateFormat().add_j().format(date);
  }

  static int getHour(String formattedString) {
    return DateTime.parse(formattedString).hour;
  }

  static DateTime dateTimeFromString(String formattedString) {
    return DateTime.parse(formattedString);
  }

  static DateTime dateTimeddMMyyyyFromString(String formattedString) =>
      DateFormat('dd-MM-yyyy').parse(formattedString);

  static double hourToDoubleFromDateTime(DateTime myTime) =>
      myTime.hour + myTime.minute / 60.0;

  static double hourToDoubleFromDateString(String formattedString) {
    return DateTime.parse(formattedString).hour +
        DateTime.parse(formattedString).minute / 60.0;
  }
}
