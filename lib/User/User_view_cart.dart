import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hope/main.dart';

import 'package:http/http.dart' as http;



//Creating a class user to store the data;
class cart_model{
  // final String id;
  final String craftid;
  final String price;
  final String qty;
  final String image;


  cart_model({
    // required this.id
    required this.craftid,
    required this.price,
    required this.qty,
    required this.image,

  });
}

class User_view_cart_item extends StatefulWidget {
  @override
  _User_view_cart_itemState createState() => _User_view_cart_itemState();
}

class _User_view_cart_itemState extends State<User_view_cart_item> {
//Applying get request.

  Future<List<cart_model>> getRequest() async {
    //replace your restFull API here.
    String url = "http://$ip_address/charity_hope/user/user_view_cart.php?uid="+uid;

    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    List<cart_model> users = [];

    for (var singleUser in responseData) {

      cart_model user = cart_model(
        //id:  singleUser["id"].toString(),
        craftid: singleUser["craft_id"].toString(),
        price: singleUser["price"].toString(),
        qty: singleUser["qty"].toString(),
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
              "My cart item",
            ),
            backgroundColor: Colors.purpleAccent,
          ),
          body: Container(
            padding: EdgeInsets.all(16.0),

            child: Column(
                children: [
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
                                        snapshot.data[index].craftid,
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
                           ],
                        ),
                  );
                }
              },
            ),
          ),
                  SizedBox(
                    width: 180,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purpleAccent.shade100,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: (){
                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>craft_Image()));
                      }, child: Text("Buy"),),
                  ),
      ],
    ),
    ),
    )
    );
  }

  Future<void> delrecord(String id) async {
    String url =
        "http://$ip_address/charity_hope/user/user_cart_delete.php";
    var res = await http.post(Uri.parse(url), body: {
      "id": id,
    });
    var resoponse = jsonDecode(res.body);
    if (resoponse["success"] == "true") {
      setState(() {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>User_view_cart_item()));
        Fluttertoast.showToast(
            msg: 'cart Cancelled ',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors
                .blueGrey);
      });
    }}




}
