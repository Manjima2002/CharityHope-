import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hope/User/User_Home_page.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';
import 'Payment_user.dart';
import 'package:shared_preferences/shared_preferences.dart';



//Creating a class user to store the data;
class Cart_model_display_orderitems {
  final String id;
  final String craft_id;
  final String qty;
  final String cid;
  final String name;
  final String price;
  final String image;
  final String description;





  Cart_model_display_orderitems({
    required this.id,
    required this.name,
    required this.craft_id,
    required this.price,
    required this.cid,
    required this.image,
    required this.description,
    required this.qty,

  });
}

class My_Orders extends StatefulWidget {
  @override
  _My_OrdersState createState() => _My_OrdersState();
}

class _My_OrdersState extends State<My_Orders> {
  num subTotal = 0;

  //Applying get request.
  Future<List<Cart_model_display_orderitems>> getRequest() async {
    //replace your restFull API here.
    // final _sharedPrefs = await SharedPreferences.getInstance();
    // final  ui = _sharedPrefs.getString("hope_userid");

    String url =
    "http://$ip_address/charity_hope/user/Display_order_items.php?uid="+uid!;

    //http://localhost/charity_hope/user/Display_order_items.php?uid=6

    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    List<Cart_model_display_orderitems> users = [];
    for (var singleUser in responseData) {
      Cart_model_display_orderitems user = Cart_model_display_orderitems(

        id: singleUser["id"].toString(),
        name: singleUser["name"].toString(),
        image: singleUser["image"].toString(),
        description: singleUser["description"].toString(),
        craft_id:singleUser["craft_id"].toString(),
        price: singleUser["price"].toString(),
        qty: singleUser["qty"].toString(),
        cid: singleUser["cartid"].toString(),
      );
      //  print("this is craft id"+singleUser["craft_id"]);


      //  craftid_check = singleUser["craft_id"];

      //Adding user to the list.
      users.add(user);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.card_giftcard,
                color: Colors.white,
              )),
        ],
        automaticallyImplyLeading: false,
        backgroundColor:Colors.pink.shade300,
        centerTitle: true,
        title: Text(
          "My orders",
          style: GoogleFonts.prompt(fontSize: 22),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children:[ FutureBuilder(
            future: getRequest(),
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if (snapshot.data == null || snapshot.data == false) {
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
                          "Loading...",
                          style: TextStyle(),
                        ),
                      ],
                    ),
                  ),
                );
              } else {

                return
                  Flexible(
                    child: Column(
                      children: [
                        // Text("hai"),
                        Flexible(
                          child: ListView.builder(
                            // scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (ctx, index) {



                                return
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Column(
                                      children: [
                                        Card(
                                          shadowColor: Colors.red,
                                          elevation: 8,
                                          clipBehavior: Clip.antiAlias,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Container(
                                            // color: Colors.red,
                                            height:
                                            MediaQuery.of(context).size.height / 5,
                                            width: MediaQuery.of(context).size.width,
                                            padding:
                                            EdgeInsets.fromLTRB(10, 15, 50, 15),
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(8.0),
                                                  child: Image.network(
                                                    snapshot.data[index].image,
                                                    height: 100,
                                                    width: 100.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                //    Spacer(),
                                                SizedBox(width: 20,),
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Name : " +
                                                          snapshot
                                                              .data[index].name,
                                                    ),
                                                    Text(
                                                      "Price : " +
                                                          snapshot
                                                              .data[index].price,
                                                    ),


                                                    // ),

                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Remove",
                                                          style: GoogleFonts.aBeeZee(
                                                              color:
                                                              Colors.red.shade900),
                                                        ),
                                                        IconButton(
                                                            onPressed: () {
                                                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>Viewcart_customer()));
                                                              // setState(() {
                                                              //   delrecord(snapshot
                                                              //       .data[index].cid);
                                                              // });
                                                              showDialog(
                                                                  context: context,
                                                                  builder: (_) {
                                                                    return AlertDialog(
                                                                      shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.circular(16),
                                                                      ),
                                                                      title: Text("Remove item",style: TextStyle(color: Colors.pink.shade500),),
                                                                      content: Text(
                                                                          "Are You sure want to remove the product from cart"),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed: () {
                                                                            setState(() {
                                                                              delrecord(snapshot
                                                                                  .data[index].cid);
                                                                            });
                                                                            Navigator.pushReplacement(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                    builder: (context) =>
                                                                                        User_homepage()));
                                                                          },
                                                                          child: Text("ok",style: TextStyle(color: Colors.pink.shade500,)),),
                                                                        TextButton(
                                                                          onPressed: () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child: Text("cancel",style: TextStyle(color: Colors.pink.shade500)),),
                                                                      ],
                                                                    );
                                                                  });
                                                            },
                                                            icon: Icon(Icons.clear,
                                                                size: 20,
                                                                color: Colors
                                                                    .red.shade900)),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  );
                              }),
                        ),





                        SizedBox(height: 20,)
                        ,
                      ],),
                  );
              }
            },
          ),
          ],
        ),
      ),
    );
  }

  Future<void> delrecord(String id) async {
    String url =
        "http://$ip_address/charity_hope/user/cancel_My_orders.php";
    var res = await http.post(Uri.parse(url), body: {
      "id": id,

    });
    var resoponse = jsonDecode(res.body);
    if (resoponse["success"] == "true") {


      print(id);
      // setState(() {
      getRequest();
      // });

    } else {
      print("some issue");
    }
  }






}
