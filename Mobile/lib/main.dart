import 'package:cofeeshop/provider/cart.dart';
import 'package:cofeeshop/provider/coffeedata.dart';
import 'package:cofeeshop/provider/orders.dart';
import 'package:cofeeshop/provider/user.dart';
import 'package:cofeeshop/screens/authenciation/login.dart';
import 'package:cofeeshop/screens/cart_screen/cart_screen.dart';
import 'package:cofeeshop/screens/coffee_description/coffee_description.dart';
import 'package:cofeeshop/screens/favorate%20&%20orderconfrom/order_conform.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CofeeData(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => Orders(),
        ),
        ChangeNotifierProvider(
            create: (_) => User()
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Coffee Shop',
        theme: ThemeData(
          drawerTheme: const DrawerThemeData(),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
              color: Colors.white,
            ),
            bodyMedium: TextStyle(
              color: Colors.white,
            ),
            bodySmall: TextStyle(color: Colors.grey),
          ),
          scaffoldBackgroundColor: const Color(0xff0c0f14),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            onSecondary: const Color(0xffd17842),
            primary: const Color(0xff0c0f14),
          ),
          primaryColor: const Color(0xff0c0f14),
        ),
        routes: {
          CoffeeDescription.routName: (ctx) => const CoffeeDescription(),
          CartScreen.routName: (ctx) => const CartScreen(),
          OrderConfirmationScreen.routeName: (context) =>
              const OrderConfirmationScreen(),
        },
        home: WelcomeBackPage(),
        //home: const PageNavigation(),
      ),
    );
  }
}
