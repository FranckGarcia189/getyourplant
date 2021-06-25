import 'package:flutter/material.dart';
import 'package:getyourplant/dbmanager.dart';
import 'package:getyourplant/navigationmanager.dart';
import 'package:sqflite/sqflite.dart';
import 'package:getyourplant/plant.dart';

class StorePage extends StatefulWidget { 
  const StorePage({ Key? key, required this.db , required this.dbManager}) : super(key: key);
  final Database db;
  final DbManager dbManager;

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {

  final NavigationManager navigationManager = NavigationManager.instance;

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    var scaffold = Scaffold(
      appBar: AppBar(
        title: const Text('back home'),
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
                  height: MediaQuery.of(context).size.height,
                  child:
                    Center(
                      child:
                        Column(         
                          children : [
                            const SizedBox(height: 10.0),
                            const SizedBox(
                              height: 25.0,
                              width: double.infinity,
                              child: Text(
                                "Our last plants",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blueGrey,
                                  )
                                )
                            ),
                            const SizedBox(height: 10.0),
                            Expanded(
                              child: FutureBuilder<List<Plant>>(
                                future: widget.dbManager.getAllPlants(widget.db),
                                builder: (context, snapshot) {
                                  return snapshot.hasData
                                      ? ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: snapshot.data?.length,
                                          itemBuilder: (_, int position) {
                                            final item = snapshot.data?[position];
                                                return Container(
                                                    height: 200.0,
                                                    width: 200.0,
                                                    child: Card( 
                                                      child:
                                                        Column(
                                                          children: [
                                                            Image.asset("assets/images/"+item!.plantPhotoPath.toString(), width: 120, height:110),
                                                            ListTile(
                                                              minVerticalPadding: 10,
                                                              title: Text(
                                                                item.plantName.toString(),
                                                                style: TextStyle(
                                                                  color: Colors.blueGrey,
                                                                  fontSize: 17,
                                                                  fontWeight: FontWeight.w500
                                                                ),  
                                                              ),
                                                              subtitle: Text(
                                                                "Origine : " + item.plantOrigin.toString()
                                                                + "\nPrix : "+item.plantPrice.toString() + " euros / unité",
                                                                style: TextStyle(
                                                                  color: Colors.blueGrey,
                                                                )
                                                              ),
                                                              
                                                            ),
                                                            SizedBox(
                                                                width: 160 ,
                                                                height: 20,
                                                                child :
                                                                  ElevatedButton(
                                                                    onPressed: () => navigationManager.goProduct(context, widget.db, widget.dbManager, item.plantId),
                                                                    style: ButtonStyle(
                                                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.lightGreen)
                                                                    ),
                                                                    child: Text("Voir le produit", 
                                                                      style: TextStyle(
                                                                            fontSize: 12,
                                                                        color: Colors.white,
                                                                        )
                                                                      ),
                                                                  )
                                                            ),
                                                          ],
                                                        )   
                                                    ),
                                                  );
                                          },
                                        )
                                      : Center(
                                          child: Text("Coucou"),
                                        );
                                  }, 
                              )
                            ),
                            const SizedBox(height: 25.0),
                            const SizedBox(
                              height: 25.0,
                              width: double.infinity,
                              child: Text(
                                "Discover Complete Catalog",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blueGrey,
                                  )
                                )
                            ),
                            const SizedBox(height: 10.0),
                            Expanded(
                              child: FutureBuilder<List<Plant>>(
                                future: widget.dbManager.getAllPlants(widget.db),
                                builder: (context, snapshot) {
                                  return snapshot.hasData
                                      ? ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount: snapshot.data?.length,
                                          itemBuilder: (_, int position) {
                                            final item = snapshot.data?[position];
                                            return Card(           
                                                  child: 
                                                    ListTile(
                                                      minVerticalPadding: 10,
                                                      title: Text(
                                                        item!.plantName.toString(),
                                                        style: TextStyle(
                                                          color: Colors.blueGrey,
                                                          fontSize: 17,
                                                          fontWeight: FontWeight.w500
                                                        ),  
                                                      ),
                                                      subtitle: Column(
                                                        children: [
                                                          Text(
                                                            "Origine : " + item.plantOrigin.toString()
                                                            + "\nPrix : "+item.plantPrice.toString() + " euros / unité",
                                                            style: TextStyle(
                                                              color: Colors.blueGrey,
                                                            ),        
                                                          ),
                                                          SizedBox(height: 5.0),
                                                          SizedBox(
                                                                width: 160 ,
                                                                height: 20,
                                                                child :
                                                                  ElevatedButton(
                                                                    onPressed: () => navigationManager.goProduct(context, widget.db, widget.dbManager, item.plantId),
                                                                    style: ButtonStyle(
                                                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.lightGreen)
                                                                    ),
                                                                    child: Text("Voir le produit", 
                                                                      style: TextStyle(
                                                                        fontSize: 12,
                                                                        color: Colors.white,
                                                                        )
                                                                      ),
                                                                  )
                                                          ),
                                                        ],
                                                        ),
                                                      leading: Image.asset("assets/images/"+item.plantPhotoPath.toString(), width: 130, height:130),    
                                                    ), 
                                                );
                                          },
                                        )
                                      : Center(
                                          child: Text("Coucou"),
                                        );
                              }, 
                          )
                        ), 
                      ]     
                    ),
                ),
              ),
            ),
        );
    return scaffold;
  }
}