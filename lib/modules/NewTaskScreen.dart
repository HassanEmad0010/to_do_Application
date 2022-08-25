import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//sws
class NewTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Text(
          "New Tasks",
          style: TextStyle(fontSize: 60),
        ),
      ),
    );
  }
}
