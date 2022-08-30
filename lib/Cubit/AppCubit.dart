
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modules/DoneTaskScreen.dart';
import '../modules/DraftTaskScreen.dart';
import '../modules/NewTaskScreen.dart';
import '../shared/componant/DataBaseClass.dart';
import 'AppState.dart';

class AppCubit extends Cubit<AppState>{
  AppCubit(): super(InitialState());
  SqlDb myDb = new SqlDb();

  int currentIndex = 0;
  bool notLoading=true;
  List<Widget> Screens = [
    NewTaskScreen(),
    DoneTaskScreen(),
    DraftTaskScreen(),
  ];

  bool isFloatingPressed = false;
  IconData floatingIcon = Icons.edit;



  static AppCubit get(context)=>BlocProvider.of(context);


  void setCurrentIndex ({required int currIndex})
  {
    notLoading=false;
    currentIndex=currIndex;
    emit(ChangingState());
    notLoading=true;

  }
  Future<List<Map<String, Object?>>> insertNewTask(
  {
    required String title,
    required String date,
    required String time,
}

      ) async {

     var responce = await myDb.insertData(
      tableName: "TASKS",
      title:title,
      date:date,
      status: "idle",
      time:time,
    );
     emit(InsertDatabaseState());
     return responce;

  }

  void floatingButton ({required IconData iConData,required bool notPressed })
  {


        isFloatingPressed=notPressed;
        floatingIcon=iConData;
        emit(FloatingButtonState());


  }








}
