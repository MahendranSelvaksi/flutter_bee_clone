import 'package:flutter/material.dart';
import 'package:flutter1/RequestModels/questions.dart';
import 'package:flutter1/UI/SingleImageView.dart';
import 'package:flutter1/repository/AllFormData.dart';
import 'package:flutter1/utils/Utils.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class RadioQuestionView extends StatefulWidget {
  final Questions questionsData;
  final List<AllFormData> answerDataList;
  final String formId;
  final String userId;
  final String visitId;

  const RadioQuestionView({
    super.key,
    required this.questionsData,
    required this.radioValueChanged,
    required this.photoValueChanged,
    required this.formId,
    required this.userId,
    required this.answerDataList,
    required this.formUIDataChanged,
    required this.visitId,
  });

  final ValueChanged<AllFormData> radioValueChanged;

  final ValueChanged<AllFormData> photoValueChanged;

  final ValueChanged<Questions> formUIDataChanged;

  @override
  State<StatefulWidget> createState() => _radioQuestionViewState();
}

class _radioQuestionViewState extends State<RadioQuestionView> {
  late int selectedRadio;
  late bool isVisiblePhotoQuestion;

  late AllFormData answerData;

  @override
  void didUpdateWidget(RadioQuestionView oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('Comes didUpdateWidget :::: ${widget.questionsData.given_answer}');
    initializeRadioButtonValue('didUpdateWidget');
    //selectedRadio = widget.questionsData.given_answer.isEmpty ? -1 : int.parse(widget.questionsData.given_answer);
    // setSelectedRadio(selectedRadio,widget.questionsData.given_answer,widget.questionsData);
  }

  @override
  void initState() {
    super.initState();
    print('Comes init state');
    selectedRadio = 0;
    isVisiblePhotoQuestion = false;
    initializeRadioButtonValue('initState');
  }

  setSelectedRadio(int val, String selectedValue, Questions item) {
    print('Comes setSelectedRadio');
    setState(() {
      selectedRadio = val;
      isVisiblePhotoQuestion = selectedValue == 'Yes';
      print(
        "setSelectedRadio ${item.category_code}   setSelectedRadio :::: $val",
      );
      print(
        "setSelectedRadio ${item.category_code} :: ${item.given_answer}  selectedValue :::: $selectedValue",
      );
      widget.questionsData.given_answer = selectedValue;
      /*AllFormData allFormData = AllFormData(
        userId:
      )*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  widget.questionsData.question,
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
          OverflowBar(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Radio(
                          value: 1,
                          activeColor: Colors.purple,
                          groupValue: selectedRadio,
                          onChanged: (val) {
                            print("Radio $val");
                            setSelectedRadio(val!, 'Yes', widget.questionsData);
                            updateAnswerData('Yes');
                          },
                        ),
                        Expanded(
                          child: Text('Yes', style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Radio(
                          value: 2,
                          activeColor: Colors.purple,
                          groupValue: selectedRadio,
                          onChanged: (val) {
                            print("Radio $val");
                            setSelectedRadio(val!, 'No', widget.questionsData);
                            updateAnswerData('No');
                          },
                        ),
                        Expanded(
                          child: Text('No', style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Visibility(
            visible: isVisiblePhotoQuestion,
            child: SingleImageView(
              imageQuestionsData: widget.questionsData.imageArrays.first,
              photoValueChanged: (AllFormData value) {
                widget.photoValueChanged(value);
              },
              answerData:
                  widget.answerDataList.length == 2
                      ? widget.answerDataList[1]
                      : AllFormData(),
              formId: widget.formId,
              visitId: widget.visitId,
              userId: widget.userId,
              parentCatCode: widget.questionsData.category_code,
            ),
          ),
        ],
      ),
    );
  }

  void updateAnswerData(String answer) {
    if (answerData.formId != null && answerData.formId!.isNotEmpty) {
      print('comes updateAnswerData IF block ');
      answerData.answer = answer;
      answerData.modifiedAt = DateTime.now();
    } else {
      print('comes updateAnswerData else block');
      answerData.userId = widget.userId;
      answerData.formId = widget.formId;
      answerData.createdAt = DateTime.now();
      answerData.createdOn = DateTime.parse(Utils().getCurrentDateOnly());
      answerData.catCode = widget.questionsData.category_code;
      answerData.questionType = widget.questionsData.type;
      answerData.formName = 'Gate Check Form';
      answerData.orderNumber = 'Gate Check Form';
      answerData.scheduleId = 'Gate Check Form';
      answerData.visitId = widget.visitId;
      answerData.answer = answer;
      answerData.isVisible = true;
    }
    widget.radioValueChanged(answerData);
  }

  void initializeRadioButtonValue(String from) {
    answerData =
        widget.answerDataList.isNotEmpty
            ? widget.answerDataList[0]
            : AllFormData();
    print("answer Data :::: ${answerData}");
    print('Comes initializeRadioButtonValue method :::::: $from');
    print(
      'widget.questionsData.given_answer :::::: ${widget.questionsData.given_answer}',
    );
    if (widget.questionsData.given_answer.isEmpty) {
      selectedRadio = -1;
    } else if (widget.questionsData.given_answer == 'Yes') {
      selectedRadio = 1;
    } else if (widget.questionsData.given_answer == 'No') {
      selectedRadio = 2;
    }
    print('selectedRadio ###### $selectedRadio');
    setSelectedRadio(
      selectedRadio,
      widget.questionsData.given_answer,
      widget.questionsData,
    );
  }
}
