import 'package:device_information/device_information.dart';
import 'package:ecommvvm/domain/model/model.dart';
import 'package:flutter/services.dart';

Future<DeviceInfo> getDeviceDetails() async {
  String name = "UNKNOWN";
  String identifier = "UNKNOWN";
  String version = "UNKNOWN";
  try {
    version = await DeviceInformation.platformVersion;
    identifier = await DeviceInformation.deviceIMEINumber;

    name = await DeviceInformation.deviceName;
    return DeviceInfo(name, identifier, version);
  } on PlatformException {
    return DeviceInfo(name, identifier, version);
  }
}
