
import'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

displaySnackBar(BuildContext context,text) {
  final snackBar = SnackBar(content: Text(text));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}