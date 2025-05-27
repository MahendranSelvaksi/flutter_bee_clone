import 'dart:async';

import 'package:permission_handler/permission_handler.dart';

class PermissionHandler{

  StreamSubscription<PermissionStatus>? _subscription;

  Future<bool> checkPermissionStatus(Permission permission) async {
   // final permission = Permission.location;
    return await permission.status.isGranted;
  }


  Future<void> requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage, // Or Permission.photos for iOS / newer Android
      Permission.camera,
    ].request();

    if (statuses[Permission.storage]!.isGranted) {
      // Storage permission granted
      await Permission.storage.status;
    }

    if (statuses[Permission.camera]!.isGranted) {
      // Camera permission granted
      await Permission.camera.status;
    }
  }

  Future<bool> shouldShowRequestRationale(Permission permission) async {
  //  final permission = Permission.location;
    return await permission.shouldShowRequestRationale;
  }

  Future<bool> checkPermanentlyDenied(Permission permission) async {
    /*Map<Permission, PermissionStatus> statuses = await [
      Permission.storage, // Or Permission.photos for iOS / newer Android
      Permission.camera,
    ].request();*/

    return await permission.status.isPermanentlyDenied;
  }

  void openSettings() {
    openAppSettings();
  }
}