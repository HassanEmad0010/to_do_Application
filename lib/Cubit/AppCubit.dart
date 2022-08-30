
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modules/DoneTaskScreen.dart';
import '../modules/DraftTaskScreen.dart';
import '../modules/NewTaskScreen.dart';
import 'AppState.dart';

class AppCubit extends Cubit<AppState>{
  AppCubit(): super(InitialState());
  int currentIndex = 0;
  bool notLoading=true;
  List<Widget> Screens = [
    NewTaskScreen(),
    DoneTaskScreen(),
    DraftTaskScreen(),
  ];

  bool isFloatingPressed = false;
  IconData floatingIcon = Icons.edit;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var textFormKey = GlobalKey<FormState>();



  static AppCubit get(context)=>BlocProvider.of(context);


  void setCurrentIndex ({required int currIndex})
  {
    notLoading=false;
    currentIndex=currIndex;
    emit(ChangingState());
    notLoading=true;

  }







}
