import 'package:flutter/material.dart';

class AppWidget{
  static TextStyle introHeading({
  Color textColor= Colors.black,
}){
    return TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: textColor,
    );
  }
  static TextStyle greeting({
    Color greet = Colors.grey
  }){
    return TextStyle(
      fontSize: 20,
      color: greet,
    );
  }
  static TextStyle search({
    Color search = Colors.grey
  }){
    return TextStyle(
        fontSize: 18,
        color: search,
    );
  }
  static TextStyle price({
    Color price=Colors.blue,
}){
    return TextStyle(
    fontSize: 15,
      color: price,
    );
  }
  static TextStyle pdtPrice({
    Color pdtPrice=Colors.blue,
  }){
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: pdtPrice,
    );
  }
  static TextStyle oldPdtPrice({
    Color pdtPrice=Colors.grey,
  }){
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: pdtPrice,
      decoration: TextDecoration.lineThrough,
    );
  }
  static TextStyle discount({
    Color pdtPrice=Colors.green,
  }){
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: pdtPrice,
      fontStyle: FontStyle.italic,
    );
  }
  static TextStyle rating({
    Color pdtPrice=Colors.grey,
  }){
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: pdtPrice,
    );
  }
  static TextStyle buyNow({
    Color pdtPrice=Colors.black,
  }){
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: pdtPrice,
    );
  }
}