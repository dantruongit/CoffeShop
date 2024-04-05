import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../provider/cart.dart';
import '../provider/coffee.dart';
import '../provider/coffeedata.dart';
import '../provider/orders.dart';
import '../provider/user.dart';
import '../screens/cart_screen/widget/cart_item.dart';

const String host = 'http://localhost:12121';

class Service{
  static Service service = Service();
  static Service gI(){
    return service;
  }

  //Get provider
  User getUser(BuildContext context){
    return Provider.of<User>(context);
  }

  Future<bool> checkLogin(String username, String password, User user) async {
    String url = '$host/login';
    Map<String, String> headers = {
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Content-Type" : "application/json"
    };
    Map<String, String> body = {
      "username" : username,
      "password" : password
    };

    http.Response response =
        await http.post(Uri.parse(url), headers: headers, body: json.encode(body));
    final data = jsonDecode(response.body);
    //print(response.body);
    if(data['isSuccess'] == true){
      user.login(data['token'], data['name'], data['image']);
      return true;
    }
    else{
      return false;
    }
  }

  Future<bool> register(String username, String password, String fullName) async {
    String url = '$host/register';
    Map<String, String> headers = {
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Content-Type" : "application/json"
    };
    Map<String, String> body = {
      "username" : username,
      "password" : password,
      "fullName" : fullName
    };

    http.Response response =
    await http.post(Uri.parse(url), headers: headers, body: json.encode(body));
    final data = jsonDecode(response.body);
    print(response.body);
    return data['isSuccess'] as bool;
  }

  Future<void> getUserCart(User user, Cart cart) async {
    String url = '$host/get_user_cart';
    Map<String, String> headers = {
      "Access-Control-Allow-Origin": "*",
      "Content-Type" : "application/json"
    };
    Map<String, String> body = {
      "jwtKey" : user.key,
    };

    http.Response response =
    await http.post(Uri.parse(url), headers: headers, body: json.encode(body));
    final data = jsonDecode(response.body);
    final cartArr = data['cart'];
    List<CartItems> cartItems = [];
    for(var cartItem in cartArr){
        dynamic cfData = cartItem['coffe'];
        int quantity = cartItem['quantity'];
        CartItems cI = CartItems(id: cfData['id'], title: cfData['title'], image: cfData['image'], amount: cfData['amount'], descritoin: cfData['description'], quantity: quantity);
        cartItems.add(cI);
    }
    cart.loadItem(cartItems);
  }

   Future<void> getUserOrder(User user, Orders orders) async {
    String url = '$host/get_user_order';
    Map<String, String> headers = {
      "Access-Control-Allow-Origin": "*",
      "Content-Type" : "application/json"
    };
    Map<String, String> body = {
      "jwtKey" : user.key,
    };
    http.Response response =
    await http.post(Uri.parse(url), headers: headers, body: json.encode(body));
    final data = jsonDecode(response.body);
    final orderArr = data['orders'];
    List<OrdersItem> ordersItem = [];

    for(var orderItem in orderArr){
      String dateTimeString = orderItem['date_time'];
      String formattedDateTimeString = dateTimeString.replaceAll('"', ''); // Loại bỏ dấu ngoặc kép
      DateTime dateTime = DateTime.parse(formattedDateTimeString);
      List<CartItem> products = [];
      for(var orderItem in orderItem['order_items']){
          dynamic coffeData = orderItem['coffe'];
          CartItem cartItem = CartItem(image: coffeData['image'], title: coffeData['title'],
              prodcutid: coffeData['id'], id: orderItem["id_order"].toString(),
              amount: coffeData['amount'], qunatity: orderItem['quantity'], description: coffeData['description']);
          products.add(cartItem);
      }
      OrdersItem orderI = OrdersItem(id: orderItem['id'].toString(), amount: orderItem['amount'], products: products, dateTime: dateTime);
      ordersItem.add(orderI);
    }
    orders.loadOrders(ordersItem);
  }

  void logout(User user){
    user.signOut();
  }

  Future<void> getCoffees(CofeeData coffeeData) async{
    List<Coffee> coffees = [];
    String url = '$host/get_coffees';
    Map<String, String> headers = {
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
    };
    http.Response response = await http.get(Uri.parse(url), headers: headers);
    final data = jsonDecode(response.body);
    for(int i = 0; i < data.length; i ++){
      Coffee coffee = Coffee(id: data[i]['id'], title: data[i]['title'], image: data[i]['image'], amount: data[i]['amount'], description: data[i]['description']);
      coffees.add(coffee);
    }
    coffeeData.coffeeList = coffees;
  }
}