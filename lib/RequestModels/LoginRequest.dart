class LoginRequest {
  String userName = "";
  String password = "";
  String browserVersion = "Version 97.0.4692.99";
  String screenDimensions = "79mm x 170mm (3726x8064), DPI] = 401";
  String screenSize = "188mm (7.38')";

  String applicationVersion = "1.1040.2021.0427";
  String platform = "Android 10 QKQI.191215.002";
  String osVersion = "QKQI.191215.002";
  String deviceID = "M2003J6C1";
  String device_Model = "POCO M2 Pro";
  String permission_Set_as_Required = "Yes";
  String cameraControl = "Granted";
  String locationControl = "Granted";

  String locationAlways = "Granted";
  String storageControl = "Granted";
  bool airplaneMode = false;
  bool locationEnabled = false;
  String latitude = "51.5087000000";
  String longitude = "-0.4213000000";


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['password'] = password;
    data ['browserVersion'] = browserVersion;
    data ['screenDimensions'] = screenDimensions;
    data ['screenSize'] = screenSize;
     data ['applicationVersion'] = applicationVersion;
     data ['platform'] = platform;
     data ['osVersion'] = osVersion;
     data ['deviceID'] = deviceID;
     data ['device_Model'] = device_Model;
     data ['permission_Set_as_Required'] = permission_Set_as_Required;
     data ['cameraControl'] = cameraControl;
     data ['locationControl'] = locationControl;
     data ['locationAlways'] = locationAlways;
     data ['storageControl'] = storageControl;
     data ['airplaneMode'] = airplaneMode;
     data ['locationEnabled'] = locationEnabled;
     data ['latitude'] = latitude;
     data ['longitude'] = longitude;
    
    return data;
  }
}
