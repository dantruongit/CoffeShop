import 'package:cofeeshop/screens/settings/settings_page.dart';
import 'package:cofeeshop/screens/wallet/wallet_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../provider/user.dart';
import '../order_historyScreen/orders_histroy.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Drawer(
      backgroundColor: kprimarycolor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: ListView(
        children: [
          SizedBox(height: 20,),
          CircleAvatar(
            radius: 80,
            backgroundImage: NetworkImage(user.image),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Hello, ${user.name}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  color: klightgrycolor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          DrawerTile(
              title: 'Wallet & Coupons', icon: Icons.wallet,
              onpressed: (){
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => WalletPage()));
              },),
          DrawerTile(
              title: 'Settings', icon: Icons.settings,
              onpressed: (){
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SettingsPage()));
              },),
          DrawerTile(title: 'About', icon: Icons.info_outline_rounded,
          onpressed: () async {
            final Uri url = Uri.parse('https://www.facebook.com/dantruong.it');
              if (!await launchUrl(url)) {
                throw Exception('Could not launch $url');
              }
          },),
          
        ],
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    Key? key,
    this.onpressed,
    required this.title,
    required this.icon,
  }) : super(key: key);
  final Function()? onpressed;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onpressed,
      leading: Icon(
        icon,
        color: klightgrycolor,
      ),
      title: Text(
        title,
        style: TextStyle(color: klightgrycolor, fontSize: 15),
      ),
    );
  }
}