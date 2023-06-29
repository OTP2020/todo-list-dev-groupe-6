import 'package:todo_list/repositories/database_connexion.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/cupertino.dart';

class Repository{



  late DatabaseConnexion _databaseConnexion;



  Repository() {

    _databaseConnexion = DatabaseConnexion();





  }

//convert code

  //static Database _database;

  static Database? _database;



  /* Future<Database> get _database async{

    if(_database !=Null)return _database;

    _database =await _databaseConnection.setDatabase();

    return _database;

  }*/



  Future <Database> get database async{

    return _database ??= await _databaseConnexion.setDatabase();

  }



  insertData(table,data)async{

    var connection=await database;

    return await connection.insert(table,data);

  }

  // Read data from table
  readData(table) async{
    var connection = await database;
    return await connection.query(table);
  }

  readDataById(table, itemId) async{
    var connection = await database;
    return await connection.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  // Update data from table
  updateData(table, data) async{
    var connection = await database;
    return await connection.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  // Delete data from table
  deleteData(table, itemId) async{
    var connection = await database;
    return await connection.rawDelete("DELETE FROM $table WHERE id = $itemId");
  }

  //Read data from table by Column Name
  readDataByColumnName(table, columnName, columnValue) async{
    var connection = await database;
    return await connection
        .query(table, where: '$columnName=?x', whereArgs: [columnValue]);
  }

}