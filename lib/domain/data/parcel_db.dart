import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class ParcelDB {
  // ParcelDB._();
  // static final ParcelDB db = ParcelDB._();
  //
  // static Database _database;
  //
  // // Get a location using getDatabasesPath
  //
  //
  // String table = 'parcel';
  //
  // static const columnId = 'id';
  // static const double weight;
  // double length;
  // double width;
  // double height;
  // double? volume;
  // double price;
  // double? senderLat;
  // double? senderLng;
  // double? senderDistance;
  // double? receiverLat;
  // double? receiverLng;
  // double? receiverDistance;
  // List<int>? logistic;
  //
  // Future<Database> get database async {
  //   if(_database != null) return _database;
  //
  //   _database = await _initDB();
  //   return _database;
  // }
  //
  // Future<Database> _initDB() async {
  //   Directory dir = await getApplicationDocumentsDirectory();
  //   String path = dir.path + 'User.db';
  //   return await openDatabase(path, version: 2, onCreate: _createDB);
  // }
  // void _createDB(Database db, int version) async {
  //   // await db.execute(
  //   //   'CREATE TABLE $userTable($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnName TEXT)',
  //   // );
  //   await db.execute('''
  //         CREATE TABLE $ParcelTable (
  //           $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
  //           $columnUserId INTEGER NOT NULL,
  //           $columnRef TEXT NOT NULL,
  //           $columnDate INTEGER,
  //           $columnTimeStart INTEGER,
  //           $columnTimeEnd INTEGER,
  //           $columnStatus INTEGER
  //         )
  //         ''');
  // }
  //
  // // READ
  // Future<List<User>> getUser() async {
  //   Database db = await this.database;
  //   final List<Map<String, dynamic>> userMapList = await db.query(userTable);
  //   final List<User> userList = [];
  //   userMapList.forEach((userMap) {
  //     userList.add(User.fromMap(userMap));
  //   });
  //   return userList;
  // }
  //
  // // INSERT
  // Future<User> insertUser(User user) async {
  //   Database db = await this.database;
  //   user.id = await db.insert(userTable, user.toMapI());
  //   return user;
  // }
  //
  // // UPDATE
  // Future<int> updateUser(User user) async {
  //   Database db = await this.database;
  //   return await db.update(
  //     userTable,
  //     user.toMap(),
  //     where: '$columnId = ?',
  //     whereArgs: [user.id],
  //   );
  // }
  //
  // // DELETE
  // Future<int> deleteUser(int id) async {
  //   Future <Database?> db = await this.database;
  //   return await db.delete(
  //     userTable,
  //     where: '$columnId = ?',
  //     whereArgs: [id],
  //   );
  // }
}

