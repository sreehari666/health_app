import 'package:flutter/material.dart';
import 'package:health_app/services/authservices.dart';
import 'package:health_app/services/constant.dart';
import 'package:health_app/services/storage.dart';

AuthService authService = AuthService();
SecureStorage secureStorage = SecureStorage();

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key, Object? model, Object? model1}) : super(key: key);
 
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}
 
class _AuthScreenState extends State<AuthScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Patient',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              SizedBox(height: 20,),
              
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () {

                      authService.login(nameController.text,passwordController.text).then((val){
                        print(val);
                        if(val.data["success"] == true){
                          userId = val.data["userid"];
                          loggedin = true;
                          secureStorage.writeSecureData("userid", val.data["userid"]);
                          
                           Navigator.of(context).pushNamed(HOME);
                        }else{
                          loggedin = false;
                        }
                      });

                      print(nameController.text);
                      print(passwordController.text);
                    },
                  )
              ),
              Row(
                // ignore: sort_child_properties_last
                children: <Widget>[
                  const Text('Don\'t have an account?'),
                  TextButton(
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(SIGN_UP);
                      //signup screen
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          )),
    );
  }
}