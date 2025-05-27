import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter1/RequestModels/ImageDataModel.dart';
import 'package:flutter1/RequestModels/questions.dart';
import 'package:flutter1/utils/Utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../repository/AllFormData.dart';
import '../utils/PermissionHandler.dart';

class SingleImageView extends StatefulWidget {
  final ImageArray imageQuestionsData;
  final AllFormData answerData;
  final String formId;
  final String userId;
  final String visitId;
  final String parentCatCode;

  const SingleImageView({
    super.key,
    required this.imageQuestionsData,
    required this.photoValueChanged,
    required this.answerData,
    required this.formId,
    required this.userId,
    required this.parentCatCode,
    required this.visitId,
  });

  final ValueChanged<AllFormData> photoValueChanged;

  @override
  State<StatefulWidget> createState() => _SingleImageState();
}

class _SingleImageState extends State<SingleImageView> {
  final ImagePicker _picker = ImagePicker();
  XFile? imageFile1;

  PermissionHandler mPermissionHandler = PermissionHandler();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  widget.imageQuestionsData.name,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.question_mark_outlined),
                ),
              ),
            ],
          ),
          if (widget.imageQuestionsData.imageModel.imageSource != null &&
              widget.imageQuestionsData.imageModel.imageSource!.isNotEmpty)
            InkWell(
              onTap: (){
                _settingModalBottomSheet(context);
              },
              child:  Image.file(
                File(
                  XFile(widget.imageQuestionsData.imageModel.imageSource!).path,
                ),
                fit: BoxFit.fill,
                width: double.infinity,
                height: 200,
              ),
            )
          else
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  print('clicked camera');
                  var status = false;
                  mPermissionHandler
                      .checkPermissionStatus(Permission.camera)
                      .then((value) {
                        status = value;
                      });
                  print('Camera permission $status');
                  //  if(status){
                  _settingModalBottomSheet(context);
                  /* }else{
                  mPermissionHandler.requestPermission();
                }*/
                },
                icon: const Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                ),
                label: const Text(
                  'Camera',
                  style: TextStyle(color: Colors.white),
                ),
                iconAlignment: IconAlignment.start,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.shade600,
                  shape: StadiumBorder(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  //********************** IMAGE PICKER
  Future<XFile?> imageSelector(BuildContext context, String pickerType) async {
    Utils utils = Utils();
    switch (pickerType) {
      case "gallery":

        /// GALLERY IMAGE PICKER
        imageFile1 = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 90,
        );
        break;

      case "camera": // CAMERA CAPTURE CODE
        imageFile1 = await _picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 90,
        );
        break;
    }

    final imageFile = imageFile1;
    if (imageFile != null) {
      print("You selected  image : ${imageFile.path}");
      ImageDataModel imageDataMode = ImageDataModel(
        values: '',
        imageSource: imageFile.path,
        latitude: '276378623',
        longitude: '278378263',
        location: 'Changepond tech',
        photoTakenAt: utils.getPhotoTakenAt(),
        photoTakenBy: 'telentbee.support@telentbee.co.uk',
      );
      widget.imageQuestionsData.imageModel = imageDataMode;
      updateAnswerData(
        utils.imageModelToString(imageDataMode, 'imageSelector'),
      );
      setState(() {
        debugPrint("SELECTED IMAGE PICK   $imageFile");
      });
    } else {
      print("You have not taken image");
    }
  }

  void updateAnswerData(String answer) {
    print('photo answer:::: $answer');
    if (widget.answerData.formId != null &&
        widget.answerData.formId!.isNotEmpty) {
      widget.answerData.answer = answer;
      widget.answerData.modifiedAt = DateTime.now();
    } else {
      widget.answerData.userId = widget.userId;
      widget.answerData.formId = widget.formId;
      widget.answerData.createdAt = DateTime.now();
      widget.answerData.createdOn = DateTime.parse(
        Utils().getCurrentDateOnly(),
      );
      widget.answerData.catCode =
          '${widget.imageQuestionsData.categoryCode}-${widget.parentCatCode}';
      widget.answerData.questionType = 'photo';
      widget.answerData.formName = 'Gate Check Form';
      widget.answerData.orderNumber = 'Gate Check Form';
      widget.answerData.scheduleId = 'Gate Check Form';
      widget.answerData.visitId = widget.visitId;
      widget.answerData.answer = answer;
      widget.answerData.isVisible = true;
    }
    widget.photoValueChanged(widget.answerData);
  }

  // Image picker
  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                title: new Text('Gallery'),
                onTap:
                    () => {
                      imageSelector(context, "gallery"),
                      Navigator.pop(context),
                    },
              ),
              new ListTile(
                title: new Text('Camera'),
                onTap:
                    () => {
                      imageSelector(context, "camera"),
                      Navigator.pop(context),
                    },
              ),
            ],
          ),
        );
      },
    );
  }
}
