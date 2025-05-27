class UserData {
  final String userId;
  final String accessToken;
  final String accessTokenGeneratedDate;
  final String accessTokenExpiryDate;
  final String refreshToken;
  final String refreshTokenGeneratedDate;
  final String refreshTokenExpiryDate;
  final String firstName;
  final String lastName;
  final String jobTitleId;
  final String jobTitleDescription;
  final String emailId;
  final String cssId;
  final String leadGangerCSSID;
  final bool isTeamLead;
  final bool isUpdateSecurityQuestion;
  final int operativeTypeID;
  final String operativeTypeDescription;
  final List<FunctionalGroup> functionalGroup;
  final List<SupplierGang> supplierGang;
  final List<dynamic> applicationVersion;

  UserData({
    required this.userId,
    required this.accessToken,
    required this.accessTokenGeneratedDate,
    required this.accessTokenExpiryDate,
    required this.refreshToken,
    required this.refreshTokenGeneratedDate,
    required this.refreshTokenExpiryDate,
    required this.firstName,
    required this.lastName,
    required this.jobTitleId,
    required this.jobTitleDescription,
    required this.emailId,
    required this.cssId,
    required this.leadGangerCSSID,
    required this.isTeamLead,
    required this.isUpdateSecurityQuestion,
    required this.operativeTypeID,
    required this.operativeTypeDescription,
    required this.functionalGroup,
    required this.supplierGang,
    required this.applicationVersion,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userId: json['UserId'],
      accessToken: json['AccessToken'],
      accessTokenGeneratedDate: json['AccessToken_GeneratedDate'],
      accessTokenExpiryDate: json['AccessToken_ExpiryDate'],
      refreshToken: json['RefreshToken'],
      refreshTokenGeneratedDate: json['RefreshToken_GeneratedDate'],
      refreshTokenExpiryDate: json['RefreshToken_ExpiryDate'],
      firstName: json['FirstName'],
      lastName: json['LastName'],
      jobTitleId: json['JobTitleId'],
      jobTitleDescription: json['JobTitleDescription'],
      emailId: json['EmailId'],
      cssId: json['CSSId'],
      leadGangerCSSID: json['LeadGangerCSSID'],
      isTeamLead: json['IsTeamLead'],
      isUpdateSecurityQuestion: json['IsUpdateSecurityQuestion'],
      operativeTypeID: json['OperativeTypeID'],
      operativeTypeDescription: json['OperativeTypeDescription'],
      functionalGroup: (json['FunctionalGroup'] as List)
          .map((i) => FunctionalGroup.fromJson(i))
          .toList(),
      supplierGang: (json['SupplierGang'] as List)
          .map((i) => SupplierGang.fromJson(i))
          .toList(),
      applicationVersion: json['ApplicationVersion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'AccessToken': accessToken,
      'AccessToken_GeneratedDate': accessTokenGeneratedDate,
      'AccessToken_ExpiryDate': accessTokenExpiryDate,
      'RefreshToken': refreshToken,
      'RefreshToken_GeneratedDate': refreshTokenGeneratedDate,
      'RefreshToken_ExpiryDate': refreshTokenExpiryDate,
      'FirstName': firstName,
      'LastName': lastName,
      'JobTitleId': jobTitleId,
      'JobTitleDescription': jobTitleDescription,
      'EmailId': emailId,
      'CSSId': cssId,
      'LeadGangerCSSID': leadGangerCSSID,
      'IsTeamLead': isTeamLead,
      'IsUpdateSecurityQuestion': isUpdateSecurityQuestion,
      'OperativeTypeID': operativeTypeID,
      'OperativeTypeDescription': operativeTypeDescription,
      'FunctionalGroup': functionalGroup.map((e) => e.toJson()).toList(),
      'SupplierGang': supplierGang.map((e) => e.toJson()).toList(),
      'ApplicationVersion': applicationVersion,
    };
  }
}

class FunctionalGroup {
  final int functionalGroupID;
  final String functionalGroupDescription;

  FunctionalGroup({
    required this.functionalGroupID,
    required this.functionalGroupDescription,
  });

  factory FunctionalGroup.fromJson(Map<String, dynamic> json) {
    return FunctionalGroup(
      functionalGroupID: json['FunctionalGroupID'],
      functionalGroupDescription: json['FunctionalGroupDescription'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'FunctionalGroupID': functionalGroupID,
      'FunctionalGroupDescription': functionalGroupDescription,
    };
  }
}

class SupplierGang {
  final int trainingID;
  final String userId;
  final int gangId;
  final String gangName;
  final int supplierId;
  final String supplierName;

  SupplierGang({
    required this.trainingID,
    required this.userId,
    required this.gangId,
    required this.gangName,
    required this.supplierId,
    required this.supplierName,
  });

  factory SupplierGang.fromJson(Map<String, dynamic> json) {
    return SupplierGang(
      trainingID: json['Training_ID'],
      userId: json['User_Id'],
      gangId: json['Gang_Id'],
      gangName: json['Gang_Name'],
      supplierId: json['Supplier_Id'],
      supplierName: json['Supplier_Name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Training_ID': trainingID,
      'User_Id': userId,
      'Gang_Id': gangId,
      'Gang_Name': gangName,
      'Supplier_Id': supplierId,
      'Supplier_Name': supplierName,
    };
  }
}