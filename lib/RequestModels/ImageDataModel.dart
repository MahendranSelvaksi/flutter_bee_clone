
class ImageDataModel {
  late String? values;
  late String? location;
  late String? latitude;
  late String? longitude;
  late String? photoTakenAt;
  late String? photoTakenBy;
  late String? imageSource;

  ImageDataModel({
     this.values,
     this.location,
     this.latitude,
     this.longitude,
     this.photoTakenAt,
     this.photoTakenBy,
     this.imageSource,
  });

  ImageDataModel.fromJson(Map<String, dynamic> json) {
    values = json['values'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    photoTakenAt = json['photoTakenAt'];
    photoTakenBy = json['photoTakenBy'];
    imageSource = json['imageSource'];
  }

  Map<String, dynamic> toJson() {
    return {
      'values': values,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'photoTakenAt': photoTakenAt,
      'photoTakenBy': photoTakenBy,
      'imageSource': imageSource,
    };
  }
}
