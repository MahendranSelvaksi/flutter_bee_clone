import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ActiveInActiveToggle extends StatefulWidget {

  const ActiveInActiveToggle({super.key,
    required this.onActiveStatusChanged,
    required String selectedState});

  final ValueChanged onActiveStatusChanged;


  @override
  ActiveInActiveToggleState createState() => ActiveInActiveToggleState();
}

const double width = 300.0;
const double height = 60.0;
const double loginAlign = -1;
const double signInAlign = 1;
/*const Color selectedColor = Colors.white;
const Color normalColor = Colors.black54;*/

const Color _inActiveColor = Colors.grey;
const Color _activeColor = Colors.green;
const Color _normalColor = Colors.white;

const Color _inActiveTextColor = Colors.grey;
const Color _activeTextColor = Colors.white;



class ActiveInActiveToggleState extends State<ActiveInActiveToggle> {
  late double xAlign;
 /* late Color loginColor;
  late Color signInColor;*/

  late Color activeColor;
  late Color activeTextColor;
  late Color inActiveColor;
  late Color inActiveTextColor;

  late Color animationColor;

  String selectedState = "You are inactive now";
  Color activeInActiveColor =  _inActiveColor;

  @override
  void initState() {
    super.initState();
    xAlign = loginAlign;
    /*loginColor = selectedColor;
    signInColor = normalColor;*/
    inActiveColor = _inActiveColor;
    activeColor = _normalColor;
    animationColor= _inActiveColor;

    inActiveTextColor = _activeTextColor;
    activeTextColor = _inActiveTextColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: Alignment(xAlign, 0),
            duration: Duration(milliseconds: 300),
            child: Container(
              width: width * 0.5,
              height: height,
              decoration: BoxDecoration(
                color: animationColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                xAlign = loginAlign;
                inActiveColor=_inActiveColor;
                activeColor = _normalColor;
                animationColor = _inActiveColor;

                inActiveTextColor= _activeTextColor;
                activeTextColor = _inActiveTextColor;
                selectedState = "You are inactive now";
                activeInActiveColor =_inActiveColor;
                widget.onActiveStatusChanged(selectedState);
              });
            },
            child: Align(
              alignment: Alignment(-1, 0),
              child: Container(
                width: width * 0.5,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  'InActive',
                  style: TextStyle(
                    color: inActiveTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                xAlign = signInAlign;

                inActiveColor=_normalColor;
                activeColor = _activeColor;
                animationColor = _activeColor;

                inActiveTextColor= _inActiveTextColor;
                activeTextColor = _activeTextColor;

                selectedState = "You are active now";
                activeInActiveColor = _activeColor;
                widget.onActiveStatusChanged(selectedState);
              });
            },
            child: Align(
              alignment: Alignment(1, 0),
              child: Container(
                width: width * 0.5,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  'Active',
                  style: TextStyle(
                    color: activeTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('inActiveColor', inActiveColor));
  }
}