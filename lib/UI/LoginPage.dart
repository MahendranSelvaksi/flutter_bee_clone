import 'dart:convert';

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/RequestModels/LoginRequest.dart';
import 'package:flutter1/RequestModels/LoginResponse.dart';
import 'package:flutter1/UI/DashBoardPage.dart';
import 'package:flutter1/main.dart';
import 'package:flutter1/repository/APITokenDetails.dart';
import 'package:flutter1/repository/AllFormData.dart';
import 'package:flutter1/repository/login_response.dart';
import 'package:flutter1/repository/user.dart';
import 'package:flutter1/utils/APIService.dart';
import 'package:flutter1/utils/ConnectionStatusListener.dart';
import 'package:flutter1/utils/Utils.dart';
import 'package:logger/logger.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../RequestModels/UserData.dart';
import '../objectbox.g.dart';
class LoginPage extends StatefulWidget{
  const LoginPage({super.key});


  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
  
}


class LoginState extends State<LoginPage>{
  final logger = Logger();
  Utils utils = Utils();
  var connectionStatus = ConnectionStatusListener.getInstance();
   String _email = "";
   String _password= "";
  final _formKey = GlobalKey<FormState>();
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body:
      Container(
        width: double.infinity,
        height: double.infinity,
        decoration:BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/loginbg.png'),
              fit: BoxFit.fill),
        ),
        child:
       Center(
         child:  SingleChildScrollView(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               ColumnSuper(
                 innerDistance: -20,
                 children: [
                   Container(
                     width: 100.0,
                     height: 100.0,
                     decoration: BoxDecoration(
                         image: DecorationImage(image:AssetImage('assets/images/loginlogo.png')),
                         shape: BoxShape.rectangle,
                         borderRadius: BorderRadius.only( topLeft: Radius.circular(150), topRight: Radius.circular(150),bottomRight: Radius.circular(150),bottomLeft: Radius.circular(150))
                     ),
                   ),//Circle shape Container
                   Container(
                     padding: EdgeInsets.only(left: 40,right: 40),
                     child: ClipRRect(
                       borderRadius: BorderRadius.circular(26.0),
                       child: Container(
                           color: Colors.white,
                           height: 600,
                           width: double.infinity,
                           child: Container(
                             padding: const EdgeInsets.only(left: 20.0,top: 40.0,right: 20.0,bottom: 10.0),
                             child:
                             Form(
                               key: _formKey,
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Text("SIGN IN",
                                       style: TextStyle(
                                           color: Colors.black,
                                           fontSize: 30,
                                           fontWeight: FontWeight.bold
                                       )),
                                   SizedBox(height: 15),
                                   Text("Enter your username and password",
                                       textAlign: TextAlign.left,
                                       style: TextStyle(
                                           color: Colors.black,
                                           fontSize: 15,
                                           height: 2
                                       )),
                                   SizedBox(height: 10),
                                   Text("User name",
                                       textAlign: TextAlign.left,
                                       style: TextStyle(
                                           color: Colors.black,
                                           fontSize: 15,
                                           height: 2
                                       )),
                                   SizedBox(height: 3),
                                   TextFormField(
                                     autovalidateMode: AutovalidateMode.onUserInteraction,
                                     decoration: InputDecoration(
                                         border: OutlineInputBorder()
                                     ),
                                     onChanged: (text){
                                       _email = text;
                                     },
                                     validator: (value) {
                                       if(value == null || value.isEmpty){
                                         return "Email cannot be blank";
                                       }else if (!emailRegex.hasMatch(value)) {
                                         return 'Please enter a valid email';
                                       }
                                       return null;
                                     },
                                     onSaved: (value) => _email = value!,
                                   ),
                                   SizedBox(height: 5),
                                   Text("Password",
                                       textAlign: TextAlign.left,
                                       style: TextStyle(
                                           color: Colors.black,
                                           fontSize: 15,
                                           height: 2
                                       )),
                                   SizedBox(height: 3),
                                   TextFormField(
                                     autovalidateMode: AutovalidateMode.onUserInteraction,
                                     decoration: InputDecoration(
                                         border: OutlineInputBorder()
                                     ),
                                     obscureText: true,
                                     onChanged: (text){
                                       _password = text;
                                     },
                                     validator: (value) {
                                       if(value == null || value.isEmpty){
                                         return "Password cannot be blank";
                                       }
                                       return null;
                                     },
                                     onSaved: (value) => _password = value!,
                                   ),
                                   SizedBox(height: 3),
                                   Text("Forgotten your Password?",
                                       textAlign: TextAlign.left,
                                       style: TextStyle(
                                           color: Colors.purple.shade700,
                                           fontSize: 15,
                                           height: 2,
                                           fontWeight: FontWeight.bold
                                       )),
                                   SizedBox(height: 8),
                                   SizedBox(
                                       width:double.infinity,
                                       child:
                                       ElevatedButton(
                                         onPressed: () async {
                                           if(_formKey.currentState?.validate() ?? false){
                                             print("Email $_email");
                                             print("Password $_password");
                                             bool isInternetConnected=false;
                                             connectionStatus.checkConnection().then((value){
                                               isInternetConnected = value;
                                               print('isInternetConnected ::: $isInternetConnected');
                                               if(isInternetConnected){
                                                 loginApiCall();
                                               }else{
                                                 utils.showToast('Please check with your internet connection...');
                                               }
                                             });
                                           }else{
                                             utils.showToast('Please fill valid login details...');
                                           }
                                         },
                                         style: ElevatedButton.styleFrom( backgroundColor: Colors.purple.shade600,
                                           shape: StadiumBorder(),), child:
                                       Text("Sign In",
                                         style: TextStyle(
                                             color: Colors.white
                                         ),),)
                                   ),
                                 ],
                               ),
                             )
                             ,
                           )
                       ),
                     ),
                   )],
               ),
             ],),
         ),
       ),//Rectangle shape container
      ),
    );
  }

  Future<void> storeData(String data) async {
    final prefs = await SharedPreferences.getInstance();

    // Store the entire JSON response as a string
    await prefs.setString('login_api_response', json.encode(data));

    //Or store specific values from the response:
    //await prefs.setString('name', data['name']);
    //await prefs.setInt('age', data['age']);
  }




  /*Future<void> saveUsers(LoginResponse users) async {
    final store = await ObjectBox.open();
    final box = store.box<LoginResponse>();
    box.put(users);
    store.close(); // Or manage the lifecycle of the Store appropriately
  }*/

 void loginApiCall() async{
   try{
     ProgressDialog pr = utils.getProgressDialog(context, 'Please wait...');
     await pr.show();
     LoginRequest loginRequest = LoginRequest();
     loginRequest.userName= _email.trim();
     loginRequest.password=_password.trim();
     APIService apiService = APIService.instance;
     var user = jsonEncode(loginRequest.toJson());
     print(user);
     //var map = Map<String, dynamic>.from(user as Map<dynamic, dynamic>);
     Map<String, dynamic> map = jsonDecode(user);
     apiService.configureDio(baseURL: 'https://extranet.telent.com/tismobilestaging/api/TISMobile/',isAfterLogin: false,bearerToken: '');
     Response response = await apiService.postRequest('GetAccessToken',data:map);
     await pr.hide();
     if(response.statusCode == 200){
       final responseObject = response.data['ResponseObject'] as List;
       final json = responseObject[0] as Map<String, dynamic>;
       LoginResponse lr = LoginResponse.fromJson(json);
       final loginData = UserLoginData(
           accessToken: lr.accessToken,
           accessTokenExpiryDate: lr.accessTokenExpiryDate,
           accessTokenGeneratedDate: lr.accessTokenGeneratedDate,
           cSSId: lr.cSSId,
           emailId: lr.emailId,
           firstName: lr.firstName,
           isTeamLead: lr.isTeamLead,
           isUpdateSecurityQuestion: lr.isUpdateSecurityQuestion,
           jobTitleDescription: lr.jobTitleDescription,
           jobTitleId: lr.jobTitleId,
           lastName: lr.lastName,
           leadGangerCSSID: lr.leadGangerCSSID,
           operativeTypeDescription: lr.operativeTypeDescription,
           operativeTypeID: lr.operativeTypeID,
           refreshToken: lr.refreshToken,
           refreshTokenExpiryDate: lr.refreshTokenExpiryDate,
           refreshTokenGeneratedDate: lr.refreshTokenExpiryDate,
           userId: lr.userId
       );

       objectBox.addLoginData(loginData);
       final APITokenDetails tokenDetails = APITokenDetails(
           userId: loginData.userId,
           refreshToken: loginData.refreshToken,
           refreshTokenGeneratedDate: loginData.refreshTokenGeneratedDate,
           refreshTokenExpiryDate: loginData.refreshTokenExpiryDate,
           accessToken: loginData.accessToken,
           accessTokenGeneratedDate: loginData.accessTokenGeneratedDate,
           accessTokenExpiryDate: loginData.accessTokenExpiryDate
       );
       objectBox.storeAPITokenDetails(tokenDetails);

       await storeData(response.data['ResponseObject'][0].toString());


       Navigator.push(context, MaterialPageRoute(
           builder: (context) => DashBoardPage()
       )
       );
     }else{
       print(response.statusCode);
     }
   }catch(e){
     print(e);
   }
 }

}

class LoginDB {
}