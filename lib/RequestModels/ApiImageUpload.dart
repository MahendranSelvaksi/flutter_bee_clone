class ApiImageUpload {
  String orderNumber = '39847238947';
  String formName = 'Gate Check Form';
  String photoName = '';
  String photo = '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OrderNumber'] = orderNumber;
    data['FormName'] = formName;
    data['PhotoName'] = photoName;
    data['photo'] = photo;
    return data;
  }
}
