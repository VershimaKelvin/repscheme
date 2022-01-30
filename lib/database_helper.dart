import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{


  DatabaseHelper._privateConstructor();
  static DatabaseHelper instance =  DatabaseHelper._privateConstructor();

  static const _tableName = 'myTable';
  static const int _dbVersion = 1;
  static const _dataBaseName ='myDatabase.db';
  static const _columnID = 'ID';
  static const _columnRepScheme = 'RepScheme';
  static const _columnWeight = 'weight';


  Database? _database;

  Future<Database>  get database async{
    if(_database!=null){
      return _database!;
    }else{
      return await initializeDatabase();
    }

  }

  initializeDatabase()async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,_dataBaseName);
    return await openDatabase(path,version: _dbVersion,onCreate: onCreate);
  }

  onCreate(Database db,int version)async{
    db.execute(
        '''
        CREATE TABLE $_tableName(
        $_columnID INTEGER PRIMARY KEY,
        $_columnRepScheme TEXT NOT NULL,
        $_columnWeight INTEGER NOT NULL
        )    
        ''');
  }


  Future<int> insert(Map<String,dynamic> row)async{
    Database db =await instance.database;
    return await db.insert(_tableName, row);
  }

  Future<List<Map<String,dynamic>>> querry()async{
    Database db =await instance.database;
    return await db.query(_tableName);

  }

}