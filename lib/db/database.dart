import 'dart:io';

import 'package:flutter_application_1/model/list_tile_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ContactDataBaseProvider {
  Future<Database> init() async {
    Directory directory =
        await getApplicationDocumentsDirectory(); //returns a directory which stores permanent files
    final path = join(directory.path, "contact.db"); //create path to database

    return await openDatabase(
        //open the database or create a database if there isn't any
        path,
        version: 1, onCreate: (Database db, int version) async {
      await db.execute("""
          CREATE TABLE contact(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          content TEXT)""");
    });
  }

  Future<int> addItem(ListTileModel item) async {
    //returns number of items inserted as an integer

    final db = await init(); //open database

    return db.insert(
      "contact", item.toMap(), //toMap() function from MemoModel
      conflictAlgorithm:
          ConflictAlgorithm.ignore, //ignores conflicts due to duplicate entries
    );
  }

  Future<List<ListTileModel>> fetchMemos() async {
    //returns the memos as a list (array)

    final db = await init();
    final maps = await db
        .query("contact"); //query all the rows in a table as an array of maps

    return List.generate(maps.length, (i) {
      //create a list of memos
      return ListTileModel(
        id: maps[i]['id'] as int,
        title: maps[i]['title'] as String,
        phone: maps[i]['content'] as String,
      );
    });
  }

  Future<int> deleteMemo(int id) async {
    //returns number of items deleted
    final db = await init();

    int result = await db.delete("contact", //table name
        where: "id = ?",
        whereArgs: [id] // use whereArgs to avoid SQL injection
        );

    return result;
  }

  Future<int> updateMemo(int id, ListTileModel item) async {
    // returns the number of rows updated

    final db = await init();

    int result = await db
        .update("contact", item.toMap(), where: "id = ?", whereArgs: [id]);
    return result;
  }
}
