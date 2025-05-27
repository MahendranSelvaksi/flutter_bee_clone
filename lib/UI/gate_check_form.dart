import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter1/RequestModels/ApiImageUpload.dart';
import 'package:flutter1/RequestModels/CategoriesModel.dart';
import 'package:flutter1/RequestModels/ImageDataModel.dart';
import 'package:flutter1/RequestModels/questions.dart';
import 'package:flutter1/UI/DropDownView.dart';
import 'package:flutter1/UI/RadioQuestionView.dart';
import 'package:flutter1/main.dart';
import 'package:flutter1/repository/AllFormData.dart';
import 'package:flutter1/utils/Utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../RequestModels/GateCheckApiRequest.dart';
import '../utils/APIService.dart';
import 'CommonToolBar.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class GateCheck extends StatefulWidget {
  final String formId;

  const GateCheck({super.key, required this.formId});

  @override
  State<StatefulWidget> createState() => _gateCheckState();
}

class _gateCheckState extends State<GateCheck> {
  List<Questions> formUIJsonData = [];
  List<CategoriesModel> allJsonData = [];
  List<AllFormData> formAnswerData = [];
  AllFormData dropDownAnswerData = AllFormData();
  HashSet<AllFormData> answerSet = HashSet();
  Utils utils = Utils();
  bool isVisible = true;
  String visitId = '';
  bool isFormCompleted = false;
  String formName = 'Gate Check';

  @override
  void didUpdateWidget(GateCheck oldWidget) {
    super.didUpdateWidget(oldWidget);
    parseFormJson();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    print('Comes intiState');
    print('form Id :::: ${widget.formId}');
    parseFormJson();
  }

  void _updateFormStatus() {
    setState(() {
      isFormCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.pop(context);
      },
      child: SafeArea(
        child: AnnotatedRegion(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.purple,
            statusBarIconBrightness: Brightness.dark,
          ),
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 160,
              flexibleSpace: CommonToolBar(
                formName: formName,
                formStatus: isFormCompleted,
                isDeleteRequired: false,
              ),
              automaticallyImplyLeading: false,
            ),
            body: Container(
              color: Colors.white,
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text(
                      "Gate Check",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text(
                      "Please fill the following gate check form",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  DropDownView(
                    answerData: dropDownAnswerData,
                    dropDownValueChanged:
                        (data) => setState(() {
                          initializeQuestionsBasedOnDropdownValue(data.answer);
                          dropDownAnswerData = data;
                          answerSet.add(data);
                        }),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: formUIJsonData.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item = formUIJsonData[index];
                        if (item.type == "radio_yes_photo") {
                          return RadioQuestionView(
                            questionsData: item,
                            radioValueChanged: (value) {
                              print('###################');
                              print('Answer :::: ${value.answer}');
                              print('id :::: ${value.id}');
                              print('cat code :::: ${value.catCode}');
                              print('@@@@@@@@@@@@@@@@@@@@@@@');
                              if (value.answer!.isNotEmpty) {
                                answerSet.add(value);
                              }
                              print('answer set size :::: ${answerSet.length}');
                              validateFormStatus();
                            },
                            photoValueChanged: (value) {
                              print('^^^^^^^^^^^^^^^^^^');
                              print('Answer :::: ${value.answer}');
                              print('id :::: ${value.id}');
                              print('cat code :::: ${value.catCode}');
                              print('***********************');
                              if (value.answer!.isNotEmpty) {
                                answerSet.add(value);
                              }
                              print('answer set size :::: ${answerSet.length}');
                              validateFormStatus();
                            },
                            formId: widget.formId,
                            userId: "teletbee.support@telentbee.co.uk",
                            visitId: visitId,
                            answerDataList: objectBox.getFormDataByCatCode(
                              widget.formId,
                              item.category_code,
                            ),
                            formUIDataChanged: (Questions value) {
                              item = value;
                            },
                          );
                        }
                        /*else if (item.type == "photo") {
                        return SingleImageView();
                      }*/
                        else {
                          return ListTile(
                            title: Text(item.question ?? 'No Title'),
                            subtitle: Text(
                              item.category_code ?? 'No Description',
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                       // utils.showToast("Clicked Submit Button");
                        saveFormDataToDB();
                      },
                      label: const Text(
                        'Submit',
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
            ),
          ),
        ),
      ),
    );
  }

  Future<void> parseFormJson() async {
    try {
      var jsonData = await loadJsonFromAssets('assets/AgentGateCheckNew.json');
      List<dynamic> someDynamicList =
          jsonData['detail']['body']['items'][1]['categories'];
      for (final c in someDynamicList) {
        var allQuestions = CategoriesModel.fromJson(c);
        allJsonData.add(allQuestions);
      }
    } catch (e) {
      print("Exception $e");
    }

    formAnswerData.addAll(objectBox.getGateCheckFormByFormId(widget.formId)!);
    for (var value in formAnswerData) {
      print(
        'cat code ==== ${value.catCode}  :::: Answer #### ${value.answer} &&&&& id === ${value.id}',
      );
    }
    if (formUIJsonData.isEmpty) {
      visitId = utils.generateUDID();
    } else {
      visitId = formAnswerData[0].visitId!;
    }
    print('visitId :::: $visitId');
    bool hasCatCode = formAnswerData.any(
      (object) => object.catCode == 'dropDown',
    );
    for (var value in allJsonData) {
      for (var questions in value.questions) {
        for (var answerData in formAnswerData) {
          if (answerData.questionType == 'radio_yes_photo') {
            if (questions.category_code == answerData.catCode) {
              questions.given_answer = answerData.answer!;
            }
          } else if (answerData.questionType == 'photo') {
            var splitCatCode = answerData.catCode?.split('-')[1];
            int index = value.questions.indexWhere(
              (st) => st.category_code == splitCatCode,
            );
            if (index >= 0) {
              value.questions[index].imageArrays[0].imageModel = utils
                  .stringToImageDataModel(
                    answerData.answer.toString(),
                    'parseFormJson',
                  );
            }
          }
        }
      }
    }
    setState(() {
      if (hasCatCode) {
        dropDownAnswerData =
            formAnswerData.where((val) => val.catCode == 'dropDown').first;
        print('drop down answer ::::: ${dropDownAnswerData.answer}');
      } else {
        print('Comes drop down value not in db');
        dropDownAnswerData = AllFormData();
        dropDownAnswerData.userId = 'teeletbee.support@telentbee.co.uk';
        dropDownAnswerData.formId = widget.formId;
        dropDownAnswerData.createdAt = DateTime.now();
        dropDownAnswerData.createdOn = DateTime.parse(
          Utils().getCurrentDateOnly(),
        );
        dropDownAnswerData.catCode = 'dropDown';
        dropDownAnswerData.questionType = 'dropDown';
        dropDownAnswerData.formName = 'Gate Check Form';
        dropDownAnswerData.orderNumber = 'Gate Check Form';
        dropDownAnswerData.scheduleId = 'Gate Check Form';
        dropDownAnswerData.visitId = visitId;
        dropDownAnswerData.answer = '';
        dropDownAnswerData.isVisible = true;
      }
      setState(() {
        dropDownAnswerData;
      });
      initializeQuestionsBasedOnDropdownValue(dropDownAnswerData.answer);
    });
  }

  void initializeQuestionsBasedOnDropdownValue(String? dropDownValue) {
    print("dropDown value :::: $dropDownValue");
    formUIJsonData.clear();
    if (dropDownValue!.length > 0) {
      print(
        "dropDown value is not empty :::: $dropDownValue ===== ${allJsonData.length}",
      );
      for (final c in allJsonData) {
        print('Sub title :::: ${c.subTitle}');
        if (c.subTitle == dropDownValue) {
          formUIJsonData.addAll(c.questions);
          break;
        }
      }
      /*print("formUI jsnon data size :::: ${formUIJsonData.length}");
      print("formUI jsnon data size :::: ${formUIJsonData.first.imageArrays}");*/

      for (var v in formUIJsonData) {
        print('${v.category_code} :::: ${v.given_answer}');
      }

      print('drop down selected value :::: ${dropDownAnswerData.answer}');
      print('drop down selected value :::: ${dropDownAnswerData.catCode}');
      print('drop down selected value :::: ${dropDownAnswerData.id}');
      setState(() {
        validateFormStatus();
      });
    }
  }

  void addDropDownAnswerData(String? dropDownValue) {}

  Future<Map<String, dynamic>> loadJsonFromAssets(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);
    return jsonDecode(jsonString);
  }

  void getAllTheDataForFormId() {}

  void saveFormDataToDB() async {
    try {
      print('Comes saveFormDataToDB method ::: ${answerSet.length}');
      List<int> data = await objectBox.storeFormAllDataAsync(
        answerSet.toList(),
      );
      for (var val in data) {
        print('data save response :::: $val');
      }
      //  Navigator.pop(context);
      apiCall();
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>> makeApiCall(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Error: ${response.statusCode}');
        return {};
      }
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<void> apiCall() async {
    try {
      bool isInternetConnected = false;
      utils.isInternetConnectionAvailable().then((value) {
        isInternetConnected = value;
      });
      if (!isInternetConnected) {
        ProgressDialog pr = utils.getProgressDialog(context, 'Please wait...');
        await pr.show();

        Map<String, String> apiImageList = Map();
        for (var element in formUIJsonData) {
          if (element.given_answer.trim() == 'Yes') {
            if (element.imageArrays.first.imageModel.imageSource!.isNotEmpty &&
                element.imageArrays.first.imageModel.values!.isEmpty) {
              print(
                'values :::: ${element.imageArrays.first.imageModel.values!}',
              );
              String data = utils.imageModelToString(
                element.imageArrays[0].imageModel,
                'apiCall',
              );
              apiImageList['${element.imageArrays[0].categoryCode}-${element.category_code}'] =
                  data;
            }
          }
        }

        if (apiImageList.isNotEmpty) {
          // AFTER (correct):
          for (var entry in apiImageList.entries) {
            String key = entry.key;
            String value = entry.value;
            ApiImageUpload apiImageUpload = ApiImageUpload();
            ImageDataModel imageModel = utils.stringToImageDataModel(
              value,
              'uploadImageAndStoreInLocalDB',
            );
            XFile file = XFile(imageModel.imageSource!);
            apiImageUpload.formName = 'Gate Check Form';
            apiImageUpload.orderNumber = '5002195096';
            apiImageUpload.photoName = file.name;
            apiImageUpload.photo = await utils.encodeImage(
              imageModel.imageSource.toString(),
            );

            String imageURL = await uploadPhotosToServer(apiImageUpload, pr);
            imageModel.values = imageURL;
            var urlAddedJson = imageModel.toJson();
            String urlAddedData = urlAddedJson.toString();
            apiImageList[key] = urlAddedData;
          }

          for (var entry in apiImageList.entries) {
            String key = entry.key;
            String value = entry.value;
            var returnValue = objectBox.storeImageData(
              value,
              widget.formId,
              key,
            );
            print('db return Value :::: $returnValue');
            var splitCatCode = key.split('-')[1];
            int index = formUIJsonData.indexWhere(
              (st) => st.category_code == splitCatCode,
            );
            formUIJsonData[index].imageArrays[0].imageModel = utils
                .stringToImageDataModel(
              value.toString(),
              'parseFormJson',
            );
          }
          return await generateAPIRequest(apiImageList, pr);
        } else {
          return await generateAPIRequest(apiImageList, pr);
        }
      } else {}
    } catch (e) {
      print(e);
    }
  }

  void call() {
    debugPrint('after successfull photos upload generate method call');
  }

  Future generateAPIRequest(
    Map<String, String> apiImageList,
    ProgressDialog pr,
  ) async {
    try {
      debugPrint('after successfull photos upload generate method call');
      List<FormSpecificFields> listOfFormSpecificFields = [];
      for (var value in formUIJsonData) {
        FormSpecificFields mFormSpecificFields = FormSpecificFields();
        if (value.given_answer == 'Yes') {
          mFormSpecificFields.Name = value.category_code;
          mFormSpecificFields.Value = value.given_answer;
          mFormSpecificFields.values = [];
          ImageDataModel imageDataModel = value.imageArrays[0].imageModel;
          ImageAPIModel imageAPIModel = ImageAPIModel(
            values: imageDataModel.values,
            latitude: imageDataModel.latitude,
            longitude: imageDataModel.longitude,
            location: imageDataModel.location,
            photoTakenBy: imageDataModel.photoTakenBy,
            photoTakenAt: imageDataModel.photoTakenAt,
          );
          if (imageDataModel.imageSource!.isNotEmpty) {
            List<ImageAPIModel> photoList = [];
            photoList.add(imageAPIModel);
            FormSpecificFields mFormSpecificFieldsPhoto = FormSpecificFields();
            mFormSpecificFieldsPhoto.Name = value.imageArrays[0].categoryCode;
            mFormSpecificFieldsPhoto.Value = "";
            mFormSpecificFieldsPhoto.values = photoList;
            listOfFormSpecificFields.add(mFormSpecificFieldsPhoto);
          }
        } else {
          mFormSpecificFields.Name = value.category_code;
          mFormSpecificFields.Value = value.given_answer;
          mFormSpecificFields.values = [];
        }
        listOfFormSpecificFields.add(mFormSpecificFields);
      }

      for (var value in listOfFormSpecificFields) {
        debugPrint("value :::: ${value.toJson()}");
      }
      debugPrint(
        'FormSpecificFields  ::::: ${listOfFormSpecificFields.length}',
      );

      List<Forms> mFormsList = [];
      Forms mForms = Forms();
      mForms.formSpecificFields.addAll(listOfFormSpecificFields);
      mFormsList.add(mForms);
      Attributes mAttributes = Attributes();
      mAttributes.VisitId = visitId;
      mAttributes.forms.addAll(mFormsList);
      GateCheckApiRequest mGateCheckApiRequest = GateCheckApiRequest();
      mGateCheckApiRequest.attributes = mAttributes;
      Map<String, dynamic> apiRequest = mGateCheckApiRequest.toJson();

      String token = utils.getAccessToken('telentbee.support@telentbee.co.uk');
      APIService apiService = APIService.instance;
      apiService.configureDio(
        baseURL: 'https://extranet.telent.com/tismobilestaging/api/TISMobile/',
        isAfterLogin: true,
        bearerToken: token,
      );
      Response response = await apiService.postRequest(
        'Create',
        data: apiRequest,
      );
      await pr.hide();
      if (response.statusCode == 200) {
        debugPrint('Response :::: ${response.data}');
        utils.showToast('Form Submitted Successfully');
        Navigator.pop(context);
      } else if (response.statusCode == 400) {
        debugPrint('Error code  :::: ${response.statusMessage}');
        debugPrint('Response :::: ${response.data}');
        await pr.hide();
      } else {
        debugPrint('Error code  :::: ${response.statusMessage}');
      }
    } catch (e) {
        pr.hide();
      debugPrint(e.toString());
    }
  }

  Future<String> uploadPhotosToServer(
    ApiImageUpload apiImageUpload,
    ProgressDialog pr,
  ) async {
    int count = 0;
    try {
      APIService apiService = APIService.instance;
      var imageUploadRequest = jsonEncode(apiImageUpload.toJson());
      // print(imageUploadRequest);
      Map<String, dynamic> map = jsonDecode(imageUploadRequest);
      //  print(map);
      String token = utils.getAccessToken('telentbee.support@telentbee.co.uk');
      print('Bearer token $token');
      apiService.configureDio(
        baseURL: 'https://extranet.telent.com/tismobilestaging/api/TISMobile/',
        isAfterLogin: true,
        bearerToken: token,
      );
      Response response = await apiService.postRequest(
        'Uploadphoto',
        data: map,
      );
      count = count + 1;
      if (response.statusCode == 200) {
        print(response.data);
        final json = response.data as Map<String, dynamic>;
        print('photo URL ::: ${json['url']}');
        /* imageModel.values = json['url'];
        var urlAddedJson = imageModel.toJson();
        String urlAddedData = urlAddedJson.toString();
        apiImageList[key] = urlAddedData;*/
        return json['url'];
      } else {
        print(response.statusCode);
        print(response.statusMessage);
        return '';
      }
    } catch (e) {
      print(e);
      return '';
    }
  }

  void validateFormStatus() {
    isFormCompleted = formUIJsonData.every((val) {
      String answer = val.given_answer.trim();

      if (answer.isEmpty) {
        return false;
      }

      if (answer == 'Yes') {
        if (val.imageArrays == null ||
            val.imageArrays.isEmpty ||
            val.imageArrays[0].imageModel.imageSource == null) {
          return false;
        }
      }

      return true;
    });
    print("isFormCompleted status after every method: $isFormCompleted");
    _updateFormStatus();
  }
}
