import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_application/Cubit/AppCubit.dart';
import 'package:to_do_application/Cubit/AppState.dart';
import 'package:to_do_application/models/DataModel.dart';
import 'package:to_do_application/shared/componant/DataBaseClass.dart';

import '../layouts/HomeScreen.dart';
import '../shared/componant/componant.dart';

//sws

class NewTaskScreen extends StatelessWidget {
  SqlDb dbObject = new SqlDb();
  var newTaskScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubitObject = AppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.teal,
          key: newTaskScaffoldKey,
          body: Container(
            margin: EdgeInsets.all(24),
            //width: double.infinity,
            //height:  200,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                FutureBuilder(
                  future: cubitObject.readTasksData(tableName: 'TASKS'),

                  /*dbObject.readData(sqlCommand: "SELECT * FROM 'TASKS'"),*/
                  //cubitObject.readTasksData(tableName: 'TASKS'),
                  builder: (context, AsyncSnapshot<List<Map>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                          separatorBuilder: (context, value) => const SizedBox(
                                height: 10,
                              ),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return cardBuilder(
                                snapTitle: snapshot.data![index]['TITLE'],
                                snapDate: snapshot.data![index]['DATE'],
                                snapStatus: snapshot.data![index]['STATUS'],
                                snapTime: snapshot.data![index]['TIME'],
                                longPressFunction: () async {
                                  print("long pressed");
                                  print("snap" + snapshot.toString());

                                  await cubitObject
                                      .insertNewTask(
                                    tableName: 'DoneTASKS',
                                    title: snapshot.data![index]['TITLE'],
                                    time: snapshot.data![index]['TIME'],
                                    date: snapshot.data![index]['DATE'],
                                    status: "Done",
                                  )
                                      .then((value) {
                                    cubitObject.deleteData(
                                        rowData: snapshot.data![index]['TITLE'],
                                        tableName: "TASKS");
                                  });
                                });
                          });
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.red),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
