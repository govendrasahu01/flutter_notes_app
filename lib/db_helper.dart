import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper{
  DBHelper._();

  static DBHelper getInstance()=> DBHelper._();
  
  static final  String tableName = "note";
  static final  String columnNoteId = "note_id";
  static final  String columnNoteTitle = "title";
  static final  String columnNoteDesc = "note_description";
  static final  String columnCreatedAt = "note_created_at";


  Database? db;

  Future <Database> initDB() async{
    if(db == null){
      db = await getOrCreateDB();
      return db!;
    }else{
      return db!;
    }
  }

  Future <Database> getOrCreateDB() async{
    Directory appRootDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appRootDir.path, "notes.db");
    return await openDatabase(dbPath, version: 1, onCreate: (db, version){
      db.execute(
        "create table $tableName ($columnNoteId integer primary key autoincrement, $columnNoteTitle text,  $columnNoteDesc text, $columnCreatedAt text)"
      );
    },);
  }

  // Add an object(row) in table

  Future <bool> addNote({required String title, required String description}) async{
    Database db = await initDB();

    int rowAffected = await db.insert(tableName, {
      columnNoteTitle: title,
      columnNoteDesc: description,
      columnCreatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
    });

    return rowAffected == 1;
  }

  // fetch all objects of the DB
  Future <List<Map<String, dynamic>>> getAllNotes() async{
    Database db = await initDB();
    List<Map<String, dynamic>> allNotes = await db.query(tableName);
    return allNotes;
  }

  // delete a object by id
  Future <bool> deleteNote({required int id}) async{
    Database db = await initDB();
    int rowAffected = await db.delete(
      tableName, 
      where: "$columnNoteId = ?",
      whereArgs: [id],
    );
    return rowAffected > 0;
  }

  // Upadate a Row
  Future <bool> updateNote({
    required int id, 
    required String title, 
    required String description
  }) async{
    Database db = await initDB();
    int rowAffected = await db.update(
      tableName, 
      {columnNoteTitle:title, columnNoteDesc:description},
      where: "$columnNoteId=?",
      whereArgs: [id]
    );
    return rowAffected >0;
  }

}