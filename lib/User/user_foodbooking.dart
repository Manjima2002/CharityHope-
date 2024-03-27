import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:hope/main.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'User_Home_page.dart';

class user_food_booking extends StatefulWidget {
  const user_food_booking({Key? key}) : super(key: key);

  @override
  State<user_food_booking> createState() => _user_food_bookingState();
}

class _user_food_bookingState extends State<user_food_booking> {

  late bool status;
  late String message;


  TextEditingController donor = TextEditingController();


  TextEditingController Selectdate= TextEditingController();

  TextEditingController food = TextEditingController();



  DateTime _Pikeddate = DateTime.now();


  @override
  void initState(){

    print("i am loading  first");
    donor = TextEditingController();
    food = TextEditingController();
    Selectdate=TextEditingController();
  }


  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title:Text("Add Food Booking"),
        backgroundColor: Colors.purpleAccent,
        centerTitle: true,
      ),
      body: Center(
      child: Column(
    children: [
    SizedBox(
    height: 50,
    ),
          Padding(padding: const EdgeInsets.all(10.0),
            child: TextField(

              controller: donor,
              decoration: InputDecoration(
                  hintText: 'Enter Donor name',
                  border: OutlineInputBorder
                    (borderRadius: BorderRadius.circular(5),

              )),

            ),
          ),
      TextField(

        onTap:()
        async{
          DateTime? Pickeddate = await showDatePicker(context: context,
              initialDate: DateTime.now(), firstDate: DateTime(2000),
              lastDate: DateTime(2101));

          if (Pickeddate != null) {
            setState(() {
              Selectdate.text = DateFormat('yyyy/MM/dd').format(Pickeddate);
            }
            );
          }
        },
        controller:Selectdate,
        decoration:InputDecoration(
          icon: Icon(Icons.calendar_today_rounded),
          labelText: "pick date",
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purpleAccent),
          ),
        ),
        keyboardType:TextInputType.datetime,),



      // Padding(padding: const EdgeInsets.all(10.0),
      //   child: TextField(
      //
      //     controller: _pickdate,
      //     decoration: InputDecoration(
      //         hintText: 'Pick date',
      //         border: OutlineInputBorder
      //           (borderRadius: BorderRadius.circular(5),
      //
      //         )),
      //
      //   ),
      // ),
      Padding(padding: const EdgeInsets.all(10.0),
        child: TextField(

          controller: food,
          decoration: InputDecoration(
              hintText: 'Enter Food item',
              border: OutlineInputBorder
                (borderRadius: BorderRadius.circular(5),

              )),

        ),
      ),
      // Padding(padding: const EdgeInsets.all(10.0),
      //   child: TextField(
      //
      //     controller: _Eventdescription,
      //     decoration: InputDecoration(
      //         hintText: 'Enter event description',
      //         border: OutlineInputBorder
      //           (borderRadius: BorderRadius.circular(5),
      //
      //         )),
      //
      //   ),
      // ),
      SizedBox(height: 100,),
        SizedBox(
          width: 100,
          height: 50,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purpleAccent.shade100,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),onPressed: (){
        setState(() {
          Add_food_booking_function();
        });


      },
          child: Text("Submit"))),
        ],
    ),
    ),
    );
  }

  Future Add_food_booking_function() async {

    var APIURL = "http://$ip_address/charity_hope/user/user_add_foodbook_%20-%20Copy.php";


    //json maping user entered details
    Map maped_data = {
      'donor': donor .text,
      'date': Selectdate.text,
      'food':food.text,
      'uid':uid,

    };
    //send  data using http post to our php code
    http.Response reponse = await http.post(Uri.parse(APIURL), body: maped_data);

    //getting response from php code, here
    var data = jsonDecode(reponse.body);
    var responseMessage = data["message"];
    var responseError = data["error"];



    if (responseError) {
      setState(() {
        status = false;
        message = responseMessage;
      });
    } else {
      donor.clear();
      Selectdate.clear();

      setState(() {
        status = true;
        message = responseMessage;
      });
      Fluttertoast.showToast(
          msg: "food registered successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey);


      Navigator.push(context, MaterialPageRoute(builder: (context)=>User_homepage()));
    }
  }


}
