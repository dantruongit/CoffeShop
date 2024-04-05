import 'package:cofeeshop/service/service.dart';
import 'package:flutter/material.dart';

const LinearGradient mainButton = LinearGradient(colors: [
  Color.fromRGBO(236, 60, 3, 1),
  Color.fromRGBO(234, 60, 3, 1),
  Color.fromRGBO(216, 78, 16, 1),
], begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter);

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController email = TextEditingController(text: '');
  TextEditingController password = TextEditingController(text: '');
  TextEditingController fullName = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    Widget title = const Text(
      'Glad To Meet You',
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

    Widget subTitle = const Padding(
        padding: EdgeInsets.only(right: 56.0),
        child: Text(
          'Create your new account for future uses.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ));

    Widget registerButton = Positioned(
      left: MediaQuery.of(context).size.width / 4,
      bottom: 40,
      child: InkWell(
        onTap: () async {
          String usr = email.value.text;
          String pwd = password.value.text;
          String name = fullName.value.text;

          bool isRegistered = await Service.gI().register(usr, pwd, name);
          if(isRegistered){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Đăng ký thành công !'),
                duration: Duration(seconds: 2),
              ),
            );
          }
          else{
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Đăng ký thất bại !'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 80,
          child: Center(
              child: new Text("Register",
                  style: const TextStyle(
                      color: const Color(0xfffefefe),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 20.0))),
          decoration: BoxDecoration(
              gradient: mainButton,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                  offset: Offset(0, 5),
                  blurRadius: 10.0,
                )
              ],
              borderRadius: BorderRadius.circular(9.0)),
        ),
      ),
    );

    Widget registerForm = Container(
      height: 350,
      child: Stack(
        children: <Widget>[
          Container(
            height: 300,
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
                    controller: email,
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
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    decoration: const InputDecoration(hintText: 'Your name'),
                    controller: fullName,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
          registerButton,
        ],
      ),
    );

    // Widget socialRegister = Column(
    //   children: <Widget>[
    //     Text(
    //       'You can sign in with',
    //       style: TextStyle(
    //           fontSize: 12.0, fontStyle: FontStyle.italic, color: Colors.white),
    //     ),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         IconButton(
    //           icon: Icon(Icons.find_replace),
    //           onPressed: () {},
    //           color: Colors.white,
    //         ),
    //         IconButton(
    //             icon: Icon(Icons.find_replace),
    //             onPressed: () {},
    //             color: Colors.white),
    //       ],
    //     )
    //   ],
    // );

    return Scaffold(

              body: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Spacer(flex:1),
                        title,
                        //Spacer(),

                        //subTitle,
                        Spacer(flex:1),

                        registerForm,
                        Spacer(flex:1),
                        // Padding(
                        //     padding: EdgeInsets.only(bottom: 20), child: socialRegister)
                      ],
                    ),
                  ),

                  Positioned(
                    top: 35,
                    left: 5,
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            );
  }
}
