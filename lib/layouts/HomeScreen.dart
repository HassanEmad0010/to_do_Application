import 'dart:developer';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_application/Cubit/AppCubit.dart';
import 'package:to_do_application/Cubit/AppState.dart';
import 'package:to_do_application/modules/DoneTaskScreen.dart';
import 'package:to_do_application/modules/DraftTaskScreen.dart';
import 'package:to_do_application/shared/componant/DataBaseClass.dart';
import 'package:intl/intl.dart';

import '../modules/NewTaskScreen.dart';
import '../shared/componant/componant.dart';

class HomeScreen extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  // late Future<List<Map<String, Object?>>> homeTasks;

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var textFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          if (state is ChangingState) {
            print("changing state");
          }
        },
        builder: (context, state) {
          //this object to make acsess easy
          AppCubit cubitObject = AppCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: const Text("To do App"),
              leading: const Icon(Icons.task_alt),
              iconTheme: IconThemeData(
                size: 35,
              ),
              actions: [
                /*IconButton(
                  onPressed: () async {
                    print("delete pressed");
                    await myDb.DeleteTableData(
                      tableName: 'TASKS',
                    );
                    await myDb.DeleteTableData(
                      tableName: 'DONETASKS',
                    );
                    await myDb.DeleteTableData(
                      tableName: 'DraftTASKS',
                    );

                  },
                  icon: Icon(Icons.menu)),*/
              ],
            ),
            body: ConditionalBuilder(
              builder: (context) =>
                  cubitObject.Screens[cubitObject.currentIndex],
              condition: cubitObject.notLoading,
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                if (cubitObject.isFloatingPressed &&
                    (textFormKey.currentState!.validate())) {
                  //cubitObject.isFloatingPressed = false;
                  //cubitObject.floatingIcon = Icons.edit;
                  cubitObject.floatingButton(iConData:Icons.edit ,notPressed: false);

                  //'INSERT INTO TASKS(TITLE,DATE,TIME,STATUS) VALUES("$task", "pray", "25-8-2022","$status")'

                  cubitObject
                      .insertNewTask(
                    title: titleController.text,
                    date: dateController.text,
                    time: timeController.text,
                  )
                      .then((value) {
                    Navigator.of(context).pop();

                    print("floating $cubitObject.isFloatingPressed");

                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Note Added')));
                  });

                  titleController.text = "";
                  timeController.text = "";
                  dateController.text = "";
                } else {
                  //cubitObject.floatingIcon = Icons.add;
                 // cubitObject.isFloatingPressed = true;
                  cubitObject.floatingButton(iConData:Icons.add ,notPressed: true);
                  scaffoldKey.currentState
                      ?.showBottomSheet(
                          backgroundColor: Colors.black54,
                          elevation: 15, (context) {

                        print("floating $cubitObject.isFloatingPressed");
                        return Container(
                          padding: const EdgeInsets.all(19),
                          color: Colors.white,
                          child: Form(
                            key: textFormKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                textFormField(
                                  formFieldText: "Task Title",
                                  textEditingController: titleController,
                                  onTabFunction: () {
                                    print("title tabbed");
                                  },
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "title Cant be empty";
                                    }
                                    return null;
                                  },
                                  iconPrefix: Icons.text_snippet,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                textFormField(
                                  textInputType: TextInputType.none,
                                  onTabFunction: () {
                                    showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                        .then((value) {
                                      if (value != null) {
                                        timeController.text =
                                            value.format(context).toString();
                                        print("value is $value");
                                      } else {
                                        return null;
                                      }
                                    });
                                  },
                                  formFieldText: "Time",
                                  iconPrefix: Icons.timer_outlined,
                                  textEditingController: timeController,
                                  validator: (String? value) {},
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                textFormField(
                                  textInputType: TextInputType.none,
                                  textEditingController: dateController,
                                  formFieldText: "Date",
                                  iconPrefix: Icons.date_range_outlined,
                                  validator: (String? value) {},
                                  onTabFunction: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.utc(2023, 08, 30),
                                    ).then((value) {
                                      if (value != null) {
                                        var dat =
                                            DateFormat.yMMMd().format(value);
                                        dateController.text = dat.toString();
                                        print("Date is $dat");
                                      }
                                    });
                                  },
                                ),

                                ElevatedButton(
                                  onPressed: () {
                                    titleController.text = "";
                                    timeController.text = "";
                                    dateController.text = "";

                                    // isFloatingPressed = false;
                                    // floatingIcon=Icons.edit;

                                    // print(isFloatingPressed);
                                  },
                                  child: const Text('clear data'),
                                ),
                                // ElevatedButton(
                                //   onPressed: () {
                                //     setState(() {
                                //
                                //     //  print(homeTasks.toString());
                                //
                                //     });
                                //
                                //   },
                                //   child: const Text('test'),
                                // ),
                              ],
                            ),
                          ),
                        );
                      })
                      .closed
                      .then((value) {
                        cubitObject.floatingButton(iConData:Icons.edit , notPressed: false);
                        //cubitObject.isFloatingPressed = false;
                        //cubitObject.floatingIcon = Icons.edit;
                      });
                }
              },
              child: Icon(cubitObject.floatingIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              iconSize: 30,
              selectedLabelStyle: const TextStyle(fontSize: 22),
              selectedIconTheme: const IconThemeData(size: 30),
              backgroundColor: Colors.blue,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.black,
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                cubitObject.setCurrentIndex(currIndex: value);
                //  BlocProvider.of<AppCubit>(context).setCurrentIndex(currIndex: value);
              },
              currentIndex: cubitObject.currentIndex,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.library_add), label: "New"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.done_outline_sharp), label: "Done"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.drafts), label: "Draft"),
              ],
            ),
          );
        },
      ),
    );
  }
}
