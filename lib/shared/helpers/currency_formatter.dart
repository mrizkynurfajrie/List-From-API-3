// ignore_for_file: unnecessary_null_comparison

import 'package:intl/intl.dart';

class IDRCurrencyFormat {
  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'IDR ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }
}

class VNDCurrencyFormat {
  static String convertToVnd(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'vi',
      symbol: 'VND ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }
}
