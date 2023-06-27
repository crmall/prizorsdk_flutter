import 'package:diacritic/diacritic.dart';

extension StringExtensions on String {
  String normalized() {
    return removeDiacritics(this).toLowerCase();
  }

  int compareToNormalized(String to) {
    return normalized().compareTo(to.normalized());
  }

  bool equalsNormalized(String to) {
    return compareToNormalized(to) == 0;
  }

  bool equals(String to) {
    return compareTo(to) == 0;
  }

  String get onlyNumbers => replaceAll(RegExp(r"[^0-9]"), "");

  bool get hasOnlyNumbers => (onlyNumbers.isNotEmpty) && onlyNumbers.equals(this);
}
