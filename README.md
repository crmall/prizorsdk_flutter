# Prizor SDK Flutter

![Prizor SDK Logo](https://maven.prizor.com/assets/sdkbrand.png)

<p align="center">
<a href="https://pub.dev/packages/prizorsdk_flutter"><img src="https://img.shields.io/badge/pub.dev-0096FF" alt="Pub"></a>
<a href="https://github.com/crmall/prizorsdk_flutter"><img src="https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white" alt="GitHub"></a>
<a href="https://prizor.com"><img src="https://img.shields.io/badge/Prizor%20Website-ffdb76" alt="Prizor Website"></a>
<a href="https://crmall.com"><img src="https://img.shields.io/badge/CRMall%20Website-3098DD" alt="CRMall Website"></a>
</p>

Prizor SDK Flutter is a powerful Flutter plugin that seamlessly integrates with PrizorSDK, providing advanced features for your mobile applications. This documentation will guide you through the process of integrating and utilizing the PrizorSDK in your Flutter projects.

## Features

- Seamless integration with PrizorSDK
- Supports iOS 14.3 and above
- Supports Android API 29 and above

## Getting Started

### Android

To ensure compatibility with Prizor SDK Flutter on Android, make sure you have the following configurations in your Android project:

- Set `compileSdkVersion` and `targetSdkVersion` to 33 or newer.
- `minSdkVersion` must be at least 21.
- Kotlin version must be at least 1.8.0.

Add the following permissions to your Android manifest file:

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
<uses-permission android:name="android.permission.VIDEO_CAPTURE" />
<uses-permission android:name="android.permission.AUDIO_CAPTURE" />

<uses-feature
    android:name="android.hardware.camera"
    android:required="true" />
```

Inside the `<application>` tag of your Android manifest, add the following metadata and provider:

```xml
<meta-data
    android:name="flutterEmbedding"
    android:value="2" />

<provider
    android:name="com.pichillilorenzo.flutter_inappwebview.InAppWebViewFileProvider"
    android:authorities="${applicationId}.flutter_inappwebview.fileprovider"
    android:exported="false"
    android:grantUriPermissions="true">
    <meta-data
        android:name="android.support.FILE_PROVIDER_PATHS"
        android:resource="@xml/provider_paths" />
</provider>
```

### iOS

For Prizor SDK Flutter to work on iOS, ensure that your project meets the following requirements:

- The minimum iOS version is 11, but the plugin itself only works for iOS 14.3 and above.

Add the following keys to your `Info.plist` file:

```xml
<key>NSMicrophoneUsageDescription</key>
<string>Add microphone usage message.</string>

<key>NSCameraUsageDescription</key>
<string>Add camera usage message.</string>
```

## Usage

To start using the Prizor SDK plugin, follow these steps:

1. Initialize the plugin with the provided parameters from the CRMall team and your user's data. Here's an example of how to do it in Dart:

```dart
PrizorSdkWidget(
  androidAPIErrorCallback: () => ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Android Version Error.")),
  ),
  params: PrizorSdkParams(
    environment: Environment.production,
    appId: "***",
    secret: "***",
    appName: "Test SDK",
    accentColor: const Color(0xFFF1BF3B),
    accentForegroundColor: const Color(0xFFFFFFFF),
    user: User(
      documentNumber: "01234567890",
      cellphone: "+5512345678901",
      name: "John Doe",
    ),
  ),
);
```

The `androidAPIErrorCallback` is available to show a message when a user tries to enter the Prizor SDK with an  `Android` device running on an API level lower than `29`.

### PrizorSdkParams

The `PrizorSdkParams` class is responsible for storing the parameters required to configure the Prizor SDK in an application. Below is a description of each of the parameters:

- `environment`: The environment of the application. Possible values are `production`, `stage`, `development`, and `master`. Use `Environment.production` for the production environment.

- `appId`: The app ID provided by CRMall team.

- `secret`: The app secret provided by CRMall team.

- `appName`: The name of the app to be displayed.

- `isRootRoute`: (optional): If it is true, the Prizor SDK will be the root route of the application. If it is false, the Prizor SDK will be a normal route of the application. The default value is false.

- `titleRoute`: (optional): When `isRootRoute` is [`true`], this parameter will be used as the title of `AppBar`  the route. The default value is `empty`.

- `accentColor`: The primary color of the app, used in the app bar, buttons, icons, etc.

- `accentForegroundColor`: The foreground color of the app.

- `user`: User data to be used in the app campaigns.

- `appLogo`: The image in the campaigns. If it is null, the logo will not be shown. USE A PNG IMAGE!

- `appBrand`: The image on the home screen. If it is null, the brand will not be shown.
USE A PNG IMAGE!

- `splashForegroundColor`: The splash screen foreground color. If it is null, the `accentColor` will be used.

- `splashBackgroundColor`: The splash screen background color. If it is null, the `accentForegroundColor` will be used.

- `sac`: SAC (Service of Customer Support) data to be used in the app campaigns.

These parameters can be configured according to the application's needs to customize the appearance and behavior of the Prizor SDK.


### User

The `User` class represents user data to be used in app campaigns. Below is a description of each of the parameters:

- `cellphone`: The user's cellphone number. It is required because it is used to send the authentication code.

- `documentNumber`: The user's document number. It is required because it is used for authentication and to match the user in the app.

- `name`: The user's name.

- `otherDocument`: Another document associated with the user.

- `gender`: The user's gender.

- `maritalStatus`: The user's marital status.

- `day`: The user's birth day.

- `month`: The user's birth month.

- `year`: The user's birth year.

- `occupation`: The user's occupation.

- `phones`: A list of phone numbers associated with the user.

- `emails`: A list of email addresses associated with the user.

- `addresses`: A list of addresses associated with the user.

These parameters provide various user details that can be used in app campaigns for personalization and targeted messaging.
## Additional Information

For more information and assistance with integrating the Prizor SDK into your project, please reach out to the CRMall team. They will provide you with the necessary resources and support to ensure a smooth integration process.