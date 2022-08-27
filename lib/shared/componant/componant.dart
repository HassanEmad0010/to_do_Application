import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

Widget textFormField({
  required TextEditingController textEditingController,
  TextInputType textInputType = TextInputType.emailAddress,
  //bool isPassword = false,
  String formFieldText = "Your Data",
  required String? Function(String? value) validator,
  required Function() onTabFunction,
  Function()? suffixFunction,
  IconData? iconPrefix,
  IconData? iconSuffix,
  Color color = Colors.black54,
  double width = double.infinity,
  double height = 80,
}) =>
    Container(
      decoration: BoxDecoration(border: Border.all(color: color, width: 3)),
      width: width,
      height: height,
      child: TextFormField(
        onTap: onTabFunction,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          prefix: Icon(iconPrefix),
          suffix: IconButton(onPressed: suffixFunction, icon: Icon(iconSuffix)),
          labelText: formFieldText,
          fillColor: Colors.black,
          //floatingLabelAlignment: FloatingLabelAlignment.center,
        ),
        controller: textEditingController,
        keyboardType: textInputType,
        validator: validator,
      ),
    );
