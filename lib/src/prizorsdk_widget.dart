import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prizorsdk_flutter/entities/prizorsdk_params.dart';
import 'package:prizorsdk_flutter/helpers/crmall_encrypter.dart';

class PrizorSdkWidget extends StatefulWidget {
  const PrizorSdkWidget({
    required this.params,
    this.androidAPIErrorCallback,
    super.key,
  });

  final PrizorSdkParams params;
  final Function? androidAPIErrorCallback;

  @override
  PrizorSdkWidgetState createState() => PrizorSdkWidgetState();
}

class PrizorSdkWidgetState extends State<PrizorSdkWidget> {
  final GlobalKey _webViewKey = GlobalKey();

  String _paramsToUri() {
    return "token=${Uri.encodeComponent(CrmallEncrypter.encrypt(jsonEncode(widget.params))!)}";
  }

  Future<void> checkVersion() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    if (androidInfo.version.sdkInt < 29 && context.mounted) {
      Navigator.pop(context);
      if (widget.androidAPIErrorCallback != null) {
        widget.androidAPIErrorCallback!();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      checkVersion();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      body: InAppWebView(
        key: _webViewKey,
        initialUrlRequest: URLRequest(url: WebUri("https://static-sdk.prizor.com/#/splash?${_paramsToUri()}")),
        initialSettings: InAppWebViewSettings(
          mediaPlaybackRequiresUserGesture: false,
          allowsInlineMediaPlayback: true,
        ),
        onLoadStart: (controller, url) {
          if (url?.authority == "prizorsdk.close") {
            controller.stopLoading();
            Navigator.pop(context);
          }
        },
        onPermissionRequest: (controller, request) async {
          final resources = <PermissionResourceType>[];
          if (request.resources.contains(PermissionResourceType.CAMERA)) {
            final cameraStatus = await Permission.camera.request();
            if (!cameraStatus.isDenied) {
              resources.add(PermissionResourceType.CAMERA);
            }
          }
          if (request.resources.contains(PermissionResourceType.MICROPHONE)) {
            final microphoneStatus = await Permission.microphone.request();
            if (!microphoneStatus.isDenied) {
              resources.add(PermissionResourceType.MICROPHONE);
            }
          }
          if (request.resources.contains(PermissionResourceType.CAMERA_AND_MICROPHONE)) {
            final cameraStatus = await Permission.camera.request();
            final microphoneStatus = await Permission.microphone.request();
            if (!cameraStatus.isDenied && !microphoneStatus.isDenied) {
              resources.add(PermissionResourceType.CAMERA_AND_MICROPHONE);
            }
          }

          return PermissionResponse(
            resources: resources,
            action: resources.isEmpty ? PermissionResponseAction.DENY : PermissionResponseAction.GRANT,
          );
        },
      ),
    );
  }
}
