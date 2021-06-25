import 'package:flutter/material.dart';
import 'package:getyourplant/dbmanager.dart';
import 'package:getyourplant/homepage.dart';
import 'package:getyourplant/productpage.dart';
import 'package:getyourplant/storepage.dart';
import 'package:getyourplant/signinpage.dart';
import 'package:sqflite/sqflite.dart';

class NavigationManager {

  NavigationManager._privateconstructor();
  static final NavigationManager instance = NavigationManager._privateconstructor();

  void goSignIn(BuildContext context, Database db, DbManager dbManager) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage(db: db, dbManager: dbManager,)));
  }

   void goHome(BuildContext context, Database db, DbManager dbManager) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(db: db, dbManager: dbManager,)));
  }

  void goStore(BuildContext context, Database db, DbManager dbManager) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => StorePage(db: db, dbManager: dbManager,)));
  }

  void goProduct(BuildContext context, Database db, DbManager dbManager, int ?plantId) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(db: db, dbManager: dbManager, plantId: plantId)));
  }

}