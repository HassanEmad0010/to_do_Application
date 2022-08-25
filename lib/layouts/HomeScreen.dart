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
  int currentindex = 0;
   Database? database;

  List<Widget> Screens = [
    NewTaskScreen(),
    DoneTaskScreen(),
    DraftTaskScreen(),
  ];

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
      body: Screens[currentindex],
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            var name = await getName();
            print(name);
          } catch (e) {
            print("Error is ${e.toString()}");
          };
        },
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

          currentindex = value;
          print(currentindex);
        },
        currentIndex: currentindex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.library_add), label: "New"),
          BottomNavigationBarItem(
              icon: Icon(Icons.done_outline_sharp), label: "Done"),
          BottomNavigationBarItem(icon: Icon(Icons.drafts), label: "Draft"),
        ],
      ),
    );
  }

  Future<String> getName() async {
    return "Hassan Emad";
  }

  void createDatabase () async
  {
    var database =await openDatabase (
      'todo.db',
      version: 1,
      onCreate: (database1,version){
        print ("data base $database1 is created successfully with version = $version");

      }


    );


  }






  }



