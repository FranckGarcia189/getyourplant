import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              child:
                Container(
                  height: MediaQuery.of(context).size.height + 70,
                  width: double.infinity,
                  child: FutureBuilder<Plant>(
                    future: widget.dbManager.getPlant(widget.db, widget.plantId),
                    builder: (context, snapshot) {
                      return snapshot.hasData ?
                              Card(
                                color: Colors.white,
                                child: 
                                  Container( 
                                    height: MediaQuery.of(context).size.height,
                                    padding: EdgeInsets.all(20.0),
                                    child:
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Image.asset("assets/images/"+snapshot.data!.plantPhotoPath.toString()),
                                          const SizedBox(height: 10.0),
                                          Text(
                                            snapshot.data!.plantName.toString(),
                                            style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 20, 
                                              )
                                          ),
                                          const SizedBox(height: 10.0),
                                          Text(
                                            "Origine : " + snapshot.data!.plantOrigin.toString(),
                                            style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 16, 
                                              )
                                          ),
                                          const SizedBox(height: 10.0),
                                          Text(
                                            "Prix : " + snapshot.data!.plantPrice.toString() + "euros / unité",
                                            style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 16, 
                                              )
                                          ),
                                          const SizedBox(height: 10.0),
                                          Text(
                                            "Description :",
                                            style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 16, 
                                              )
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            snapshot.data!.plantDescription.toString(),
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 15,  
                                              )
                                          ),
                                          SizedBox(height: 10.0),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 100,
                                                child: TextFormField( 
                                                    decoration: InputDecoration(
                                                        border: OutlineInputBorder(),
                                                        labelText: 'Qty',
                                                        isDense: true,
                                                        contentPadding: EdgeInsets.all(8)
                                                      ),        
                                                    keyboardType: TextInputType.number,
                                                    inputFormatters: <TextInputFormatter>[
                                                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                    ],
                                                ),
                                              ),
                                              SizedBox(width: 20,),
                                              SizedBox(
                                                width: 100,
                                                child: ElevatedButton(                                    
                                                    onPressed: null,
                                                    style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.lightGreen),
                                                    ),
                                                    child: Text("Get now", style: TextStyle(color: Colors.white,)),
                                                ),
                                              ), 
                                            ],
                                          ),
                                        ],
                                      ),
                              )
                          )
                        : Center(
                          child: Text("Coucou"),
                        );        
                    },
                  ),
          ),
      ),
    );
    return scaffold;
  }

}