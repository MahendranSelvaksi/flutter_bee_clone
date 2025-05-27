import 'package:objectbox/objectbox.dart';

@Entity()
class AllFormData {
  @Id()
  late int id;
  String? userId;
  String? orderNumber;
  String? visitId;
  String? scheduleId;
  String? formId;
  String? formName;
  DateTime? createdAt;
  DateTime? createdOn;
  String? catCode;
  String? answer;
  String? questionType;
  DateTime? modifiedAt;
  bool? isVisible;

  AllFormData({
    this.id = 0,
    this.userId,
    this.orderNumber,
    this.visitId,
    this.scheduleId,
    this.formId,
    this.formName,
    this.createdAt,
    this.createdOn,
    this.catCode,
    this.answer,
    this.questionType,
    this.modifiedAt,
    this.isVisible,
  });

  @override
  int get hashCode => Object.hash(id, catCode);

  @override
  bool operator ==(Object other) {
    if(other is! AllFormData) return false;

    return other.id ==id;
  }
}