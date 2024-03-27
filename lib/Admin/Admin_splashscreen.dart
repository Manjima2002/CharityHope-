import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Admin_Dashboard.dart';
import 'Admin_Home_page.dart';
import 'Admin_login page.dart';




var key_value;
var Admin_key;
class Admin_Splashscreen extends StatefulWidget {
  _Admin_SplashscreenState createState() => _Admin_SplashscreenState();
}

class _Admin_SplashscreenState extends State<Admin_Splashscreen> {

  void initState() {
      getValidationData().whenComplete(() async {
        await Timer(Duration(seconds: 1), () {
          Admin_key == null
              ? Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Admin_loginpage()))
              : Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          Dashboard()));
        });
      });
      setState(() {});

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

      var obtainedemail = await sharedprefs.getString('admin_id');

      setState(() {
        Admin_key = obtainedemail;
      });
    }
  }


