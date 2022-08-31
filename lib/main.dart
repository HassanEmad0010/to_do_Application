import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_application/Cubit/AppCubit.dart';
import 'package:to_do_application/modules/NewTaskScreen.dart';
import 'package:to_do_application/shared/BlocObserver.dart';

import 'layouts/HomeScreen.dart';

void main() {
 // Bloc.observer = MyBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext contextCreate) => AppCubit(),
      child: MaterialApp(
        //darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
