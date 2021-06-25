import 'package:flutter/material.dart';
import 'package:getyourplant/navigationmanager.dart';
import 'package:getyourplant/storepage.dart';
import 'package:getyourplant/dbmanager.dart';
import 'package:sqflite/sqflite.dart';

// Widget class for home app page
class HomePage extends StatefulWidget {
  const HomePage({ Key? key, required this.db , required this.dbManager}) : super(key: key);
  final Database db;
  final DbManager dbManager;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final NavigationManager navigationManager = NavigationManager.instance;

  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  String msgSecure = "";
  
  void connectToStore() async {
    if (await widget.dbManager.checkUser(widget.db, loginController.text, passwordController.text) == true) {
      navigationManager.goStore(context, widget.db, widget.dbManager);
    }
    else {
      setState(() {
        msgSecure = "Connexion error, please try again";
      });
    }   
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
                  Image.asset("assets/images/getyourplant_icon.png", width: 90, height: 90),
                  const Text("Get your plant", style: 
                    TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 18
                    ),
                  ),
                  const SizedBox(height: 25.0,
                    child: Text(
                      "Make your life more green...",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
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
                        labelText: 'Login',
                        isDense: true,
                        contentPadding: EdgeInsets.all(8)
                    )
                  ),
                  SizedBox(height: 25.0,),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.lock_outline),
                        labelText: 'Password',
                        isDense: true,
                        contentPadding: EdgeInsets.all(8)
                    )
                  ),
                  SizedBox(height: 25.0,),
                  SizedBox(
                    width: double.infinity ,
                    child :
                      ElevatedButton(
                        onPressed: () => connectToStore(),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.lightGreen)
                        ),
                        child: Text("Connect", 
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
                      onPressed: () => navigationManager.goSignIn(context, widget.db, widget.dbManager),
                      child: 
                        Text(                    
                          "Not registered ? Sign up here", 
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