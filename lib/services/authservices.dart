import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'constant.dart';
import 'storage.dart';
import 'url.dart';

final SecureStorage secureStorage = SecureStorage();

class AuthService {

  var response;
  Dio dio = new Dio();

  login(email, password) async {
    
    // secureStorage.deleteSecureData('loggedin').then((value) {
    //   print(value);
    // });
    // secureStorage.deleteSecureData('token').then((value) {
    //   print(value);
    // });
    // secureStorage.deleteSecureData('email').then((value) {
    //   print(value);
    // });
     var res;
    // print(email);
    // print(password);

    // secureStorage.writeSecureData('email', email);

    

    try {
      Response response =
          await dio.post(URL+'/patient/patient-login',
              data: {
                "email": email,
                "password": password,
              },
              options: Options(contentType: Headers.formUrlEncodedContentType));
      res = response;
      print(response); 
      // print(response.data['success']);

      // print(response.data['token']);
      
      // if (response.statusCode == 200) {
      //   print(response.data['msg']);
      // }

      // if (response.data['success'] == true) {
      //   secureStorage.writeSecureData('loggedin', 'ok');
      //   secureStorage.writeSecureData('token', response.data['token']);

      //   secureStorage.readSecureData('token').then((value) {
      //     token = value;
      //     print(token);
      //   });
      //   secureStorage.readSecureData('loggedin').then((value) {
      //     finalLoggedIN = value;
      //     print(finalLoggedIN);
      //   });
        // secureStorage.readSecureData('email').then((value) {
        //   finalEmail = value;
        //   print(finalEmail);
        // });
      // } else {
      //   secureStorage.writeSecureData('loggedin', 'no');
      // }

    } catch (e) {
      print(e);
    }

    return res;
  }

  signup(name, email,age,num, password) async {
    var res;
    print(name);
    print(email);
    print(password);
    
    try {
      Response response =
          await dio.post(URL+'/patient/patient-signup',
              data: {
                "name": name,
                "email": email,
                "age":age,
                "number":num,
                "password": password,
              },
              options: Options(contentType: Headers.formUrlEncodedContentType));

      res = response;
      if (response.statusCode == 200) {
        print(response);
      }
      if (response.data['successs'] == false) {
        Fluttertoast.showToast(
            msg: "You already have an account",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      if (response.data['success'] == true) {
        Fluttertoast.showToast(
            msg: "signup success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      if (response.data['success'] == false) {
        Fluttertoast.showToast(
            msg: "signup failed, something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response?.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return res;
  }

  Future docDetails() async{
    var res;
    try {
      Response response =
          await Dio().get(URL+'/patient/get-doctor-details');
      
      res = response;
      print("object");
      print(res);
    } on DioError catch (e) {
      print(e);
    }
    return res;
  }

  appointment(patientid,doctorId) async{

    try {
      Response response =
          await dio.post(URL+'/patient/appointment',
              data: {
                "patientid": patientid,
                "doctorid":doctorId,
              },
              options: Options(contentType: Headers.formUrlEncodedContentType));

      
    return response;

  }catch(e){
    print(e);
  }

}

Future<bool> patient_logout() async{
  userId = null;
  loggedin = false;
  var res;
    try {
      Response response =
          await Dio().get(URL+'/patient/patient-logout');
      
      res = response;
      
      print(res);
    } on DioError catch (e) {
      print(e);
    }

    if(res){
      return true;
    }else{
      return false;
    }
    

}

}