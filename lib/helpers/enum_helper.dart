import 'package:collection/collection.dart' show IterableExtension;
import 'package:prizorsdk_flutter/extensions/string_extensions.dart';

class EnumHelper {
  static String? parse(enumItem) {
    if (enumItem == null) return null;
    return enumItem.toString().split('.')[1];
  }

  static T? fromInt<T>(List<T> enumValues, int value) {
    return enumValues[value];
  }

  static T? fromString<T>(List<T> enumValues, String? value) {
    if (value == null) return null;

    return enumValues.firstWhereOrNull(
      (enumItem) => [
        enumItem.toString().normalized(),
        EnumHelper.parse(enumItem)!.normalized(),
      ].contains(value.normalized()),
    );
  }

  static int? fromStringToInt<T>(List<T> enumValues, String value) {
    for (var i = 0; i < enumValues.length; i++) {
      if (enumValues[i].toString().normalized() == value.normalized()) {
        return i + 1;
      }
    }

    return null;
  }

  static List<T> fromStringList<T>(List<T> enumValues, List<dynamic> values) {
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
