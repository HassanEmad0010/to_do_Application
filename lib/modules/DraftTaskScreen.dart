import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DraftTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Draft Tasks",
          style: TextStyle(fontSize: 60),
        ),
      ),
    );
  }
}
