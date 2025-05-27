import 'package:flutter1/RequestModels/ImageDataModel.dart';

import 'GateCheckApiRequest.dart';

class GateCheckApiRequest{
  String ApiKey = "D9uht#c^2jAePK9WMf!7\$9kYh";
  String TaskType = "MobileWorkflow";
  Attributes attributes = Attributes();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ApiKey'] = ApiKey;
    data['TaskType'] = TaskType;
    data['attributes'] = attributes.toJson();
    return data;
  }
}


class Attributes{
  List<Forms> forms=[];
  String VisitId ='ADASFEWTWRET5E67476587HG';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['VisitId'] = VisitId;
    data['forms'] = forms.map((v) => v.toJson()).toList();
    return data;
  }
}

class Forms{
  String  AppVersion= "6.57";
  String CSSID3 = '1767868';
  String CSSID4 = '1767868';
  String CSSID5 = '1767868';
  String ComplianceStatus ='0';
  String CreatedBy='telentbee.support@telentbee.co.uk';
  String CreatedOn='21/05/2025 12:54';
  String device_Model = "POCO M2 Pro";
  String DeviceName = "POCO M2 Pro";
  String DistanceFromOffice='0';
  String DistanceFromOrder='0';
  String Form='GateCheck2';
  String Id='';
  bool IsManualVisit= false;
  bool IsTwoHrResponse= false;
  String Latitude= '37.4219983';
  String LeadGangerCSSID = 'CTZZB01';
  String Location='Siruseri IT park';
  String Longitude = '-122.084';
  String ModifiedBy='telentbee.support@telentbee.co.uk';
  String ModifiedOn='21/05/2025 12:54';
  String OrderLatitude='37.4219983';
  String OrderLongitude='-122.084';
  String OrderLocation='1650 Amphitheatre Pkwy, Mountain View, CA 94043, USA';
  String OrderNumber = 'Gate check 15/03/2024';
  String osVersion = "QKQI.191215.002";
  int MobileAppPlatformID =1;
  String ScheduleId='';
  String Username='telentbee.support@telentbee.co.uk';
  String VisitStatus='2';
  String OSVersion='2';
  List<FormSpecificFields> formSpecificFields=[];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AppVersion'] = AppVersion;
    data['CSSID3'] = CSSID3;
    data['CSSID4'] = CSSID4;
    data['CSSID4'] = CSSID5;
    data['ComplianceStatus'] = ComplianceStatus;
    data['CreatedBy'] = CreatedBy;
    data['CreatedOn'] = CreatedOn;
    data['DeviceModel'] = device_Model;
    data['DeviceName'] = DeviceName;
    data['DistanceFromOffice'] = DistanceFromOffice;
    data['DistanceFromOrder'] = DistanceFromOrder;
    data['Form'] = Form;
    data['FormSpecificFields'] = formSpecificFields.map((v) => v.toJson()).toList();
    data['Id'] = Id;
    data['IsManualVisit'] = IsManualVisit;
    data['IsTwoHrResponse'] = IsTwoHrResponse;
    data['Latitude'] = Latitude;
    data['LeadGangerCSSID'] = LeadGangerCSSID;
    data['Location'] = Location;
    data['Longitude'] = Longitude;
    data['ModifiedBy'] = ModifiedBy;
    data['ModifiedOn'] = ModifiedOn;
    data['OrderLatitude'] = OrderLatitude;
    data['OrderLocation'] = OrderLocation;
    data['OrderLongitude'] = OrderLongitude;
    data['OrderNumber'] = OrderNumber;
    data['OSVersion'] = OSVersion;
    data['MobileAppPlatformID'] = MobileAppPlatformID;
    data['ScheduleId'] = ScheduleId;
    data['Username'] = Username;
    data['VisitStatus'] = VisitStatus;
    return data;
  }
}

class FormSpecificFields{
  late String Name;
  late String Value;
  late List<ImageAPIModel> values;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = Name;
    data['Value'] = Value;
    data['Values'] =
        this.values.map((v) => v.toJson()).toList();

    return data;
  }
}


class  ImageAPIModel{
  late String? values;
  late String? location;
  late String? latitude;
  late String? longitude;
  late String? photoTakenAt;
  late String? photoTakenBy;

  ImageAPIModel({
    this.values,
    this.location,
    this.latitude,
    this.longitude,
    this.photoTakenAt,
    this.photoTakenBy,
  });

  ImageAPIModel.fromJson(Map<String, dynamic> json) {
    values = json['values'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    photoTakenAt = json['photoTakenAt'];
    photoTakenBy = json['photoTakenBy'];
  }

  Map<String, dynamic> toJson() {
    return {
      'values': values,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'photoTakenAt': photoTakenAt,
      'photoTakenBy': photoTakenBy
    };
  }
}