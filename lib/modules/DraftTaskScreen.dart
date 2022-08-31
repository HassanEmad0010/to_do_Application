import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_application/shared/componant/DataBaseClass.dart';

import '../Cubit/AppCubit.dart';
import '../Cubit/AppState.dart';
import '../shared/componant/componant.dart';

class DraftTaskScreen extends StatelessWidget {
  SqlDb dbObject = SqlDb();

  @override
  Widget build(BuildContext context) {
    AppCubit cubitObject = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        backgroundColor: Colors.teal,
        body: Container(
          margin: EdgeInsets.all(24),
          //width: double.infinity,
          //height:  200,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              FutureBuilder(
                future: cubitObject.readTasksData(tableName: "DraftTASKS"),
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
                                cubitObject.insertNewTask(
                                    title: snapshot.data![index]['TITLE'],
                                    tableName: 'TASKS',
                                    status: "idle",
                                    date: snapshot.data![index]['DATE'],
                                    time: snapshot.data![index]['TIME']);

                                cubitObject.deleteData(
                                    rowData: snapshot.data![index]['TITLE'],
                                    tableName: 'DraftTASKS');
                              });
                        });
                  } else {
                    return const Center(
                      widthFactor: 50,
                      heightFactor: 40,
                      child: CircularProgressIndicator(
                          color: Colors.red, value: 40),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DraftScreen {}
