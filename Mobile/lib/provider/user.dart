import 'package:flutter/cupertino.dart';

class UserSession{
  late String jwtKey;
  late String imagePath = "http://localhost/guest.png";
  late String name;
  late double balance = 0.0;

  void clear(){
    jwtKey = '';
    imagePath = "http://localhost/guest.png";
    name = '';
    balance = 0.0;
  }
}

class User extends ChangeNotifier{
  final UserSession userSession = UserSession();
  String get image{
    return userSession.imagePath;
  }

  set image(String value){
    userSession.imagePath = value;
  }

  String get name{
    return userSession.name;
  }

  set name(String value){
    userSession.name = value;
  }

  String get key{
    return userSession.jwtKey;
  }

  set key(String value){
    userSession.jwtKey = value;
  }

  double get balance{
    return userSession.balance;
  }

  set balance(double value){
    userSession.balance = value;
    notifyListeners();
  }

  void login(String jwtKey, String name, String imagePath){
    userSession.jwtKey = jwtKey;
    userSession.imagePath = imagePath;
    userSession.name = name;
    notifyListeners();
  }

  void signOut(){
    userSession.clear();
    notifyListeners();
  }
}