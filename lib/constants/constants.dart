import 'package:flutter/material.dart';

TextStyle normalstyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontFamily: 'janna',
  fontSize: 20
);

TextStyle titletext = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 25,
   fontFamily: 'unique light',
);
Widget showToast({BuildContext context , String message, Color color})
{
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: color,
  ));
}