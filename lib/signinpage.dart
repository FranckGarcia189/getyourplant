import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getyourplant/dbmanager.dart';
import 'package:getyourplant/navigationmanager.dart';
import 'package:sqflite/sqflite.dart';
import 'package:getyourplant/user.dart';

class SignInPage extends StatefulWidget { 
  const SignInPage({ Key? key, required this.db , required this.dbManager}) : super(key: key);
  final Database db;
  final DbManager dbManager;

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final NavigationManager navigationManager = NavigationManager.instance;

  final loginController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String msgSecure = "";

  bool checkEmptyInput() {
    if ( loginController.text != "" && emailController.text != "" 
    && passwordController.text != "" && confirmPasswordController.text != "") {
      return true;
    }
    else {
      setState(() {
        msgSecure = "Please, all fields should be completed";
      });
      return false;
    }
  }

  Future<bool> createUserRequest() async {
    String date = DateTime.now().toString();
    if (confirmPasswordController.text == passwordController.text && checkEmptyInput() == true) {

      User user = new User(userLogin: loginController.text, userEmail: emailController.text, userPassword: passwordController.text, userCreationDate: date);

      if(await widget.dbManager.insertUser(widget.db, user) == true ) {
        setState(() {
          msgSecure = "Subscription complete !";
        });
        sleep(Duration(seconds:3));
        navigationManager.goHome(context, widget.db, widget.dbManager);
        return true;
      }
      else {
        return false;
      }
    }
    else { return false; }   
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [const Color.fromARGB(250, 238, 245, 238), const Color.fromARGB(240, 210, 235, 210)]
          )
      ),
      child :    
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.all(30.0),
            child: 
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/getyourplant_icon.png", width: 50, height: 50),
                  const Text("Get your plant", style: 
                    TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16
                    ),
                  ),
                  const SizedBox(height: 25),
                  const SizedBox(
                    height: 25.0,
                    width: double.infinity,
                    child: Text(
                      "Create your account",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blueGrey,
                        )
                      )
                  ),
                  SizedBox(
                    height: 25.0,
                    child: Text(msgSecure, style: TextStyle(color: Colors.redAccent, fontSize: 15 )),
                  ),
                  TextField(
                    controller: loginController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.account_circle_outlined),
                        labelText: 'Enter a login name',
                        isDense: true,
                        contentPadding: EdgeInsets.all(8)
                    )
                  ),
                  const SizedBox(height: 25),
                  TextField(
                    controller: emailController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.email_outlined),
                        labelText: 'Enter a valid email',
                        isDense: true,
                        contentPadding: EdgeInsets.all(8)
                    )
                  ),
                  const SizedBox(height: 25),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.lock_outline),
                        labelText: 'Choose your password',
                        isDense: true,
                        contentPadding: EdgeInsets.all(8)
                    )
                  ),
                  const SizedBox(height: 25),
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm your password',
                        isDense: true,
                        contentPadding: EdgeInsets.all(12)
                    )
                  ),
                  SizedBox(height: 25.0,),
                  SizedBox(
                    width: double.infinity ,
                    child :
                      ElevatedButton(
                        onPressed: () => createUserRequest(),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.lightGreen)
                        ),
                        child: Text("Sign In", 
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            )
                          ),
                      )
                  ),
                  SizedBox(
                    height: 25.0, 
                    width: double.infinity ,                   
                    child: ElevatedButton(
                      onPressed: () => navigationManager.goHome(context, widget.db, widget.dbManager),
                      child: 
                        Text(                    
                          "Back to login", 
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 15                           
                            ),
                        ),
                      style : ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                          alignment: Alignment.bottomRight,
                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
                          shadowColor: MaterialStateProperty.all<Color>(Colors.transparent)
                        )
                    )       
                  ),
                ],
              )
            ),
          )
        )
    );
  }



}