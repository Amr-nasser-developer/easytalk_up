import 'package:flutter/material.dart';

class AppNavigator{
 static  void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );

 static void navigateOff(context, widget) => Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );

static  void navigateOfAll(context, widget) => Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );

 static void navigateToName(context, route, {arguments}) =>
      Navigator.pushNamed(context, route, arguments: arguments);

 static void navigateOffName(context, route, {arguments}) =>
      Navigator.pushReplacementNamed(context, route, arguments: arguments);

 static  navigateAllNameOf(context, route, {arguments}) =>
      Navigator.pushNamedAndRemoveUntil(context, route, (route) => false,
          arguments: arguments);

}