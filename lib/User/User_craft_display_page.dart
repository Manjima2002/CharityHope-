import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hope/main.dart';

import 'package:http/http.dart' as http;

import '../Admin/Admin_add_craft.dart';
import 'User_Home_page.dart';
import 'User_add_cart.dart';



//Creating a class user to store the data;
class craft_model_Edit_display{
  // final String id;
  final String id;
  final String name;
  final String craftid;
  final String price;
  final String description;
  final String image;


  craft_model_Edit_display({
    // required this.id,
    required this.id,
    required this.name,
    required this.craftid,
    required this.price,
    required this.description,
    required this.image,

  });
}

class User_craft_Display_page extends StatefulWidget {
  @override
  _User_craft_Display_pageState createState() => _User_craft_Display_pageState();
}

class _User_craft_Display_pageState extends State<User_craft_Display_page> {
//Applying get request.

  Future<List<craft_model_Edit_display>> getRequest() async {
    //replace your restFull API here.
    String url = "http://$ip_address/charity_hope/user/user_craft_display.php";

    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    List<craft_model_Edit_display> users = [];

    for (var singleUser in responseData) {

      craft_model_Edit_display user = craft_model_Edit_display(
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
              "View craft item",
            ),
            backgroundColor: Colors.purpleAccent,
          ),
          body:
          Container(
            padding: EdgeInsets.all(16.0),

            child: Column(
              children: [
              //  Text("hello"),

                Flexible(
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
                                  color: Colors.purpleAccent,
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
                                                border: Border.all(
                                                    color: Colors.black),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      snapshot.data[index].image),
                                                ),
                                              ),
                                            ),
                                            title: Text(
                                              snapshot.data[index].name,
                                            ),
                                            subtitle: Text(
                                              snapshot.data[index].price,
                                            ),
                                            trailing: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              User_Craft_detail_page(price:   snapshot.data[index].price, image: snapshot.data[index].image, craftid:snapshot.data[index].craftid,)));
                                                },
                                                child: Icon(Icons.arrow_forward,
                                                  color: Colors.black,)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                        );
                      }
                    },
                  ),
                ),
                //
                // SizedBox(
                //   width: 280,
                //   height: 60,
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       primary: Colors.purpleAccent.shade100,
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(30)),
                //     ),
                //     onPressed: (){
                //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>User_homepage()));
                //     }, child: Text("Add craft item"),),
                // ),
              ],
            ),
          ),
        )
    );
  }






  }