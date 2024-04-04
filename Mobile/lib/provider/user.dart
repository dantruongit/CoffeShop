import 'package:flutter/cupertino.dart';

class UserSession{
  late String jwtKey;
  late String imagePath;
  late String name;

  void clear(){
    jwtKey = '';
    imagePath = '';
    name = '';
  }
}

class User extends ChangeNotifier{
  final UserSession userSession = UserSession();
  String get image{
    return userSession.imagePath;
  }

  String get name{
    return userSession.name;
  }

  String get key{
    return userSession.jwtKey;
  }

  void login(String jwtKey, String name, String imagePath){
    userSession.jwtKey = jwtKey;
    userSession.imagePath = imagePath;
    userSession.name = name;
  }

  void signOut(){
    userSession.clear();
  }
}