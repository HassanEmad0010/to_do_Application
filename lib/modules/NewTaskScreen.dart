import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_application/models/DataModel.dart';
import 'package:to_do_application/shared/componant/DataBaseClass.dart';

import '../shared/componant/componant.dart';

//sws
class NewTaskScreen extends StatefulWidget {
  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  SqlDb dbObject = new SqlDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
        Container(
          //width: double.infinity,
        //height:  200,
        child:
           ListView(
             scrollDirection: Axis.vertical,

         children: [
           FutureBuilder(
             future: dbObject.readData(sqlCommand: "SELECT * FROM 'TASKS'"),
             builder: (context,AsyncSnapshot<List<Map>> snapshot) {
               if(snapshot.hasData) {
                 return ListView.builder(
                  // scrollDirection: Axis.vertical,

                 physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                     itemCount: snapshot.data!.length,
                     itemBuilder:
                         (context, index) {

                       return cardBuilder(
                           snapTitle: snapshot.data![index]['TITLE']);
                     }

                 );
               }else
                 {
                   return const Center(child:  CircularProgressIndicator(color: Colors.red),);
                 }
             },

             ),
         ],
           ),

           ),

    );
  }
}
