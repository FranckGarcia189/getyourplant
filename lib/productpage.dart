import 'package:flutter/material.dart';
import 'package:getyourplant/dbmanager.dart';
import 'package:getyourplant/navigationmanager.dart';
import 'package:sqflite/sqflite.dart';
import 'package:getyourplant/plant.dart';

class ProductPage extends StatefulWidget { 
  const ProductPage({ Key? key, required this.db , required this.dbManager, required this.plantId}) : super(key: key);
  final Database db;
  final DbManager dbManager;
  final int ?plantId;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  final NavigationManager navigationManager = NavigationManager.instance;

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: const Text('back store'),
        backgroundColor: Colors.lightGreen,
        actions: [
          IconButton(
            onPressed: null, 
            icon: Icon(Icons.menu_outlined, color: Colors.white)
          )
        ],
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Text("Coucou"),
        )
    );
    return scaffold;
  }

}