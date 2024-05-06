import 'package:engneers_app/data/model/user_model.dart';
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
  Future<UserModel>? getUsers(String? password, String phone_number) async {
    print(password);

    List<Map<String, dynamic>>? map;
    if (password != null) {
      map = await _db!.query(
        "Users",
        where: 'phone_number = ? AND password = ?',
        whereArgs: [phone_number, password],
      );
      if (map.length < 1) {
        return UserModel(
            full_name: "0", phone_number: "phone_number", password: "password");
      }
    } else {
      map = await _db!.query(
        "Users",
        where: 'phone_number = ?',
        whereArgs: [phone_number],
      );
      if (map.length < 1) {
        return UserModel(
            full_name: "0", phone_number: "phone_number", password: "password");
      }
    }
    return UserModel.fromMap(map!.first);
  }

  Future<int> insertUser(UserModel user) async {
    var check_if_exists = await _db!.query("users",
        where: "phone_number = ?", whereArgs: [user.phone_number]);
    if (check_if_exists.length < 1) {
      int inserted_user = await _db!.insert('users', user.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return inserted_user;
    }
    return 0;
  }

  Future<void> updateUser(UserModel user) async {
    await _db!.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
    print("${user} ");
  }

  Future<void> deleteUser(int? id) async {
    await _db!.delete('Users', where: 'id = ?', whereArgs: [id]);
  }
}
