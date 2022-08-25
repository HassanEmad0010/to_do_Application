import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoneTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Done Tasks",
          style: TextStyle(fontSize: 60),
        ),
      ),
    );
  }
}
