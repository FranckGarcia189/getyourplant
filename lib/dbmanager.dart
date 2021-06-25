import "package:path/path.dart";
import 'package:sqflite/sqflite.dart';
import 'package:getyourplant/plant.dart';
import 'package:getyourplant/user.dart';

class DbManager {

  DbManager._privateconstructor();
  static final DbManager instance = DbManager._privateconstructor();

  // Verifier que la base existe, sinon initialiser
  Future<Database> checkDatabaseExists() async {
    //path vers la base de donnees
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'dbgetyourplant.db');
    bool exists = await databaseFactory.databaseExists(path);
    if ( exists == true) {
      print("=> db exists");
      return getDb(databasesPath);
    }
    else {
      print("=> init db");
      return initDb(databasesPath);
    }
  } 

  // Initialiser la base de donnees
  Future<Database> initDb(String databasesPath) async {
    return openDatabase(
      join(databasesPath, 'dbgetyourplant.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE USER (userId INTEGER PRIMARY KEY AUTOINCREMENT, userLogin TEXT NOT NULL, userEmail TEXT NOT NULL, userPassword TEXT NOT NULL, userCreationDate TEXT)",
        );
        await database.execute(
          "CREATE TABLE PLANT(plantId INTEGER PRIMARY KEY AUTOINCREMENT, plantName TEXT NOT NULL, plantOrigin TEXT, plantDescription TEXT,plantPhotoPath TEXT NOT NULL, plantPrice REAL NOT NULL, plantCreationDate TEXT)"
        );
        await database.execute(
          "CREATE TABLE USERFAVORITE(userId INTEGER PRIMARY KEY AUTOINCREMENT, plantId INTEGER NOT NULL)"
        );
      },
      version: 1,
    );
  }

  // Connexion a la base de donnees
  Future<Database> getDb(String databasesPath) async {
    return openDatabase(
      join(databasesPath, 'dbgetyourplant.db'),
      version: 1,
    );
  }

  // Ajouter une plante à la base
  Future<bool> insertPlant(Database db, Plant plant) async {
      /// Adds plant to table
      await db.insert("PLANT", plant.toMap());
      return true;
  }

  // Récuperer toutes les plantes de la table
  Future<List<Plant>> getAllPlants(Database db) async {
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('PLANT');
    print("ok query");
    // Convertir la liste de Map en liste de Plantes
    return List.generate(maps.length, (i) {
      return Plant.fromMap(maps[i]);
    });
  }

  Future<List<Plant>> getLastPlants(Database db) async {
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT TOP(5) * FROM PLANT ORDER BY plantId DESC');
    print("ok query last");
    // Convertir la liste de Map en liste de Plantes
    return List.generate(maps.length, (i) {
      return Plant.fromMap(maps[i]);
    });
  }

  // Ajouter un User à la base
  Future<bool> insertUser(Database db, User user) async {
      /// Adds plant to table
      await db.insert("USER", user.toMap());
      return true;
  }

  // Check d'un User
  Future<bool> checkUser(Database db, String login, String password) async {  
    List<Map<String, Object?>> userMap = 
      await db.rawQuery('SELECT * FROM USER WHERE userLogin = ? AND userPassword = ?', [login, password]);
    if (userMap.length > 0) {
      return true;
    }
    else {
      return false;
    }  
  }

  // Premières insertions pour initialiser la base
  Future initDatas(Database db) async {
   
    //Insertion des premiers utilisateurs
    User user1 = new User(userLogin: "Franck", userEmail: "franck.garcia@cfa-afti.fr", userPassword: "password1", userCreationDate: "24/06/2021");

    this.insertUser(db, user1);

    User user2 = new User(userLogin: "Pierre", userEmail: "pierre.garcia@cfa-afti.fr", userPassword: "password2", userCreationDate: "24/06/2021");

    this.insertUser(db, user2);


    //Insertion de plantes
    Plant plant1 = new Plant(plantName: "Basilic", plantOrigin: "Asie du Sud-Est", plantPrice: 7.99, plantDescription: "Cultivé depuis plusieurs milliers d'années, le persil est l’une des herbes aromatiques culinaires les plus populaires, et est cultivé sur les 5 continents. Il se récolte de mai à octobre dans l’hémisphère nord.C’est une plante bisannuelle de 25 à 80 cm de haut qui a un parfum caractéristique et très aromatique une fois écrasé.Le persil est une plante à la fois condimentaire et médicinale.", plantPhotoPath: "plant_basilic.png", plantCreationDate: "23/06/2021");

    this.insertPlant(db, plant1);

    Plant plant2 = new Plant(plantName: "Curcuma", plantOrigin: "Asie du Sud", plantPrice: 15.99, plantDescription: "Le curcuma est utilisé autant comme épice que comme colorant dans les préparations alimentaires. Il est d’ailleurs l’un des principaux constituants du cari (curry), un mélange d’épices particulièrement employé en cuisine indienne.", plantPhotoPath: "plant_curcuma.png", plantCreationDate: "23/06/2021");

    this.insertPlant(db, plant2);

    Plant plant3 = new Plant(plantName: "Persil", plantOrigin: "Europe", plantPrice: 4.70, plantDescription: "D'origine méditerranéenne, le persil fait sans aucun doute partie des herbes aromatiques les plus consommées en France. En cuisine, le persil permet de relever les saveurs d’une multitude de plats grâce à son goût qui se prête à toutes les associations.", plantPhotoPath: "plant_persil.png", plantCreationDate: "23/06/2021");

    this.insertPlant(db, plant3);

    Plant plant4 = new Plant(plantName: "Thym", plantOrigin: "Europe", plantPrice: 6.70, plantDescription: "Très aromatique, le thym est utilisé dans de nombreuses recettes pour parfumer un plat de viande et de légumes. Il est plus traditionnellement utilisé pour le traitement de troubles respiratoires comme la toux, sous forme d'infusions ou d'huile essentielle.", plantPhotoPath: "plant_thym.png", plantCreationDate: "25/06/2021");

    this.insertPlant(db, plant4);

  }
 
}

