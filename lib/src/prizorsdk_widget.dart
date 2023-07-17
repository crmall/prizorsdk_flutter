import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';

import '../entities/prizorsdk_params.dart';
import '../helpers/crmall_encrypter.dart';
import 'prizor_loading_widget.dart';

class PrizorSdkWidget extends StatefulWidget {
  /// [PrizorSdkWidget] is the main widget of the Prizor SDK.
  /// It is responsible for the communication between the SDK and the app.
  /// It receives a [PrizorSdkParams] object as a parameter.
  /// It also receives an optional [androidAPIErrorCallback] function that will be called if the Android API version is lower than 29.
  final PrizorSdkParams params;

  final Function? androidAPIErrorCallback;

  const PrizorSdkWidget({
    required this.params,
    this.androidAPIErrorCallback,
    super.key,
  });

  @override
  PrizorSdkWidgetState createState() => PrizorSdkWidgetState();
}

class PrizorSdkWidgetState extends State<PrizorSdkWidget> {
  final GlobalKey _webViewKey = GlobalKey();
  double _progress = 0.0;

  String _paramsToUri() {
    var token = "token=${Uri.encodeComponent(CrmallEncrypter.encrypt(jsonEncode(widget.params))!)}";
    return token;
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

  Color get backgroundColor => const Color(0xFFE5E5E5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _progress < 1.0 ? Colors.white : backgroundColor,
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
      body: Stack(
        children: [
          InAppWebView(
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
            onProgressChanged: (controller, progress) {
              setState(() {
                _progress = progress / 100;
              });
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
          _progress < 1.0
              ? PrizorLoadingWidget(
                  accentColor: widget.params.accentColor,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
