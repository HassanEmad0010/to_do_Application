import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_application/shared/componant/DataBaseClass.dart';

class DraftTaskScreen extends StatelessWidget {

  SqlDb dbObject =SqlDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(

          children:[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.lightBlue,
                      child: IconButton(
                        iconSize: 70,
                        icon: Icon(Icons.visibility),
                        onPressed: () async {
                          print("view pressed");
                          String sqlCommand = "SELECT * FROM 'TASKS'";
                          var responce =
                          await dbObject.readData(sqlCommand: sqlCommand);
                          print("$responce");
                        },
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.deepPurple,
                      child: IconButton(
                        iconSize: 70,
                        icon: Icon(Icons.visibility),
                        onPressed: () async {
                          print("view pressed");
                          String sqlCommand = "SELECT * FROM 'DoneTASKS'";
                          var responce =
                          await dbObject.readData(sqlCommand: sqlCommand);
                          print("$responce");
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.lightBlue,
                  child: IconButton(
                    iconSize: 70,
                    icon: Icon(Icons.remove_circle),
                    onPressed: () async {
                      print("delete pressed");
                      String sqlCommand ="Delete FROM 'TASKS'";
                      //   var responce =
                      //await dbObject.DeleteData(sqlCommand: sqlCommand);

                      //  print(responce);
                    },
                  ),
                ),

                Container(
                  width: 100,
                  height: 100,
                  color: Colors.lightBlue,
                  child: IconButton(
                    iconSize: 70,
                    icon: Icon(Icons.delete),
                    onPressed: ()  {

                      dbObject.DeleteDataBase();

                    },
                  ),
                ),
              ],
            ),















            Text(
              "Done Tasks",
              style: TextStyle(fontSize: 60),
            ),
          ]
      ),
    );
  }
}
