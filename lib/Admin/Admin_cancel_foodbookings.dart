import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hope/main.dart';

import 'package:http/http.dart' as http;

import 'Admin_Event_Edit_Page.dart';

//Creating a class user to store the data;
class Food_model{
  // final String id;
  final String id;
  final String date;
  final String donor;
  final String food;


  Food_model({
    // required this.id,
    required this.id,
    required this.date,
    required this.donor,
    required this.food,

  });
}

class Admin_cancel_food_booking extends StatefulWidget {
  @override
  _Admin_cancel_food_bookingState createState() => _Admin_cancel_food_bookingState();
}

class _Admin_cancel_food_bookingState extends State<Admin_cancel_food_booking> {
//Applying get request.

  Future<List<Food_model>> getRequest() async {
    //replace your restFull API here.
    String url = "http://$ip_address/charity_hope/admin/admin_fooddonation_display_data.php";

    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    List<Food_model> users = [];

    for (var singleUser in responseData) {
      Food_model user = Food_model(
        //id:  singleUser["id"].toString(),
        id: singleUser["id"].toString(),
        donor: singleUser["donor"].toString(),
        date: singleUser["date"].toString(),
        food: singleUser["food"].toString(),

      );

      //Adding user to the list.
      users.add(user);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Display Food Donation",

            ),
            backgroundColor: Colors.purpleAccent,
          ),
          body: Container(
            padding: EdgeInsets.all(16.0),

            child: FutureBuilder(
              future: getRequest(),

              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Colors.pink.shade100,
                            strokeWidth: 5,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Data Loading Please Wait!",
                            style: TextStyle(),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (ctx, index) =>
                        Column(
                          children: [
                            Card(
                              color: Colors.pink.shade100,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: ListTile(
                                      title: Text(
                                        snapshot.data[index].donor,
                                      ),


                                      subtitle: Text(
                                        snapshot.data[index].food,
                                      ),
                                      trailing: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                               delrecord(snapshot.data[index].id);
                                            });
                                          },
                                          child: Text("cancel")),

                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                  );
                }
              },
            ),
          ),

        )
    );
  }

    Future<void> delrecord(String id) async {
      String url =
          "http://$ip_address/charity_hope/admin/admin_delete_fooddonation.php";
      var res = await http.post(Uri.parse(url), body: {
        "id": id,
      });
      var resoponse = jsonDecode(res.body);
      if (resoponse["success"] == "true") {
        setState(() {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Admin_cancel_food_booking()));
          Fluttertoast.showToast(
              msg: 'food Cancelled ',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors
                  .black);
        });
      }}




  }
