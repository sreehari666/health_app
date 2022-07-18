import 'package:flutter/material.dart';
import 'package:health_app/screens/auth.dart';
import 'package:health_app/screens/detail_screen.dart';
import 'package:health_app/screens/home_page_screen.dart';
import 'package:health_app/screens/my_appointments.dart';
import 'package:health_app/screens/sign_up.dart';
import 'package:health_app/services/authservices.dart';
import 'package:health_app/services/constant.dart';
import 'package:health_app/services/storage.dart';
import 'package:health_app/theme/theme.dart';

SecureStorage secureStorage = SecureStorage();
AuthService authService = AuthService();
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    secureStorage.readSecureData('userid').then((value){
      userId = value;
      if(userId == null){
        loggedin = false;
      }
    });
    

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health Care App',
      theme:AppTheme.lightTheme,
      home: loggedin == true ? HomePageScreen():const AuthScreen(),
      //home: HomePageScreen(),
      routes: <String, WidgetBuilder>{
        
        HOME:(BuildContext context) =>  loggedin == true? HomePageScreen():const AuthScreen(),
        SIGN_IN: (BuildContext context) =>  const AuthScreen(),
        SIGN_UP: (BuildContext context) =>  const SignupScreen(),
        //DETAIL_SCREEN: (BuildContext context) =>  DetailScreen(),
        APPOINTMENT:(BuildContext context) =>  AppointmentScreen(),
        
        
      },
     
    );
  }
}

