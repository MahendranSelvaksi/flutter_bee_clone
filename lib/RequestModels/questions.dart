import 'package:flutter1/RequestModels/ImageDataModel.dart';

class Questions{
late String id;
late String type;
late String validation;
late String question;
late String work_point;
late String point_item;
late String category_code;
late String default_answer;
late String no_of_images;
late bool mandatory;
late String mandatory_answer;
late String given_answer;
late String image_path;
late List<ImageArray> imageArrays;


Questions.fromJSON(Map<String, dynamic> json){
  id = json['id'];
  type = json['type'];
  validation = json['validation'];
  question = json['question'];
  work_point = json['work_point'];
  category_code = json['category_code'];
  default_answer = json['default_answer'];
  no_of_images = json['no_of_images'];
  mandatory = json['mandatory'];
  mandatory_answer = json['mandatory_answer'];
  given_answer = json['given_answer'];
  image_path = json['image_path'];
  if (json['imagearray'] != null) {
    imageArrays = <ImageArray>[];
    json['imagearray'].forEach((v) {
      imageArrays.add(ImageArray.fromJSON(v));
    });
  }
}

}


class ImageArray{
  late String name;
  late String categoryCode;
  late String imageName;
  late String description;
  late ImageDataModel imageModel;

  ImageArray.fromJSON(Map<String, dynamic> json){
    name = json['name'];
    categoryCode = json['category_code'];
    imageName = json['image_name'];
    description = json['description'];
    imageModel = ImageDataModel();
    /*if (json['imageModel'] != null) {
      imageModel = ImageDataModel as ImageDataModel;
     *//* json['imageModel'].forEach((v) {
        imageArrays.add(ImageArray.fromJSON(v));
      });*//*
    }else{
      imageModel = ImageDataModel as ImageDataModel;
    }*/
  }

}