import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter1/repository/AllFormData.dart';


const List<String> list = <String>['Civils', 'Asset', 'Cable', 'Civils Reinstator'];

class DropDownView extends StatefulWidget{
  final AllFormData answerData;
  const DropDownView({super.key, required this.answerData, required this.dropDownValueChanged});

final ValueChanged<AllFormData> dropDownValueChanged;

  @override
  State<DropDownView> createState() => _DropDownState();

}

typedef MenuEntry = DropdownMenuEntry<String>;

class _DropDownState extends State<DropDownView>{


  String dropdownValue = 'Select option';
  static final List<MenuEntry> menuEntries = UnmodifiableListView<MenuEntry>(
    list.map<MenuEntry>((String name) => MenuEntry(value: name, label: name)),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
    child:DropdownMenu(
      width: double.infinity,
      hintText: dropdownValue,
      dropdownMenuEntries: menuEntries,
    initialSelection: dropdownValue,
    onSelected: (String? value){
      dropDownValueSelected(value!);
    },));
  }

  Future<void> dropDownValueSelected(String? value) async{
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      print('dropDownValueSelected :::: ::::  $value');
      if(value != null && value.isNotEmpty){
        dropdownValue = value;
        widget.answerData.answer=dropdownValue;
        widget.answerData.catCode='dropDown';
        widget.dropDownValueChanged(widget.answerData);
      }
    });
  }

  @override
  void didUpdateWidget(DropDownView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.answerData.answer != oldWidget.answerData.answer) {
      dropDownValueSelected(widget.answerData.answer);
    }

  }

  @override
  void initState() {
    super.initState();
    print('Comes init state ::::: ${widget.answerData.answer}');
    dropDownValueSelected(widget.answerData.answer);
  }


}