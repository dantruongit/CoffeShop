import 'package:cofeeshop/screens/home_screen/widget/offer_card.dart';
import 'package:cofeeshop/screens/home_screen/widget/sartingtitle_searchfeild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:cofeeshop/constants.dart';
import 'package:cofeeshop/screens/home_screen/widget/coffee_view.dart';
import 'package:provider/provider.dart';
import '../../provider/user.dart';
import 'drawer_screen.dart';

class MyHomePage extends StatelessWidget {
  static const routName = '/Home_page';
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      drawer: const DrawerScreen(),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
          icon: kgradiantIcon(Icons.sort_rounded),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(2.0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(user.image),
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: const [
            SartingTitleandSearchfeild(),
            CoffeeView(),
            OfferCard(),
          ],
        ),
      ),
    );
  }
}
