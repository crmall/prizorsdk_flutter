import 'package:prizorsdk_flutter/entities/enums/gender.dart';
import 'package:prizorsdk_flutter/entities/enums/marital_status.dart';
import 'package:prizorsdk_flutter/entities/user/address.dart';
import 'package:prizorsdk_flutter/entities/user/email.dart';
import 'package:prizorsdk_flutter/entities/user/phone.dart';
import 'package:prizorsdk_flutter/helpers/enum_helper.dart';

class User {
  /// [cellphone] is required because it is used to send the Authentication Code
  final String cellphone;

  /// [documentNumber] is required because it is used to Authentication and to match the user in the app
  final String documentNumber;
  final String? name;
  final String? otherDocument;
  final Gender? gender;
  final MaritalStatus? maritalStatus;

  /// Birthday: [day], [month] and [year] are required because it is used to Authentication and to match the user in the app
  final int? day;
  final int? month;
  final int? year;
  final String? occupation;
  final List<Phone>? phones;
  final List<Email>? emails;
  final List<Address>? addresses;

  const User({
    required this.cellphone,
    required this.documentNumber,
    this.name,
    this.otherDocument,
    this.gender,
    this.maritalStatus,
    this.day,
    this.month,
    this.year,
    this.occupation,
    this.phones,
    this.emails,
    this.addresses,
  });

  Map<String, dynamic> toJson() {
    return {
      'cellphone': cellphone,
      'documentNumber': documentNumber,
      'name': name,
      'otherDocument': otherDocument,
      'gender': gender != null ? EnumHelper.fromStringToInt(Gender.values, gender.toString()) : null,
      'maritalStatus': maritalStatus != null ? EnumHelper.fromStringToInt(MaritalStatus.values, maritalStatus.toString()) : null,
      'day': day,
      'month': month,
      'year': year,
      'occupation': occupation,
      'phones': phones?.map((phone) => phone.toJson()).toList(),
      'emails': emails?.map((email) => email.toJson()).toList(),
      'addresses': addresses?.map((address) => address.toJson()).toList(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      cellphone: json['cellphone'],
      documentNumber: json['documentNumber'],
      name: json['name'],
      otherDocument: json['otherDocument'],
      gender: json['gender'] != null ? EnumHelper.fromString(Gender.values, json['gender']) : null,
      maritalStatus: json['maritalStatus'] != null ? EnumHelper.fromString(MaritalStatus.values, json['maritalStatus']) : null,
      day: json['day'],
      month: json['month'],
      year: json['year'],
      occupation: json['occupation'],
      phones: (json['phones'] as List<dynamic>).map((phoneJson) => Phone.fromJson(phoneJson)).toList(),
      emails: (json['emails'] as List<dynamic>).map((emailJson) => Email.fromJson(emailJson)).toList(),
      addresses: (json['addresses'] as List<dynamic>).map((addressJson) => Address.fromJson(addressJson)).toList(),
    );
  }
}
