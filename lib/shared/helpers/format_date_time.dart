// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:intl/intl.dart';

class FormatDateTime {
  static String localeWithoutSeparator(dynamic value) {
    final dateFormat = DateFormat('yyyyMMdd');
    if (value == null) {
      return '-';
    } else {
      return dateFormat.format(value);
    }
  }

  static String locale({required DateTime value}) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    try {
      return dateFormat.format(value);
    } catch (e) {
      return dateFormat.format(DateTime.now());
    }
  }

  static DateTime stringDateToDateTime(String date) {
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    var dateTimeConvert;
    if (date.contains('-')) {
      dateTimeConvert = inputFormat.parse(date);
    }
    return dateTimeConvert;
  }

  static String formatDateWithoutSeparator(dynamic value) {
    final dateFormat = DateFormat('yyyyMMdd');
    if (value == null) {
      return '-';
    } else {
      return dateFormat.format(value);
    }
  }

  static String formatDate({required DateTime value}) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    try {
      return dateFormat.format(value);
    } catch (e) {
      return dateFormat.format(DateTime.now());
    }
  }

  static String formatDateWithoutHour({required DateTime value}) {
    final dateFormat = DateFormat('dd-MM-yyyy');
    try {
      return dateFormat.format(value);
    } catch (e) {
      return dateFormat.format(DateTime.now());
    }
  }

  static String formatDateWithoutHourNoSeparator({required DateTime value}) {
    final dateFormat = DateFormat('ddMMyyyy');
    try {
      return dateFormat.format(value);
    } catch (e) {
      return dateFormat.format(DateTime.now());
    }
  }

  static String formatDateMMMWithoutHour({required DateTime value}) {
    final dateFormat = DateFormat('dd-MMM-yyyy');
    try {
      return dateFormat.format(value);
    } catch (e) {
      return dateFormat.format(DateTime.now());
    }
  }

  static String formatDateMMMMWithoutHour({required DateTime value}) {
    final dateFormat = DateFormat('dd MMMM yyyy');
    try {
      return dateFormat.format(value);
    } catch (e) {
      return dateFormat.format(DateTime.now());
    }
  }

  static String formatDateWithoutHouryyyy({required DateTime value}) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    try {
      return dateFormat.format(value);
    } catch (e) {
      return dateFormat.format(DateTime.now());
    }
  }

  static String formatDateNumeric(dynamic value) {
    final dateFormat = DateFormat('yyy-MM-dd');
    if (value == null) {
      return '-';
    } else {
      return dateFormat.format(value);
    }
  }

  static String formatDateyyyy(dynamic value) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    if (value == null) {
      return '-';
    } else {
      return dateFormat.format(value);
    }
  }

  static String getDay(dynamic value) {
    final dateFormat = DateFormat('dd');
    if (value == null) {
      return '-';
    } else {
      return dateFormat.format(value);
    }
  }

  static int getMonth(dynamic value) {
    final dateFormat = DateFormat('MM');
    if (value == null) {
      return 1;
    } else {
      return int.parse(dateFormat.format(value));
    }
  }

  static String formatDateMonth(dynamic value) {
    final dateFormat = DateFormat('MMMM');
    if (value == null) {
      return '-';
    } else {
      return dateFormat.format(value);
    }
  }

  static String formatDateTime(dynamic value) {
    final dateFormat = DateFormat('EEEE dd MMMM yyyy HH:MM');
    if (value == null) {
      return '-';
    } else {
      return dateFormat.format(value);
    }
  }

  static String formatDateTimeWithoutSecond(dynamic value) {
    final dateFormat = DateFormat("yyyy-MM-dd HH:mm");
    if (value == null) {
      return '-';
    } else {
      return dateFormat.format(value);
    }
  }

  static String formatDateTimeInvoice(String value) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime dateTime = dateFormat.parse(value);
    var month;
    var dateTimeConvert;
    if (dateTime.month == 01) {
      month = "Januari";
    } else if (dateTime.month == 02) {
      month = "Februari";
    } else if (dateTime.month == 03) {
      month = "Maret";
    } else if (dateTime.month == 04) {
      month = "April";
    } else if (dateTime.month == 05) {
      month = "Mei";
    } else if (dateTime.month == 06) {
      month = "Juni";
    } else if (dateTime.month == 07) {
      month = "Juli";
    } else if (dateTime.month == 08) {
      month = "Agustus";
    } else if (dateTime.month == 09) {
      month = "September";
    } else if (dateTime.month == 10) {
      month = "Oktober";
    } else if (dateTime.month == 11) {
      month = "November";
    } else if (dateTime.month == 12) {
      month = "Desember";
    }
    dateTimeConvert =
        "${dateTime.day} $month ${dateTime.year} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
    return dateTimeConvert;
  }

  static String dateTimeToString(dynamic value) {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    if (value == null) {
      return '-';
    } else {
      return dateFormat.format(value);
    }
  }

  static DateTime stringToDateTime(String dateTimeString) {
    DateFormat inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    var dateTimeConvert;
    if (dateTimeString.contains('-')) {
      dateTimeConvert = inputFormat.parse(dateTimeString);
    } else {
      String inputStringTime =
          '${dateTimeString.substring(0, 8)}T${dateTimeString.substring(8)}';
      dateTimeConvert = DateTime.parse(inputStringTime);
    }
    return dateTimeConvert;
  }

  static DateTime parseDate({required String dateString}) {
    var inputFormat = DateFormat('dd-MM-yyyy HH:mm:ss');
    return inputFormat.parse(dateString);
  }

  static formatTimer(int number) {
    Duration duration = Duration(seconds: number);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    // if (twoDigitMinutes == "00" && twoDigitSeconds == "00") {
    //   return "00";
    // }
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  static String formatDateLocale(String value) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateTime dateTime = dateFormat.parse(value);
    var month;
    var dateTimeConvert;
    if (dateTime.month == 01) {
      month = "Januari";
    } else if (dateTime.month == 02) {
      month = "Februari";
    } else if (dateTime.month == 03) {
      month = "Maret";
    } else if (dateTime.month == 04) {
      month = "April";
    } else if (dateTime.month == 05) {
      month = "Mei";
    } else if (dateTime.month == 06) {
      month = "Juni";
    } else if (dateTime.month == 07) {
      month = "Juli";
    } else if (dateTime.month == 08) {
      month = "Agustus";
    } else if (dateTime.month == 09) {
      month = "September";
    } else if (dateTime.month == 10) {
      month = "Oktober";
    } else if (dateTime.month == 11) {
      month = "November";
    } else if (dateTime.month == 12) {
      month = "Desember";
    }
    dateTimeConvert = "${dateTime.day} $month ${dateTime.year}";
    return dateTimeConvert;
  }

  static String formatTime({required String dateString}) {
    var inputFormat = DateFormat('dd-MM-yyyy HH:mm:ss');
    DateTime dateTime = inputFormat.parse(dateString);
    var dateTimeConvert = "${dateTime.hour}:${dateTime.minute}";
    return dateTimeConvert;
  }
}
