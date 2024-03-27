import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hope/User/user_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Admin/Admin_Home_page.dart';
import '../main.dart';
import 'User_Home_page.dart';




var key_value;
var Admin_key;
class User_splashscreen extends StatefulWidget {
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<User_splashscreen> {

  void initState() {
    getValidationData().whenComplete(() async {
      await Timer(Duration(seconds: 1), () {
        Admin_key == null
            ? Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => User_loginpage()))
            : Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    User_homepage()));
      });
    });
    setState(() {

      get_uid_user();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Loading......",
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              color: Colors.lightBlue,
            ),
          ],
        ),
      ),
    );
  }

  // Future getValidationData() async {
  //   final SharedPreferences sharedprefs = await SharedPreferences.getInstance();
  //   var obtainedemail = await sharedprefs.getString('key');
  //   setState(() {
  //     key_value = obtainedemail;
  //   });
  //   print('this is session value $key_value');
  // }

  Future getValidationData() async {
    final SharedPreferences sharedprefs = await SharedPreferences
        .getInstance();

    var obtainedemail = await sharedprefs.getString('user_id');

    setState(() {
      Admin_key = obtainedemail;
    });
  }
  get_uid_user()async {
    final SharedPreferences shrdprfs =await SharedPreferences.getInstance();
    var obtainedid =shrdprfs.getString('uid_user');
    setState(() {
      uid = obtainedid;
    });
  }


}



