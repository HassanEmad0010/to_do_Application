
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_application/modules/DoneTaskScreen.dart';
import 'package:to_do_application/modules/DraftTaskScreen.dart';

import '../modules/NewTaskScreen.dart';
import '../shared/componant/componant.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  var scafofoldKey = GlobalKey<ScaffoldState>();
  bool isFloatingPressed = false;
  IconData floatingIcon = Icons.add;
  var titleController=TextEditingController();
  var timeController=TextEditingController();
  var testController=TextEditingController();
  var textFormKey=GlobalKey<FormState>();

  List<Widget> Screens = [
    NewTaskScreen(),
    DoneTaskScreen(),
    DraftTaskScreen(),
  ];

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafofoldKey,
      appBar: AppBar(
        title: const Text("To do App"),
        leading: Icon(Icons.menu),
        actions: const [
          Icon(Icons.menu),
          Icon(Icons.menu),
          Text("test"),
        ],
      ),
      body: Screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});

          if (isFloatingPressed) {
            Navigator.of(context).pop();
            isFloatingPressed = false;
            print("floating $isFloatingPressed");
            setState(() {
              floatingIcon = Icons.edit;




            });



          } else {


            setState(() {
              floatingIcon = Icons.add;
            });
            scafofoldKey.currentState?.showBottomSheet((context) {
              isFloatingPressed = true;
              print("floating $isFloatingPressed");
              return
                  Container(
                    padding: EdgeInsets.all(19),
                    color: Colors.grey[100],
                    child: Form(
                      key: textFormKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:  [
                          TextFormField(
                            onTap: (){
                              print("tet tabbed");

                            },

                            validator: (value){
                              if (value ==null) {
                                print("validator no null allowed $value");
                              } else{return null;}

                            },
                            onChanged: (value){
                              print("on changed $value");

                            },

                            decoration: const InputDecoration(

                              border: OutlineInputBorder(gapPadding: 20),
                              labelText: "test data",
                              fillColor: Colors.black,
                              //floatingLabelAlignment: FloatingLabelAlignment.center,
                            ),

                            controller: testController,


                          ),



                          textFormField(
                            textEditingController: titleController,
                            onTabFunction: (){
                              titleController.text="test data";
                              print("data tabbed");
                            },
                             validator: (String? value){},
                            iconPrefix: Icons.text_snippet,

                          ),
                          SizedBox(height: 15,),
                          textFormField(
                            onTabFunction: () {
                             showTimePicker(context: context, initialTime:TimeOfDay.now()).
                            then((value) {
                              if(value!=null) {
                                timeController.text =
                                    value.format(context).toString();
                                print("value is $value");
                              }
                              else{return null;}
                              setState(() {

                              });

                                });







                            },

                            formFieldText: "Time",
                            iconPrefix: Icons.date_range_outlined,
                            textEditingController: timeController,
                            validator: (String? value){ },


                          ),


                      ],
                      ),
                    ),
                  );

            });
          }
        },
        child: Icon(floatingIcon),
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
}
