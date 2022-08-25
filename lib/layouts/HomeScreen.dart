import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_application/modules/DoneTaskScreen.dart';
import 'package:to_do_application/modules/DraftTaskScreen.dart';

import '../modules/NewTaskScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
   Database? database;


  List<Widget> Screens = [
    NewTaskScreen(),
    DoneTaskScreen(),
    DraftTaskScreen(),
  ];

  @override
  initState(){
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("To do App"),
        leading: Icon(Icons.menu),
        actions: [
          Icon(Icons.menu),
          Icon(Icons.menu),
          Text("test"),
        ],
      ),
      body: Screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        selectedLabelStyle: const TextStyle(fontSize: 22),
        selectedIconTheme: const IconThemeData(size: 40),
        backgroundColor: Colors.lightBlue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {});

          currentIndex = value;
          print(currentIndex);
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.library_add), label: "New"),
          BottomNavigationBarItem(
              icon: Icon(Icons.done_outline_sharp), label: "Done"),
          BottomNavigationBarItem(icon: Icon(Icons.drafts), label: "Draft"),
        ],
      ),
    );
  }



  void createDatabase () async
  {
    print("trying to create database and table...");
    var database =await openDatabase (

        'todo1.db',
      version: 1,

      onCreate: (database1,version) async{
        print("trying to create table...");
       await database1.execute('CREATE TABLE Test3 (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
        print ("data base $database1 is created successfully with version = $version");

      },
      onOpen:(database) async{
        print("data base $database is openned");
      }


    );


  }


  void createDataBaseThen()  {
    print("trying to create database...");
  var database =openDatabase(
      "TODO_DataBase2",
    version: 1,
    onCreate: (database,version){
        print("trying to create Table...");
        database.execute("CREATE TABLE TASKS2 (id INTEGER PRIMARY KEY, TITLE TEXT, DATE TEXT, TIME STRING, STATUS STRING)")
            .then((value) =>
        {
        print("Table created "),


        }).catchError((e){print("Error in creating table is "+e.toString());});
    },
    onOpen: (database1) async{
      print("data base $database1 is openned");
    },


  ).then((value) =>
  {
    print("database created"),

  }).catchError((e){print("Error in creating database is "+e.toString());});
  }


}










