import 'package:collection/collection.dart' show IterableExtension;
import 'package:prizorsdk_flutter/extensions/string_extensions.dart';

class EnumHelper {
  static String? parse(enumItem) {
    /// Returns the name of the enum item.
    /// It receives an [enumItem] as a parameter.
    /// It returns a [String] with the name of the enum item.
    /// If the [enumItem] is null, it returns null.
    if (enumItem == null) return null;
    return enumItem.toString().split('.')[1];
  }

  static T? fromInt<T>(List<T> enumValues, int value) {
    /// Returns the enum item from an [int] value.
    /// It receives a [List] of enum values and an [int] value as parameters.
    /// It returns the enum item.
    /// If the [value] is null, it returns null.
    return enumValues[value];
  }

  static T? fromString<T>(List<T> enumValues, String? value) {
    /// Returns the enum item from a [String] value.
    /// It receives a [List] of enum values and a [String] value as parameters.
    /// It returns the enum item.
    /// If the [value] is null, it returns null.
    if (value == null) return null;

    return enumValues.firstWhereOrNull(
      (enumItem) => [
        enumItem.toString().normalized(),
        EnumHelper.parse(enumItem)!.normalized(),
      ].contains(value.normalized()),
    );
  }

  static int? fromStringToInt<T>(List<T> enumValues, String value) {
    /// Returns the enum item from a [String] value.
    /// It receives a [List] of enum values and a [String] value as parameters.
    /// It returns the enum item.
    /// If the [value] is null, it returns null.
    for (var i = 0; i < enumValues.length; i++) {
      if (enumValues[i].toString().normalized() == value.normalized()) {
        return i + 1;
      }
    }

    return null;
  }

  static List<T> fromStringList<T>(List<T> enumValues, List<dynamic> values) {
    /// Returns a list of enum items from a list of [String] values.
    /// It receives a [List] of enum values and a [List] of [String] values as parameters.
    /// It returns a [List] of enum items.
    /// If the [values] is null, it returns an empty list.

    if (values.isEmpty) return [];

    List<T> listItems = [];

    for (var enumItem in enumValues) {
      String? result = values.cast<String>().firstWhereOrNull(
            (value) => value.normalized() == EnumHelper.parse(enumItem)!.normalized(),
          );
      if (result != null) {
        listItems.add(enumItem);
      }
    }

    return listItems;
  }
}
