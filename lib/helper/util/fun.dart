import 'dart:developer';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';
import 'package:starter_d/helper/constant/var.dart';

class Fun {
  static showLog(var message) {
    if (Var.isDebugMode) {
      log(message);
    }
  }

  static Future<String> currentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return 'v${packageInfo.version} (${packageInfo.buildNumber})';
  }

  static Future<String> currentVersionCode() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }

  static Future<String> currentVersionName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  static Future<String> deviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      var release = androidInfo.version.release;
      var sdkInt = androidInfo.version.sdkInt;
      var manufacturer = androidInfo.manufacturer;
      var model = androidInfo.model;
      var isPhysicalDevice = androidInfo.isPhysicalDevice ? '' : ' [Virtual]';
      return 'Android $release (SDK $sdkInt), $manufacturer $model $isPhysicalDevice';
    } else if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      var systemName = iosInfo.systemName;
      var version = iosInfo.systemVersion;
      var name = iosInfo.name;
      var model = iosInfo.model;
      var isPhysicalDevice = iosInfo.isPhysicalDevice ? '' : ' [Virtual]';
      return 'iOS $systemName $version, $name $model $isPhysicalDevice';
    }
    return 'Web';
  }

  static String replaceEmpty(String? value, [String replaceWith = '-']) {
    if (value == null || value == 'null' || value == '' || value == '-') return replaceWith;
    return value;
  }
}
