import 'package:objectbox/objectbox.dart';

@Entity()
class APITokenDetails {
  @Id()
  late int id;
  String? userId;
  String? accessToken;
  String? accessTokenGeneratedDate;
  String? accessTokenExpiryDate;
  String? refreshToken;
  String? refreshTokenGeneratedDate;
  String? refreshTokenExpiryDate;

  APITokenDetails({
    this.id = 0,
    this.userId,
    this.accessToken,
    this.accessTokenGeneratedDate,
    this.accessTokenExpiryDate,
    this.refreshToken,
    this.refreshTokenGeneratedDate,
    this.refreshTokenExpiryDate,
  });
}