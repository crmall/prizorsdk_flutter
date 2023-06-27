import 'package:flutter/material.dart';
import 'package:prizorsdk_flutter/entities/sac.dart';
import 'package:prizorsdk_flutter/entities/user/user.dart';
import 'package:prizorsdk_flutter/helpers/enum_helper.dart';

import 'enums/environment.dart';

class PrizorSdkParams {
  final Environment? environment;
  final String? appId;
  final String? secret;
  final String? appName;
  final Color accentColor;
  final Color accentForegroundColor;
  final User user;
  final Uri? appLogo;
  final Uri? appBrand;
  final Color? splashForegroundColor;
  final Color? splashBackgroundColor;
  final Sac? sac;

  const PrizorSdkParams({
    required this.environment,
    required this.appId,
    required this.secret,
    required this.appName,
    required this.accentColor,
    required this.accentForegroundColor,
    required this.user,
    this.appLogo,
    this.appBrand,
    this.splashForegroundColor,
    this.splashBackgroundColor,
    this.sac,
  });

  Map<String, dynamic> toJson() {
    return {
      'environment': environment!.name,
      'appId': appId,
      'secret': secret,
      'appName': appName,
      'accentColor': accentColor.value.toRadixString(16),
      'accentForegroundColor': accentForegroundColor.value.toRadixString(16),
      'user': user.toJson(),
      'appLogo': appLogo?.toString(),
      'appBrand': appBrand?.toString(),
      'splashForegroundColor': splashForegroundColor?.value.toRadixString(16),
      'splashBackgroundColor': splashBackgroundColor?.value.toRadixString(16),
      'sac': sac?.toJson(),
    };
  }

  factory PrizorSdkParams.fromJson(Map<String, dynamic> json) {
    return PrizorSdkParams(
      environment: EnumHelper.fromString(Environment.values, json['environment']),
      appId: json['appId'],
      secret: json['secret'],
      appName: json['appName'],
      accentColor: Color(json['accentColor']),
      accentForegroundColor: Color(json['accentForegroundColor']),
      user: User.fromJson(json['user']),
      appLogo: Uri.tryParse(json['appLogo']),
      appBrand: Uri.tryParse(json['appBrand']),
      splashForegroundColor: Color(json['splashForegroundColor']),
      splashBackgroundColor: Color(json['splashBackgroundColor']),
      sac: Sac.fromJson(json['sac']),
    );
  }
}
