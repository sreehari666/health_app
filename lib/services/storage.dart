import 'package:shared_preferences/shared_preferences.dart';
class SecureStorage{

 
  Future writeSecureData(String key,String value) async {

     SharedPreferences prefs = await SharedPreferences.getInstance();

     prefs.setString(key, value);

     return true;


  }

  Future readSecureData(String key) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var readData = prefs.getString(key);

    return readData;


  }

  Future deleteSecureData(String key) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(key);

    return true;


  }

}