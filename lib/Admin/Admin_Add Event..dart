import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hope/Admin/Admin_Home_page.dart';
import 'package:hope/main.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Add_event extends StatefulWidget {
  const Add_event({Key? key}) : super(key: key);

  @override
  State<Add_event> createState() => _Add_eventState();
}

class _Add_eventState extends State<Add_event> {

  late bool status;
  late String message;


  TextEditingController _Eventname = TextEditingController();


  TextEditingController _Eventtime = TextEditingController();

  TextEditingController _Eventdescription = TextEditingController();

  TextEditingController Selectdate=TextEditingController();

  DateTime _Pikeddate = DateTime.now();


  @override
  void initState(){

    print("i am loading  first");
    _Eventname = TextEditingController();
    _Eventtime = TextEditingController();
    _Eventdescription = TextEditingController();
    Selectdate=TextEditingController();
  }


  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title:Text("Add Event"),
      ),
      body: Center(
      child: Column(
    children: [
    SizedBox(
    height: 50,
    ),
          Padding(padding: const EdgeInsets.all(10.0),
            child: TextField(

              controller: _Eventname,
              decoration: InputDecoration(
                  hintText: 'Enter Event name',
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

          controller: _Eventtime,
          decoration: InputDecoration(
              hintText: 'Enter Event time',
              border: OutlineInputBorder
                (borderRadius: BorderRadius.circular(5),

              )),

        ),
      ),
      Padding(padding: const EdgeInsets.all(10.0),
        child: TextField(

          controller: _Eventdescription,
          decoration: InputDecoration(
              hintText: 'Enter event description',
              border: OutlineInputBorder
                (borderRadius: BorderRadius.circular(5),

              )),

        ),
      ),
      ElevatedButton(onPressed: (){
        setState(() {
          Add_event_function();
        });


      },
          child: Text("Submit"))
        ],
    ),
    ),
    );
  }

  Future Add_event_function() async {

    var APIURL = "http://$ip_address/charity_hope/admin/admin_event_registration.php";


    //json maping user entered details
    Map maped_data = {
      'name': _Eventname .text,
      'event_date': Selectdate.text,
      'event_time':_Eventtime.text,
      'description':_Eventdescription.text,
      'uid':'admin',

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
      _Eventname.clear();
      Selectdate.clear();

      setState(() {
        status = true;
        message = responseMessage;
      });
      Fluttertoast.showToast(
          msg: "event registered successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey);


      Navigator.push(context, MaterialPageRoute(builder: (context)=>Admin_Home_Page()));
    }
  }


}
