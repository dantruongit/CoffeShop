import 'package:cofeeshop/service/service.dart';
import 'package:flutter/material.dart';

import '../authenciation/login.dart';
import '../custom_background.dart';
import '../home_screen/drawer_screen.dart';
import 'change_password_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Service.gI().getUser(context);
    return CustomPaint(
      painter: MainBackground(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          brightness: Brightness.light,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0,
        ),
        body: SafeArea(
          bottom: true,
          child: LayoutBuilder(
                      builder:(builder,constraints)=> SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: constraints.maxHeight),
                          child: Padding(
              padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      'Account',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                  DrawerTile(
                    icon: Icons.lock,
                    title: 'Change password',
                    onpressed: (){
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => ChangePasswordPage()));
                    },
                  ),
                  DrawerTile(
                    icon: Icons.logout,
                    title: 'Sign out',
                    onpressed: (){
                      Service.gI().logout(user);
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => WelcomeBackPage()));
                    },
                  ),
                ],
              ),
            ),
                        ),
                      )
          ),
        ),
      ),
    );
  }
}
