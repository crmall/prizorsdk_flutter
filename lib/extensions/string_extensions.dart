import 'package:diacritic/diacritic.dart';

extension StringExtensions on String {
  String normalized() {
    /// Returns a normalized [String].
    /// It receives a [String] as a parameter.
    /// It returns a [String] with the diacritics removed and all characters in lowercase.
    /// If the [String] is null, it returns an empty [String].
    return removeDiacritics(this).toLowerCase();
  }

  int compareToNormalized(String to) {
    /// Returns the comparison between two normalized [String].
    /// It receives a [String] as a parameter.
    /// It returns an [int] with the comparison between the two normalized [String].
    /// If the [String] is null, it returns an empty [String].
    return normalized().compareTo(to.normalized());
  }

  bool equalsNormalized(String to) {
    /// Returns a boolean indicating if two normalized [String] are equal.
    /// It receives a [String] as a parameter.
    /// It returns a [bool] indicating if the two normalized [String] are equal.
    return compareToNormalized(to) == 0;
  }

  bool equals(String to) {
    /// Returns a boolean indicating if two [String] are equal.
    /// It receives a [String] as a parameter.
    /// It returns a [bool] indicating if the two [String] are equal.
    /// If the [String] is null, it returns an empty [String].
    return compareTo(to) == 0;
  }

  String get onlyNumbers => replaceAll(RegExp(r"[^0-9]"), "");

  /// Returns a [String] with only numbers.

  bool get hasOnlyNumbers => (onlyNumbers.isNotEmpty) && onlyNumbers.equals(this);

  /// Returns a boolean indicating if the [String] has only numbers.
}
