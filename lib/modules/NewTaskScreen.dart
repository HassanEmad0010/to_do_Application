import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_application/shared/componant/DataBaseClass.dart';
//sws
class NewTaskScreen extends StatelessWidget {

  SqlDb dbObject = new SqlDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          children: [
            const Text (
              "New Tasks",
              style: TextStyle(fontSize: 40),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [

                Container(
                  width: 100,
                  height: 100,
                  color: Colors.lightBlue,
                  child: IconButton(
                    iconSize: 70,
                    icon: Icon(Icons.add),
                    onPressed: () async{
                      print("+ pressed");

                      String task="Java";
                      String status="done";
                     var responce= await dbObject.insertData(sqlCommand: 'INSERT INTO TASKS(TITLE,DATE,TIME,STATUS) VALUES("$task", "pray", "25-8-2022","$status")');
                     print("Data inserted to the table ");
                      print(responce.toString());


                     },

                  ),
                ),

                const SizedBox(width: 10,),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.lightBlue,
                  child: IconButton(
                    iconSize: 70,
                    icon: Icon(Icons.visibility),
                    onPressed: () async{
                      print("view pressed");
                      String sqlCommand="SELECT * FROM 'TASKS'";
                      var responce = await dbObject.readData(sqlCommand: sqlCommand);
                      print("$responce");


                    },

                  ),
                ),
                const SizedBox(width: 10,),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.lightBlue,
                  child: IconButton(
                    iconSize: 70,
                    icon: Icon(Icons.remove_circle),
                    onPressed: () async{
                      print("delete pressed");
                      String sqlCommand="DELETE FROM 'TASKS' WHERE id IN (3,8,9,10)";
                      var responce=await dbObject.DeleteData(sqlCommand: sqlCommand);
                      print(responce);


                    },

                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
