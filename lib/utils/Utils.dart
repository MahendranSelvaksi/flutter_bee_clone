import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter1/RequestModels/ImageDataModel.dart';
import 'package:flutter1/main.dart';
import 'package:flutter1/repository/APITokenDetails.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:uuid/uuid.dart';

class Utils{

  static const maxLogLength = 3000;

  void showToast(String message){
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  String getCurrentDateOnly() =>
      DateFormat('yyyy-MM-dd').format(DateTime.now());

  String getPhotoTakenAt() => DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());

  String generateUDID() {
    var uuid = Uuid();
    return uuid.v4();
  }

  Future<bool> isInternetConnectionAvailable() async {
    bool result = await InternetConnection().hasInternetAccess;
    return result;
  }
  /*Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }*/
  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }



  ProgressDialog getProgressDialog(BuildContext context, String message){
    ProgressDialog pr = ProgressDialog(context);
    pr = ProgressDialog(context,type: ProgressDialogType.normal,isDismissible: false,showLogs: false);
    pr.style(
        message: message,
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
    );

    return pr;
  }

  String getAccessToken(String userId){
    String accessToken='';
    try{
      APITokenDetails? apiTokenDetails = objectBox.getTokenDetails(1);
       accessToken =  'Bearer ${apiTokenDetails!.accessToken}';
    }catch(e){
      print(e);
    }
    return accessToken;
  }


  Future<String> encodeImage(String imageSource) async {
    var bytes =XFile(imageSource).readAsBytes();
    String encodedString = base64.encode(await bytes);
    return encodedString;
  }


  String imageModelToString(ImageDataModel imageDataModel,String from){
    var json = imageDataModel.toJson();
    String returnValue = json.toString();
  //  debugPrint('imageModelToString  $from :::: $returnValue');
    return returnValue;
  }

  ImageDataModel stringToImageDataModel(String jsonData,String from){
    debugPrint('stringToImageDataModel $from :::: $jsonData');
   // var encodedString = jsonEncode(jsonData.toString());
   // debugPrint('valid json ::::: ${makeValidJsonRevised(jsonData)}');
    Map<String, dynamic> json = jsonDecode(makeValidJsonRevised(jsonData));
  ///  debugPrint('stringToImageDataModel json :::: $json');
    return ImageDataModel.fromJson(json);
  }

  /*Map<String, dynamic> jsonStringToMap(String data) {
    List<String> str = data
        .replaceAll("{", "")
        .replaceAll("}", "")
        .replaceAll("\"", "")
        .replaceAll("'", "")
        .split(",");
    Map<String, dynamic> result = {};
    for (int i = 0; i < str.length; i++) {
      List<String> s = str[i].split(":");
      result.putIfAbsent(s[0].trim(), () => s[1].trim());
    }
    return result;
  }*/

  String makeValidJsonRevised(String invalid) {
    // Remove the outer curly braces
    String content = invalid.substring(1, invalid.length - 1).trim();

    // Split the content by comma
    List<String> pairs = content.split(',');

    List<String> validPairs = [];
    for (String pair in pairs) {
      List<String> parts = pair.split(':');
      if (parts.length == 2) {
        String key = parts[0].trim();
        String value = parts[1].trim();

        // Add double quotes around the key
        String quotedKey = '"$key"';

        // Add double quotes around the value if it's a string (and not empty)
        String quotedValue = value.isEmpty ? '""' : (double.tryParse(value) == null && value != 'true' && value != 'false' ? '"$value"' : '"$value"');

        validPairs.add('$quotedKey: $quotedValue');
      } else if (parts.length > 2) {
        // Handle cases where the value might contain colons (less common but possible in strings)
        String key = parts[0].trim();
        String value = parts.sublist(1).join(':').trim();

        String quotedKey = '"$key"';
        String quotedValue = '"$value"';

        validPairs.add('$quotedKey: $quotedValue');
      }
    }

    return '{${validPairs.join(', ')}}';
  }


  void printLongLog(String longLog) {
    if (longLog.length <= maxLogLength) {
      print(longLog); // If short enough, print as is
    } else {
      int start = 0;
      while (start < longLog.length) {
        int end = start + maxLogLength;
        if (end > longLog.length) {
          end = longLog.length;
        }
        print(longLog.substring(start, end));
        start = end;
      }
    }
  }

  static const List<String> dashBoardMenu =['List of Tasks','Create New Job Manually','Create New Supporting forms',
  'Create New Audit','Submitted Forms'];
  static const List<String> dashBoardMenuIcons = ['assets/images/icons/listOfTasks.png','assets/images/icons/createNewJob.png',
  'assets/images/icons/supportingforms.png','assets/images/icons/createNewAudit.png',
  'assets/images/icons/SubmittedForms.png'];

  static const List<String> menuList =['Help','List of Tasks','Maps - Work Orders, Jobs & Navigation',
    'Mobile Hub','Two Hours Response','Create New Job Manually','Create New Supporting forms',
    'Create New Audit','Sync Status','Submitted Forms','Messages','HSEQ Hub','Auto upgrade of App',
  'About app','Account Settings','Logout'];

  static const List<String> menuListIcons = ['assets/images/icons/helpicon.png',
    'assets/images/icons/listOfTasks.png',
    'assets/images/icons/Maps.png',
    'assets/images/icons/listOfTasks.png',
    'assets/images/icons/helpicon.png',
    'assets/images/icons/createNewJob.png',
    'assets/images/icons/supportingforms.png',
    'assets/images/icons/createNewAudit.png',
    'assets/images/icons/Messages.png',
    'assets/images/icons/SubmittedForms.png',
    'assets/images/icons/Messages.png',
    'assets/images/icons/supportingforms.png',
    'assets/images/icons/Autoupdate.png',
    'assets/images/icons/AppInfo.png',
    'assets/images/icons/settings.png',
    'assets/images/icons/logout.png'];

}