import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hope/main.dart';

import 'package:http/http.dart' as http;

import 'Admin_Event_Edit_Page.dart';

//Creating a class user to store the data;
class Donation_model{
  // final String id;
  final String id;
  final String name;
  final String place;
  final String bank;
  final String phone;
  final String account;
  final String amount;

  Donation_model({
    // required this.id,
    required this.id,
    required this.name,
    required this.place,
    required this.bank,
    required this.phone,
    required this.account,
    required this.amount,
  });
}

class Admin_donation_Display_Page extends StatefulWidget {
  @override
  _Admin_donation_Display_PageState createState() => _Admin_donation_Display_PageState();
}

class _Admin_donation_Display_PageState extends State<Admin_donation_Display_Page> {
//Applying get request.

  Future<List<Donation_model>> getRequest() async {
    //replace your restFull API here.
    String url = "http://$ip_address/charity_hope/admin/admin_money_donation_display.php";

    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    List<Donation_model> users = [];

    for (var singleUser in responseData) {
      Donation_model user = Donation_model(
        //id:  singleUser["id"].toString(),
        id: singleUser["id"].toString(),
        name: singleUser["name"].toString(),
       place: singleUser["place"].toString(),
        phone: singleUser["phone"].toString(),
        bank: singleUser["bank"].toString(),
          account: singleUser["account"].toString(),
          amount: singleUser["amount"].toString()
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
              "Display Donation",
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
                            color: Colors.purpleAccent.shade100,
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
                                        snapshot.data[index].name,
                                      ),
                                      leading: GestureDetector(
                                          onTap: () {
                                            setState(() {

                                            });
                                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  Admin_Event_Edit(data_user: snapshot.data[index],)));
                                          },

                                          child: Icon(Icons.edit,
                                            color: Colors.pink.shade100,)),

                                      subtitle: Text(
                                        snapshot.data[index].place,
                                      ),
                                      trailing: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                               // delrecord(snapshot.data[index].id);


                                            });


                                          },
                                          child: Icon(Icons.delete,
                                            color: Colors.pink.shade100,)),

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

    // Future<void> delrecord(String id) async {
    //   String url =
    //       "http://$ip_address/charity_hope/admin/admin_event_delete_data.php";
    //   var res = await http.post(Uri.parse(url), body: {
    //     "id": id,
    //   });
    //   var resoponse = jsonDecode(res.body);
    //   if (resoponse["success"] == "true") {
    //     setState(() {
    //       Navigator.pushReplacement(
    //           context,
    //           MaterialPageRoute(
    //               builder: (context) => Admin_donation_Display_Page()));
    //       Fluttertoast.showToast(
    //           msg: 'Data Deleted ',
    //           toastLength: Toast.LENGTH_LONG,
    //           gravity: ToastGravity.BOTTOM,
    //           timeInSecForIosWeb: 1,
    //           backgroundColor: Colors
    //               .blueGrey);
    //     });
    //   }}
    //
    //


  }
