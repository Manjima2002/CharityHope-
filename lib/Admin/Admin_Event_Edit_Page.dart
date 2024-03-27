import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hope/main.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'Admin_Edit event_Display.dart';




class Admin_Event_Edit extends StatefulWidget {

  final Event_model data_user;

  Admin_Event_Edit({required this.data_user});

  @override
  _Admin_Event_EditState createState() => _Admin_Event_EditState();
}

class _Admin_Event_EditState extends State<Admin_Event_Edit> {

  TextEditingController _Eventname = TextEditingController();


  TextEditingController _Eventtime = TextEditingController();

  TextEditingController _Eventdescription = TextEditingController();

  TextEditingController Selectdate=TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Event_Update_function() async {

    final response = await http.post(
        Uri.parse("http://$ip_address/charity_hope/admin/admin_event_edit.php"),
        body: {
          "id": widget.data_user.id.toString(),
          "name": _Eventname.text,
          "event_date": Selectdate.text,
          'event_time':_Eventtime.text,
          'description':_Eventdescription.text,
          'uid':"admin",


        });
    if (response.statusCode == 200) {

      _Eventname.clear();
      Selectdate.clear();
      _Eventtime.clear();
      _Eventdescription.clear();

      final snackBar = await SnackBar(
        content: const Text('event updated successfully!'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            //Navigator.pop(context);
            // Some code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      print("not");
      final snackBar = await SnackBar(
        content: const Text('event updation failed!'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            //Navigator.pop(context);
            // Some code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    setState(() {});
  }

  @override
  void initState() {
    _Eventname = TextEditingController(text: widget.data_user.name);
    Selectdate = TextEditingController(text: widget.data_user.eventdate);
    _Eventtime= TextEditingController(text: widget.data_user.eventtime);
    _Eventdescription = TextEditingController(text: widget.data_user.description);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Edit Event",
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
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Container(
                    // padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    child: TextFormField(
                      controller: _Eventname,
                      decoration: InputDecoration(
                        labelText: "Enter event name",
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  SizedBox(
                    height: 30,
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
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                    ),
                    keyboardType:TextInputType.datetime,),
                  SizedBox(
                    height: 30,
                  ),


                  Container(
                    // padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    child: TextFormField(
                      controller: _Eventtime,
                      decoration: InputDecoration(
                        labelText: "Enter event time",
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    // padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    child: TextFormField(
                      controller: _Eventdescription,
                      decoration: InputDecoration(
                        labelText: "Enter event event description",
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: Colors.purpleAccent,
                      padding: EdgeInsets.only(
                          left: 100, right: 100, top: 20, bottom: 20),
                    ),
                    onPressed: () {
                      setState(() {
                        Event_Update_function();
                        _Eventname.clear();
                        Selectdate.clear();
                        _Eventtime.clear();
                        _Eventdescription.clear();
                      });



                    },
                    child: Text(
                      "Update",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
