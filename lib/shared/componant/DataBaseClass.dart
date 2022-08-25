import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class SqlDb {

  static Database? _db;
  Future<Database?> get db async
  {
    if(_db==null) {
     _db=await initialDatabase();
     return _db;
  }else {return _db;}

}



   initialDatabase() async
   {
   String databaseName = 'LocalDataBase';
     String path= await getDatabasesPath();
   String databasePath=join(path,databaseName);

   var mydb= await openDatabase(databasePath,
     version: 1,
   onCreate: _oncreateMethode,
   );
   print("DB created");

   return mydb;
   }

 _oncreateMethode(Database db, int version) async
 {
   //TITLE,DATA,TIME,STATUS
  await db.execute("CREATE TABLE TASKS (id INTEGER PRIMARY KEY, TITLE TEXT, DATE TEXT, TIME STRING, STATUS STRING)");
  print("table created successfully");
 }

  Future<List<Map<String, Object?>>> readData ({required String sqlCommand}) async{
    print("trying to read data");
    Database? myDb=await db;
  Future<List<Map<String, Object?>>> responce = myDb!.rawQuery(sqlCommand);
    return responce;
  }

  Future<List<Map<String, Object?>>> insertData ({required String sqlCommand}) async
  {
    print("trying to insert data");

    Database? mydb = await db;
    var responce = await mydb!.rawQuery(sqlCommand);
    return responce;
  }

 Future<int> DeleteData ({required String sqlCommand})
  async{
    print("trying to Delete data");

    Database? mydb=await db;
  int responce = await mydb!.rawDelete(sqlCommand);
    return responce;

  }








}