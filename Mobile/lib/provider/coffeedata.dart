import 'package:cofeeshop/provider/coffee.dart';
import 'package:flutter/material.dart';

class CofeeData extends ChangeNotifier {
  final List<Coffee> _coffeeList = [];

  List<Coffee> get coffeeList {
    return [..._coffeeList];
  }

  set coffeeList(List<Coffee> value){
    _coffeeList.clear();
    for(Coffee cf in value){
      _coffeeList.add(cf);
    }
    notifyListeners();
  }

  List<Coffee> get favoriteItems {
    return _coffeeList.where((item) => item.isFavarate).toList();
  }

  Coffee findByid(String id) {
    return _coffeeList.firstWhere((item) => item.id == id);
  }

  void addProduct() {
    notifyListeners();
  }

  Coffee findById(String id) {
    return coffeeList.firstWhere((cofe) => cofe.id == id);
  }

  void refreshUI() {
    notifyListeners();
  }
}
