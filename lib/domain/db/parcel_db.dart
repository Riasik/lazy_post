import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lazy_post/domain/entity/parcel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;

class ParcelDB {
  static Future<void> createTables(sql.Database database) async {
    await database.execute('''CREATE TABLE parcels(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, weight REAL,
        length REAL, width REAL, height REAL, volume REAL, price REAL,
        senderLat REAL, senderLng REAL, senderDistance REAL,
        receiverLat REAL, receiverLng REAL, receiverDistance REAL,
        logistic TEXT, 
        dateAdd TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        resultLogisticIds TEXT
      )
      ''');
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'parcel.db',
      version: 2,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createParcel(Parcel p) async {
    final db = await ParcelDB.db();
    final data = {
      'weight': p.weight,
      'length': p.length,
      'width': p.width,
      'height': p.height,
      'volume': p.volume,
      'price': p.price,
      'senderLat': p.senderLat,
      'senderLng': p.senderLng,
      'senderDistance': p.senderDistance,
      'receiverLat': p.receiverLat,
      'receiverLng': p.receiverLng,
      'receiverDistance': p.receiverDistance,
      'logistic': p.logistic?.join()
    };
    final id = await db.insert('parcels', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getParcels() async {
    final db = await ParcelDB.db();
    return db.query('parcels', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getParcel(int id) async {
    final db = await ParcelDB.db();
    return db.query('parcels', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateResult(int id, List<int> ids) async {
    final db = await ParcelDB.db();

    final data = {
      'resultLogisticIds': ids.join()
    };

    final result =
    await db.update('parcels', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<int> updateParcel(
      int id, Parcel p) async {
    final db = await ParcelDB.db();

    final data = {
      'weight': p.weight,
      'length': p.length,
      'width': p.width,
      'height': p.height,
      'volume': p.volume,
      'price': p.price,
      'senderLat': p.senderLat,
      'senderLng': p.senderLng,
      'senderDistance': p.senderDistance,
      'receiverLat': p.receiverLat,
      'receiverLng': p.receiverLng,
      'receiverDistance': p.receiverDistance,
      'logistic': p.logistic?.join(),
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('parcels', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteParcel(int id) async {
    final db = await ParcelDB.db();
    try {
      await db.delete("parcels", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
