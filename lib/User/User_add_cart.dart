import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

//import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../main.dart';
import 'User_Home_page.dart';

class User_Craft_detail_page extends StatefulWidget {
  var craftid, qty, image, price;

  User_Craft_detail_page(
      {required this.price, required this.image, required this.craftid});

  @override
  _User_Craft_detail_pageState createState() => _User_Craft_detail_pageState();
}

class _User_Craft_detail_pageState extends State<User_Craft_detail_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Craft",
          style: GoogleFonts.prompt(color: Colors.white),
        ),
        backgroundColor: Colors.purpleAccent,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_rounded, color: Colors.white,
            size: 35, // add custom icons also
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              height: 500,
              width: 300,
              child: Image(image: NetworkImage(widget.image)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Price:"),
                Text(widget.price),
              ],
            ),
             Text(widget.craftid),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    Add_cart_function();
                  });
                  // Navigator.push(context,MaterialPageRoute(builder: (context)=>User_homepage()
                  // ));
                },
                child: Text("Add to cart")),
          ],
        ),
      ),
    );
  }

  Future Add_cart_function() async {
    var APIURL =
        "http://$ip_address/charity_hope/user/user_add_cart.php?uid"+uid;

    //json maping user entered details
    Map maped_data = {
      'craft_id': widget.craftid,
      'qty': '1',
      'uid': uid,
    };
    //send  data using http post to our php code
    http.Response reponse =
        await http.post(Uri.parse(APIURL), body: maped_data);

    //getting response from php code, here
    var data = jsonDecode(reponse.body);
    var responseMessage = data["message"];
    var responseError = data["error"];

    if (responseError) {
      setState(() {});
    } else {
      setState(() {
        Fluttertoast.showToast(
            msg: "Product added successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blueGrey);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => User_homepage()));
      });
    }
  }
}
