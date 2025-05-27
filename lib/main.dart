import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter1/repository/login_response.dart';
import 'package:flutter1/repository/user.dart';
import 'package:flutter1/utils/object_box.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UI/DashBoardPage.dart';
import 'UI/LoginPage.dart';
import 'UI/ToggleButton.dart';


late ObjectBox objectBox;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.init();
  runApp(MaterialApp(home: SplashPage()));
}

class SplashPage extends StatefulWidget{
  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }

}

class SplashState extends State<SplashPage>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initScreen(context),
    );
  }

  Future<String> getStoredApiResponse() async {
    final prefs = await SharedPreferences.getInstance();
    String userName ='';

    // Retrieve the JSON string
    final storedJsonString = prefs.getString('login_api_response');

    if (storedJsonString != null) {
      // Decode the JSON string
      print(storedJsonString);
      return storedJsonString;
    } else {
      return "";
    }
  }

  @override
  void initState() {
    super.initState();
  startTime();
  }

  route() {
    var isLogin='';
    getStoredApiResponse().then((value){
      print("Login session::: $value");
      if(value.isNotEmpty){
        isLogin = jsonEncode(value);
      }
      print("isLogin :::: $isLogin");
      if(isLogin.isEmpty){
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => LoginPage()
        )
        );
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => DashBoardPage()
        )
        );
      }
    });

  }

  initScreen(BuildContext context){
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/splash.png"),
              fit: BoxFit.fill
          ),
        ),
        child: null,
      ),
    );
  }

  startTime()async{
    var duration = Duration(seconds: 5);
    return Timer(duration, route);
  }
}

class SecondScreen extends StatelessWidget{
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Second Activity"),
    );
  }



}
