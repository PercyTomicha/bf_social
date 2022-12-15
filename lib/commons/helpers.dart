import 'package:flutter/material.dart';

class Helpers {
  static String baseURL = 'https://jsonplaceholder.typicode.com';
  static int connectTimeout = 5000;
  static int receiveTimeout = 3000;

  static TextStyle styleTitle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14
  );

  static TextStyle styleSubTitle = const TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    fontSize: 10
  );
  static BoxDecoration decorationCard = BoxDecoration(
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(20),
    color: Colors.white
  );

  static InputDecoration inputDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5)
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5)
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5)
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5)
    )
  );
}

class Routes {
  static String post = 'post';
  static String posts = 'posts';
  static String crearPostURL = 'create-post';
  static String comments = 'comments';
  static String favorites = 'favorites';
}