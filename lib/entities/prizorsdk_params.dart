import 'package:flutter/material.dart';
import 'package:prizorsdk_flutter/entities/sac.dart';
import 'package:prizorsdk_flutter/entities/user/user.dart';
import 'package:prizorsdk_flutter/helpers/enum_helper.dart';

import 'enums/environment.dart';

class PrizorSdkParams {
  /// Environment of the app: [production, stage, development, master]. Use [Environment.production] for production.
  final Environment? environment;

  /// App ID provided by CRMALL.
  final String appId;

  /// App secret provided by CRMALL.
  final String secret;

  /// App name to be shown in the app.
  final String appName;

  /// Primary color of the app, used in AppBar, buttons, icons, etc.
  final Color accentColor;

  /// Foreground color of the app.
  final Color accentForegroundColor;

  /// User data to be used in the app campaigns.
  final User user;

  /// Image in the campaigns. If it is null, the logo will not be shown. USE PNG FORMAT.
  final Uri? appLogo;

  /// Image in the home screen. If it is null, the brand will not be shown. USE PNG FORMAT.
  final Uri? appBrand;

  /// Splash screen foreground color. If it is null, [accentColor] will be used.
  final Color? splashForegroundColor;

  /// Splash screen background color. If it is null, [accentForegroundColor] will be used.
  final Color? splashBackgroundColor;

  /// SAC data to be used in the app campaigns.
  final Sac? sac;

  /// If it is true, the app will be opened in the root route Use with BottomNavigationBar, TabBar, etc.
  final bool isRootRoute;

  /// If it is true, the app will be opened in the title route Use with AppBar, etc.
  final String titleRoute;

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
    this.isRootRoute = false,
    this.titleRoute = '',
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
      'isRootRoute': isRootRoute,
      'titleRoute': titleRoute,
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
      isRootRoute: json['isRootRoute'],
    );
  }
}
