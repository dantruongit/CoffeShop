import 'package:flutter/material.dart';

class CartItems {
  final String id;
  final String title;
  final String image;
  final double amount;
  final int quantity;
  final String descritoin;

  CartItems(
      {required this.id,
      required this.title,
      required this.image,
      required this.amount,
      required this.descritoin,
      required this.quantity});
}

class Cart extends ChangeNotifier {
  Map<String, CartItems> _items = {};
  Map<String, CartItems> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    items.forEach((key, cartItem) {
      total += cartItem.amount * cartItem.quantity;
    });
    return total;
  }

  int get totalQuantity {
    int totalQty = 0;
    items.forEach((key, cartItem) {
      totalQty += cartItem.quantity;
    });
    return totalQty;
  }

  void loadItem(List<CartItems> cartItems){
    _items.clear();
    for(CartItems cI in cartItems){
      _items[cI.id] = cI; // Gán giá trị trực tiếp
    }
    notifyListeners();
  }

  void addItem(String id, double amount, String title, String image,
      String description) {
    if (_items.containsKey(id)) {
      _items.update(
        id,
        (existingCartItem) => CartItems(
            id: existingCartItem.id,
            title: existingCartItem.title,
            image: existingCartItem.image,
            amount: existingCartItem.amount,
            quantity: existingCartItem.quantity + 1,
            descritoin: existingCartItem.descritoin),
      );
    } else {
      _items.putIfAbsent(
        id,
        () => CartItems(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            title: title,
            image: image,
            amount: amount,
            descritoin: description,
            quantity: 1),
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
