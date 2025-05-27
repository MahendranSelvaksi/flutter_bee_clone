import 'package:flutter/material.dart';

import '../utils/Utils.dart';

class CommonToolBar extends StatefulWidget {
  final String formName;
  final bool formStatus, isDeleteRequired;

  const CommonToolBar({
    super.key,
    required this.formName,
    required this.formStatus,
    required this.isDeleteRequired,
  });

  @override
  State<StatefulWidget> createState() => _commonToolBar();
}

class _commonToolBar extends State<CommonToolBar> {
  Utils utils = Utils();
  bool photosSwitch = false;

  @override
  Widget build(BuildContext context) {
    return
      Column(
      children: [
        Container(
          height: 80,
          color: Colors.purple,
          child: Padding(padding: EdgeInsets.only(left: 5.0,right: 10.0),
          child:  Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  size: 40,
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 15),
              Text(
                widget.formName,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ],
          ),),
        ),
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.white60,
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 5),
              ),
              BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(-5, 0),
              ),
              BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(5, 0),
              ),
            ],
          ),
          child: Padding(padding: EdgeInsets.only(left: 10.0,right: 10.0),
          child:  Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                // Wrap RichText with Expanded
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Icon(
                          size: 40,
                          widget.formStatus == true ? Icons.bookmark_added : Icons.circle_outlined,
                          color:  widget.formStatus == true ? Colors.green : Colors.deepOrangeAccent,
                        ),
                      ),
                      TextSpan(
                        text:
                        widget.formStatus == true
                            ? 'Completed'
                            : 'In progress',
                        style: TextStyle(color:  widget.formStatus == true ? Colors.green : Colors.deepOrangeAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon( size: 40,Icons.delete_outline, color: Colors.purple),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon( size: 40,Icons.camera_alt_outlined, color: Colors.purple),
              ),
            ],
          ),),
        )
      ],
    );
  }
}
