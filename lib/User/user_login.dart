import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hope/User/user_Dashboard.dart';

import 'package:hope/User/user_registration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

import 'package:http/http.dart' as http;

import 'User_Home_page.dart';



class User_loginpage extends StatefulWidget {
  const User_loginpage({Key? key}) : super(key: key);

  @override
  _User_loginpageState createState() => _User_loginpageState();
}

class _User_loginpageState extends State<User_loginpage> {


  get_uid() async {
    final shrdprfs = await SharedPreferences.getInstance();
    await shrdprfs.setString("uid_user", uid);
  }

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "User Login",
          style: TextStyle(color: Colors.blueGrey),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            Form(
              key: formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    child: TextFormField(
                      controller: username,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter username";
                        }
                        return null;
                      },
                      onSaved: (username) {},
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          // labelText: 'Email',
                          hintText: 'username'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    //padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: password,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter password";
                        }
                        return null;
                      },
                      onSaved: (name) {},
                      style: TextStyle(),
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter secure password'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 15,
              width: MediaQuery.of(context).size.width / 1.3,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent.shade100,
                ),
                onPressed: ()
                //async
                {
                  setState(() {
                    admin_Login();
                  });

                  if (formkey.currentState!.validate()) {


                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'New User?',
                  style: TextStyle(color: Colors.black87, fontSize: 15),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>   User_Registration()));
                    },
                    child: Text("Create Account"))
              ],
            )
          ],
        ),
      ),
    );
  }

  // Future Login() async {
  //   //var url = "http://192.168.29.64/internship_crud/Login.php";
  //   var url ="http://192.168.29.64/internship_crud/Login2.php";
  //   var response = await http.post(Uri.parse(url), headers: {
  //     'Accept': 'application/json'
  //   }, body: {
  //     "username": username.text,
  //     "password": password.text,
  //   });
  //
  //   var data = json.decode(response.body);
  //   // if (data.toString() == "Success") {
  //   if (data != null) {
  //     //var responseData = json.decode(response.body);
  //
  //     for (var singleUser in data) {
  //       final SharedPreferences sharedpreferences =
  //       await SharedPreferences.getInstance();
  //
  //       await sharedpreferences.setString('key',singleUser["id"]);
  //      // print(singleUser["id"]);
  //
  //     //   session_Key = singleUser["id"];
  //       //
  //       // email_text_admin = singleUser["email"];
  //       // print('hello click ${email_text_admin}');
  //
  //       // getid = singleUser["id"];
  //
  //       // getId();
  //       // getemail();
  //     }
  //
  //     final snackBar = SnackBar(
  //       content: Text('Login Successfull'),
  //       action: SnackBarAction(
  //         label: 'Ok',
  //         onPressed: () {
  //           // Some code to undo the change.
  //         },
  //       ),
  //     );
  //
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //
  //     Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //             builder: (BuildContext context) =>
  //                 HomePage()));
  //   } else {
  //     final snackBar = SnackBar(
  //       content: Text('Username and password invalid'),
  //       action: SnackBarAction(
  //         label: 'Undo',
  //         onPressed: () {
  //           // Some code to undo the change.
  //         },
  //       ),
  //     );
  //
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   }
  // }
  Future admin_Login() async {
    var url = "http://$ip_address/charity_hope/user/User_Login.php";
    var response = await http.post(Uri.parse(url), headers: {
      'Accept': 'application/json'
    }, body: {
      "username": username.text,
      "password": password.text,
    });

    var data = json.decode(response.body);
    // if (data.toString() == "Success") {
    if (data != null) {
      //var responseData = json.decode(response.body);

      for (var singleUser in data) {

        final SharedPreferences sharedpreferences =
        await SharedPreferences.getInstance();

        await sharedpreferences.setString('user_id', singleUser["id"]);
        uid = singleUser["id"];
        get_uid();

        // admin_id = singleUser["id"];
        //
        // email_text_admin = singleUser["email"];
        // print('hello click ${email_text_admin}');
        //
        // // getid = singleUser["id"];
        //
        // getId();
        // getemail();
      }

      final snackBar = SnackBar(
        content: Text('Login Successfull'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  user_Dashboard()));
    } else {
      final snackBar = SnackBar(
        content: Text('Username and password invalid'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

    // Some code to undo the change.

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}


