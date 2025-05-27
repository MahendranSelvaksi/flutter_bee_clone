
import 'package:objectbox/objectbox.dart';

@Entity()
class UserLoginData{
  @Id()
  late int id;
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

  UserLoginData(
      {
        this.id=0,
        this.userId,
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
        this.operativeTypeDescription
      });

}
