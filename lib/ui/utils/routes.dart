import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static Future<T?> push<T extends Object?>(
      BuildContext context, Widget child) async {
    return await Navigator.push(
        context, MaterialPageRoute(builder: (_) => child));
  }

  static Future<T?> pushReplacement<T extends Object?>(
      BuildContext context, Widget child) async {
    return await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => child));
  }
}
