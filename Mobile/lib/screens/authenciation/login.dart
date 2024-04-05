import 'dart:convert';

import 'package:cofeeshop/service/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/cart.dart';
import '../../provider/coffeedata.dart';
import '../../provider/orders.dart';
import '../../provider/user.dart';
import '../../widgets/bottomnavigaton.dart';
import 'register_page.dart';



class WelcomeBackPage extends StatefulWidget {
  @override
  _WelcomeBackPageState createState() => _WelcomeBackPageState();
}

class _WelcomeBackPageState extends State<WelcomeBackPage> {
  TextEditingController username =
      TextEditingController(text: '');

  TextEditingController password = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final coffeeData = Provider.of<CofeeData>(context);
    final cart = Provider.of<Cart>(context);
    final orders = Provider.of<Orders>(context);

    Widget welcomeBack = const Text(
      'Welcome Back,',
      style: TextStyle(
          color: Colors.white,
          fontSize: 34.0,
          fontWeight: FontWeight.bold,
          shadows: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              offset: Offset(0, 5),
              blurRadius: 10.0,
            )
          ]),
    );

    Widget loginButton = Positioned(
      left: MediaQuery.of(context).size.width / 4,
      bottom: 40,
      child: InkWell(
        onTap: () async {
          String usr = username.value.text;
          String pwd = password.value.text;
          bool isSuccess = await Service.gI().checkLogin(usr, pwd, user) ;
          if(isSuccess) {
            Service.gI().getCoffees(coffeeData);
            Service.gI().getUserCart(user, cart);
            Service.gI().getUserOrder(user, orders);

            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const PageNavigation()));
          }
          else{
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Đăng nhập thất bại. Vui lòng thử lại.'),
                duration: Duration(seconds: 2), // Thời gian hiển thị thông báo
              ),
            );
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 80,
          decoration: BoxDecoration(
              gradient:  const LinearGradient(
                  colors: [
                    Color.fromRGBO(236, 60, 3, 1),
                    Color.fromRGBO(234, 60, 3, 1),
                    Color.fromRGBO(216, 78, 16, 1),
                  ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                  offset: Offset(0, 5),
                  blurRadius: 10.0,
                )
              ],
              borderRadius: BorderRadius.circular(9.0)),
          child: const Center(
              child: Text("Log In",
                  style:  TextStyle(
                      color: Color(0xfffefefe),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 20.0))),
        ),
      ),
    );

    Widget loginForm = Container(
      height: 240,
      child: Stack(
        children: <Widget>[
          Container(
            height: 160,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 32.0, right: 32.0),
            margin: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.8),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    decoration: const InputDecoration(hintText: 'Your username'),
                    controller: username,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    decoration: const InputDecoration(hintText: 'Your password'),
                    controller: password,
                    style: const TextStyle(fontSize: 16.0),
                    obscureText: true,
                  ),
                ),
              ],
            ),
          ),
          loginButton,
        ],
      ),
    );

    Widget registerAccount = Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You\'re new? ',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Color.fromRGBO(255, 255, 255, 0.5),
              fontSize: 14.0,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => RegisterPage()));
            },
            child: const Text(
              'Register',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(

      body: Stack(
        children: <Widget>[

          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/background.jpg'),
                  fit: BoxFit.cover)
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                color: Color.fromRGBO(253, 184, 70, 0.7),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spacer(flex: 1),
                welcomeBack,
                //Spacer(),
                //subTitle,
                Spacer(flex: 1),
                loginForm,
                Spacer(flex: 1),
                registerAccount
              ],
            ),
          )
        ],
      ),
    );
  }
}
