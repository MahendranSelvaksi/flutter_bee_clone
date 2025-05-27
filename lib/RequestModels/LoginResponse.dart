
class LoginResponse {
  String? userId;
  String? accessToken;
  String? accessTokenGeneratedDate;
  String? accessTokenExpiryDate;
  String? refreshToken;
  String? refreshTokenGeneratedDate;
  String? refreshTokenExpiryDate;
  String? firstName;
  String? lastName;
  String? jobTitleId;
  String? jobTitleDescription;
  String? emailId;
  String? cSSId;
  String? leadGangerCSSID;
  bool? isTeamLead;
  bool? isUpdateSecurityQuestion;
  int? operativeTypeID;
  String? operativeTypeDescription;
  List<FunctionalGroup>? functionalGroup;
  List<SupplierGang>? supplierGang;
  List<Null>? applicationVersion;

  LoginResponse(
      {this.userId,
        this.accessToken,
        this.accessTokenGeneratedDate,
        this.accessTokenExpiryDate,
        this.refreshToken,
        this.refreshTokenGeneratedDate,
        this.refreshTokenExpiryDate,
        this.firstName,
        this.lastName,
        this.jobTitleId,
        this.jobTitleDescription,
        this.emailId,
        this.cSSId,
        this.leadGangerCSSID,
        this.isTeamLead,
        this.isUpdateSecurityQuestion,
        this.operativeTypeID,
        this.operativeTypeDescription,
        this.functionalGroup,
        this.supplierGang,
        this.applicationVersion});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    accessToken = json['AccessToken'];
    accessTokenGeneratedDate = json['AccessToken_GeneratedDate'];
    accessTokenExpiryDate = json['AccessToken_ExpiryDate'];
    refreshToken = json['RefreshToken'];
    refreshTokenGeneratedDate = json['RefreshToken_GeneratedDate'];
    refreshTokenExpiryDate = json['RefreshToken_ExpiryDate'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    jobTitleId = json['JobTitleId'];
    jobTitleDescription = json['JobTitleDescription'];
    emailId = json['EmailId'];
    cSSId = json['CSSId'];
    leadGangerCSSID = json['LeadGangerCSSID'];
    isTeamLead = json['IsTeamLead'];
    isUpdateSecurityQuestion = json['IsUpdateSecurityQuestion'];
    operativeTypeID = json['OperativeTypeID'];
    operativeTypeDescription = json['OperativeTypeDescription'];
    if (json['FunctionalGroup'] != null) {
      functionalGroup = <FunctionalGroup>[];
      json['FunctionalGroup'].forEach((v) {
        functionalGroup!.add(new FunctionalGroup.fromJson(v));
      });
    }
    if (json['SupplierGang'] != null) {
      supplierGang = <SupplierGang>[];
      json['SupplierGang'].forEach((v) {
        supplierGang!.add(new SupplierGang.fromJson(v));
      });
    }
    if (json['ApplicationVersion'] != null) {
      applicationVersion = <Null>[];
      json['ApplicationVersion'].forEach((v) {
    //    applicationVersion!.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['AccessToken'] = this.accessToken;
    data['AccessToken_GeneratedDate'] = this.accessTokenGeneratedDate;
    data['AccessToken_ExpiryDate'] = this.accessTokenExpiryDate;
    data['RefreshToken'] = this.refreshToken;
    data['RefreshToken_GeneratedDate'] = this.refreshTokenGeneratedDate;
    data['RefreshToken_ExpiryDate'] = this.refreshTokenExpiryDate;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['JobTitleId'] = this.jobTitleId;
    data['JobTitleDescription'] = this.jobTitleDescription;
    data['EmailId'] = this.emailId;
    data['CSSId'] = this.cSSId;
    data['LeadGangerCSSID'] = this.leadGangerCSSID;
    data['IsTeamLead'] = this.isTeamLead;
    data['IsUpdateSecurityQuestion'] = this.isUpdateSecurityQuestion;
    data['OperativeTypeID'] = this.operativeTypeID;
    data['OperativeTypeDescription'] = this.operativeTypeDescription;
    if (this.functionalGroup != null) {
      data['FunctionalGroup'] =
          this.functionalGroup!.map((v) => v.toJson()).toList();
    }
    if (this.supplierGang != null) {
      data['SupplierGang'] = this.supplierGang!.map((v) => v.toJson()).toList();
    }
    if (this.applicationVersion != null) {
      /*data['ApplicationVersion'] =
          this.applicationVersion!.map((v) => v.toJson()).toList();*/
    }
    return data;
  }
}

class FunctionalGroup {
  int? functionalGroupID;
  String? functionalGroupDescription;

  FunctionalGroup({this.functionalGroupID, this.functionalGroupDescription});

  FunctionalGroup.fromJson(Map<String, dynamic> json) {
    functionalGroupID = json['FunctionalGroupID'];
    functionalGroupDescription = json['FunctionalGroupDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FunctionalGroupID'] = this.functionalGroupID;
    data['FunctionalGroupDescription'] = this.functionalGroupDescription;
    return data;
  }
}

class SupplierGang {
  int? trainingID;
  String? userId;
  int? gangId;
  String? gangName;
  int? supplierId;
  String? supplierName;

  SupplierGang(
      {this.trainingID,
        this.userId,
        this.gangId,
        this.gangName,
        this.supplierId,
        this.supplierName});

  SupplierGang.fromJson(Map<String, dynamic> json) {
    trainingID = json['Training_ID'];
    userId = json['User_Id'];
    gangId = json['Gang_Id'];
    gangName = json['Gang_Name'];
    supplierId = json['Supplier_Id'];
    supplierName = json['Supplier_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Training_ID'] = this.trainingID;
    data['User_Id'] = this.userId;
    data['Gang_Id'] = this.gangId;
    data['Gang_Name'] = this.gangName;
    data['Supplier_Id'] = this.supplierId;
    data['Supplier_Name'] = this.supplierName;
    return data;
  }
}