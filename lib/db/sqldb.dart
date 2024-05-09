
import 'package:engineer_app/data/model/unit_model.dart';
import 'package:engineer_app/data/model/user_model.dart';
import 'package:sqflite/sqflite.dart';
import "package:path/path.dart";

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String data_base_path = await getDatabasesPath();
    String path = join(data_base_path, 'nile.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);

    return mydb;
  }

  _onUpgrade(Database db, int versionm, int new_version) {
    print("onUpgrade =============================");
  }

  _onCreate(Database db, int version) async {
    print("enter ==============");
    await db.execute("""
    CREATE TABLE "USERS"(
       "ID" INTEGER   NOT NULL PRIMARY KEY AUTOINCREMENT,
       "FULL_NAME" TEXT NOT NULL,
       "PHONE_NUMBER" TEXT NOT NULL,
       "PASSWORD" TEXT NOT NULL
    )""");
    await db.execute("""
    CREATE TABLE "UNITS"(
      "ID" INTEGER   NOT NULL PRIMARY KEY AUTOINCREMENT,
      "CUSTOMER_NAME" TEXT NOT NULL,
      "ENG_NAME" TEXT NOT NULL,
      "LOCATION_ADDRESS" TEXT NOT NULL,
      "LOCATION_DESCRIPTION" TEXT NOT NULL,
      "UID" INTEGER  NOT NULL ,

    foreign key (uid) references users (ID) 
    ON DELETE NO ACTION ON UPDATE NO ACTION
    ) """);
    await db.execute("""
     CREATE TABLE "ITEMS"(
      "ID" INTEGER   NOT NULL PRIMARY KEY AUTOINCREMENT,
      "HEIGHT" INTEGER NOT NULL,
      "WIDTH" INTEGER NOT NULL,
      "AREA" INTEGER NOT NULL,
      "CATEGORY" INTEGER NOT NULL,
      "UNIT_ID" INTEGER  NOT NULL ,
      "IMAGES" TEXT  NOT NULL,
    foreign key (UNIT_ID) references UNITS (ID) 
    ON DELETE NO ACTION ON UPDATE NO ACTION
    
)""");
    print("database oncreated ===========================");
  }

// to check if user exist or not
}

class GetData extends SqlDb {
  Future<List<UnitModel>> getAllUnits({required int UID}) async {
    List<UnitModel> unit_models = [];
    List<Map<String, dynamic>>? maps;
    await SqlDb().db;
    print(UID);
    maps = await SqlDb._db!.query("Units", where: 'UID = ?', whereArgs: [UID]);
    print(maps);
    // to convert the map of Units to List of UitModel
    for (var i in maps) {
      unit_models.add(UnitModel.fromMap(i));
    }
    print(unit_models);
    return unit_models;
  }

  Future<UnitModel>? getUnit({required int id, required int UID}) async {
    List<Map<String, dynamic>>? map;
    await SqlDb().db;
    map = await SqlDb._db!
        .query("Units", where: 'UID = ?, ID = ?', whereArgs: [UID, id]);
    if (map.length < 1) {
      return UnitModel(
          customer_name: "1",
          eng_name: "eng_name",
          location_address: "location_address",
          location_description: "location_description",
          UID: 0);
    }
    return UnitModel.fromMap(map.first);
  }

  ////
  // get user  : get the user or return dumy user or check if user exists
  // @password : nullable
  // @phone_number :
  ////
  Future<UserModel>? getUsers(String? password, String phone_number) async {
    List<Map<String, dynamic>>? map;
    await SqlDb().db;

    // to check if i'm gonna reset password or login
    if (password != null) {
      map = await SqlDb._db!.query(
        "Users",
        where: 'phone_number = ? AND password = ?',
        whereArgs: [phone_number, password],
      );
      // if the  map  len is smaller than one so we cannot find the
      if (map.length < 1) {
        return UserModel(
            full_name: "0", phone_number: "phone_number", password: "password");
      }
    } else {
      map = await SqlDb._db!.query(
        "Users",
        where: 'phone_number = ?',
        whereArgs: [phone_number],
      );
      // if the  map  len is smaller than one so we cannot find the

      if (map.length < 1) {
        return UserModel(
            full_name: "0", phone_number: "phone_number", password: "password");
      }
    }
    // here we get the map of one user
    return UserModel.fromMap(map.first);
  }
}

class UpdataData extends SqlDb {
  updateUnit(UnitModel unit) async {
    await SqlDb().db;
    print("deeeeeeeeeeeeeeeeeeeeeeeeeeee");
    try {
      var i = await SqlDb._db!.rawUpdate(
          'UPDATE Units SET  CUSTOMER_NAME = ?,ENG_NAME = ?, LOCATION_ADDRESS = ?, LOCATION_DESCRIPTION = ?   WHERE ID = ?',
          [
            unit.customer_name,
            unit.eng_name,
            unit.location_address,
            unit.location_description,
            unit.ID
          ]);
      print("$i 0000000000000");
    } catch (e) {
      print(e.toString());
    }
  }

  Future<int> updateUser(UserModel user) async {
    await SqlDb().db;

    return await SqlDb._db!.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }
}

class InsertData extends SqlDb {
  Future<int> insertUser(UserModel user) async {
    await SqlDb().db;

    var check_if_exists = await SqlDb._db!.query("users",
        where: "phone_number = ?", whereArgs: [user.phone_number]);
    if (check_if_exists.length < 1) {
      int inserted_user = await SqlDb._db!.insert('users', user.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return inserted_user;
    }
    return 0;
  }

  Future<int> insertUnit(UnitModel unit) async {
    await SqlDb().db;

    int inserted_user = await SqlDb._db!.insert('units', unit.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print(inserted_user);
    return inserted_user;
  }
}

class DeleteData extends SqlDb {
  Future<void> deleteUser(int? id) async {
    await SqlDb().db;

    await SqlDb._db!.delete('Users', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteUnit(int? id) async {
    await SqlDb().db;

    await SqlDb._db!.delete('Units', where: 'id = ?', whereArgs: [id]);
  }
}
