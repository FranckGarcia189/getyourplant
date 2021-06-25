import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:getyourplant/homepage.dart';
import 'package:getyourplant/dbmanager.dart';
import 'package:sqflite/sqflite.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  DbManager dbManager = DbManager.instance;
  //Init app database
  Database db = await dbManager.checkDatabaseExists();
  //Init database datas
  dbManager.initDatas(db);

  runApp(MyApp(db: db, dbManager: dbManager));

}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key, required this.db , required this.dbManager}) : super(key: key);
  final Database db;
  final DbManager dbManager;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var themeData = ThemeData(
        primarySwatch: Colors.green,
      );
    return MaterialApp(
      title: 'Get your plant',
      theme: themeData,
      home: HomePage(db : db, dbManager: dbManager),
    );
  }
}