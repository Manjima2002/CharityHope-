import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hope/main.dart';

import 'package:http/http.dart' as http;



//Creating a class user to store the data;
class craft_model{
  // final String id;
  final String id;
  final String name;
  final String craftid;
  final String price;
  final String description;
  final String image;


  craft_model({
    // required this.id,
    required this.id,
    required this.name,
    required this.craftid,
    required this.price,
    required this.description,
    required this.image,

  });
}

class Admin_remove_craft_item extends StatefulWidget {
  @override
  _Admin_remove_craft_itemState createState() => _Admin_remove_craft_itemState();
}

class _Admin_remove_craft_itemState extends State<Admin_remove_craft_item> {
//Applying get request.

  Future<List<craft_model>> getRequest() async {
    //replace your restFull API here.
    String url = "http://$ip_address/charity_hope/admin/admin_craft_display.php";

    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    List<craft_model> users = [];

    for (var singleUser in responseData) {

      craft_model user = craft_model(
        //id:  singleUser["id"].toString(),
        id: singleUser["id"].toString(),
        name: singleUser["name"].toString(),
        craftid: singleUser["craft_id"].toString(),
        price: singleUser["price"].toString(),
        description: singleUser["description"].toString(),
        image: singleUser["image"].toString(),

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
              "Remove cart item",
            ),
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
                            color: Colors.red.shade900,
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
                                      leading: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Colors.red.shade900),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(snapshot.data[index].image),
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        snapshot.data[index].name,
                                      ),


                                      subtitle: Text(
                                        snapshot.data[index].craftid,
                                      ),
                                      trailing: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                               delrecord(snapshot.data[index].id);


                                            });


                                          },
                                          child: Icon(Icons.delete,color: Colors.red,)),


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
          "http://$ip_address/charity_hope/admin/admin_craft_delete.php";
      var res = await http.post(Uri.parse(url), body: {
        "id": id,
      });
      var resoponse = jsonDecode(res.body);
      if (resoponse["success"] == "true") {
        setState(() {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>Admin_remove_craft_item()));
          Fluttertoast.showToast(
              msg: 'craft Cancelled ',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors
                  .blueGrey);
        });
      }}




  }
