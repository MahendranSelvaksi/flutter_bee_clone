import 'package:flutter1/RequestModels/questions.dart';

class CategoriesModel {
  late String id;
  late String subTitle;
  late List<Questions> questions;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subTitle = json['sub_title'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions.add(Questions.fromJSON(v));
      });
    }
  }
}
