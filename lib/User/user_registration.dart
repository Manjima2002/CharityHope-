import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hope/User/user_login.dart';
import 'package:http/http.dart' as http;

import '../main.dart';



class User_Registration extends StatefulWidget {
  const User_Registration({Key? key}) : super(key: key);

  @override
  _User_RegistrationState createState() => _User_RegistrationState();
}

class _User_RegistrationState extends State<User_Registration> {

  TextEditingController _username = TextEditingController();

  TextEditingController _email = TextEditingController();

  TextEditingController _phone = TextEditingController();

  TextEditingController _password = TextEditingController();

  TextEditingController _confirmpassword = TextEditingController();

  late bool status;

  late String message;

  @override
  void initState() {
    _username = TextEditingController();
    _email = TextEditingController();
    _phone = TextEditingController();
    _password = TextEditingController();
    _confirmpassword = TextEditingController();

    status = false;
    message = "";

    super.initState();
  }

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Sign up",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                    ),
                    child: TextFormField(
                      controller: _username,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a Username";
                        }
                        return null;
                      },
                      onSaved: (name) {},
                      obscureText: false,
                      decoration: InputDecoration(
                        label: Text("username"),
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color: Colors.grey[400],
                            color: Colors.grey.shade500,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade500,
                            )),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                    ),
                    child: TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter  email";
                        }
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value)) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                      onSaved: (email) {},
                      obscureText: false,
                      decoration: InputDecoration(
                        label: Text("email"),
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color: Colors.grey[400],
                            color: Colors.grey.shade500,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade500,
                            )),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                    ),
                    child: TextFormField(
                      controller: _phone,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty && value!.length == 10) {
                          return "Please enter phone number";
                        }
                        return null;
                      },
                      onSaved: (name) {},
                      obscureText: false,
                      decoration: InputDecoration(
                        label: Text("phone"),
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color: Colors.grey[400],
                            color: Colors.grey.shade500,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade500,
                            )),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                    ),
                    child: TextFormField(
                      controller: _password,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a Password";
                        }
                        return null;
                      },
                      onSaved: (name) {},
                      obscureText: true,
                      decoration: InputDecoration(
                        label: Text("password"),
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color: Colors.grey[400],
                            color: Colors.grey.shade500,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade500,
                            )),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                    ),
                    child: TextFormField(
                      controller: _confirmpassword,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter re-password";
                        }
                        if (_password.text != _confirmpassword.text) {
                          return "Password Do not match";
                        }
                        return null;
                      },
                      onSaved: (name) {},
                      decoration: InputDecoration(
                        label: Text("confirm password"),
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color: Colors.grey[400],
                            color: Colors.grey.shade500,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade500,
                            )),
                      ),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent.shade100,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () {

                      if (formkey.currentState!.validate()) {
                        setState(() {

                          Registration();
                        });
                        _username.clear();
                        _email.clear();
                        _phone.clear();
                        _password.clear();
                        _confirmpassword.clear();
                      }
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                  ),
                ),
                // Text(
                //   status ? message : message,
                //   style: GoogleFonts.lato(
                //       fontSize: 12,
                //       color: Colors.red.shade900,
                //       fontWeight: FontWeight.bold),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? "),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => User_loginpage()));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                  ],
                )
              ],
            ),

            //],
          ),
        ),
      ),
    );
  }

  Future Registration() async {
    var APIURL = "http://$ip_address/charity_hope/user/User_Registration.php";

    //json maping user entered details
    Map mapeddate = {
      'username': _username.text,
      'email': _email.text,
      'phone': _phone.text,
      'password': _password.text

    };
    //send  data using http post to our php code
    http.Response reponse = await http.post(Uri.parse(APIURL), body: mapeddate);

    //getting response from php code, here
    var data = jsonDecode(reponse.body);
    var responseMessage = data["message"];
    var responseError = data["error"];
    print("DATA: ${data}");
    if (responseError) {
      setState(() {
        status = false;
        message = responseMessage;
      });
      Fluttertoast.showToast(
          msg: 'email and password already exists try another! ',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          webPosition: 1,
          backgroundColor: Colors.blueGrey);
    } else {
      _username.clear();
      _email.clear();
      _phone.clear();
      _password.clear();
      _confirmpassword.clear();

      setState(() {
        status = true;
        message = responseMessage;
      });

      Fluttertoast.showToast(
          msg: 'Registration successfull ',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey);
    }

    print("DATA: ${data}");
  }
}

