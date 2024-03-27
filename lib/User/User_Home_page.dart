import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hope/User/user_Donation_Display.dart';
import 'package:hope/User/user_cancel_foodbookings.dart';
import 'package:hope/User/user_foodbooking.dart';
import 'package:hope/User/user_login.dart';
import 'package:hope/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'My_Orders.dart';
import 'User_Add Event..dart';
import 'User_craft_display_page.dart';
import 'User_remove_craft.dart';
import 'User_remove_event_Display.dart';
import 'User_view event_Display.dart';
import 'User_view_cart.dart';
import 'User_view_foodbookings.dart';
import 'View_Cart_User_Original_file.dart';

class User_homepage extends StatefulWidget {
  const User_homepage({Key? key}) : super(key: key);

  @override
  State<User_homepage> createState() => _User_homepageState();
}

class _User_homepageState extends State<User_homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle:true,
        title: Text(uid,
          style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.purpleAccent,
      elevation: 0,
    ),
      drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.all(0),
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.purpleAccent),
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.purpleAccent),
                  accountName: Text(
                    "john",
                    style: TextStyle(color: Colors.purpleAccent),
                  ),
                  accountEmail: Text("User"),
                  currentAccountPictureSize: Size.square(50),
                  currentAccountPicture:
                  CircleAvatar(
                    backgroundColor: Colors.purpleAccent,
                    child:
                    Image.asset('assets/images/hope.jpg',height: 100,width: 100,),
                    // Text("A"),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.calendar_today_rounded),
                title: Text('Add Events'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => user_Add_event()));
                },
              ),
              ListTile(
                leading: Icon(Icons.view_compact_outlined),
                title: Text('View Events'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>User_view_event_Display_Page ()));
                },
              ),
              ListTile(
                leading: Icon(Icons.remove),
                title: Text('Cancel Event'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>User_remove_event_Display_Page()));
                },
              ),
              ListTile(
                leading: Icon(Icons.food_bank_outlined),
                title: Text(' foodbooking'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>user_food_booking()));
                },
              ),
              // ListTile(
              //   leading: Icon(Icons.shop),
              //   title: Text('View cart'),
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) =>()));
              //   },
              // ),
              ListTile(
                leading: Icon(Icons.cancel_outlined),
                title: Text('Cancel foodbooking'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => user_cancel_food_booking()));
                },
              ),
              ListTile(
                leading: Icon(Icons.book),
                title: Text('View foodbooking'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>User_view_food_booking()));
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text('View My Cart '),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Viewcart_User()));
                },
               ),

              ListTile(
                leading: Icon(Icons.cancel),
                title: Text('Cancel My order'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => My_Orders()));
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Log out'),
                onTap: () async {
                  final SharedPreferences sharedpreferences =
                  await SharedPreferences.getInstance();
                  sharedpreferences.remove('user_id');
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => User_loginpage()));
                },
              ),
            ],
          )),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/event.jpg',
                        height: 200,
                        width: 150,
                      ),
                    ),TextButton(onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>User_view_event_Display_Page()));
                    }, child:Text("View Event"),),

                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/donation.jpg',
                        height: 200,
                        width: 150,
                      ),
                    ),
                    TextButton(onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>User_donation_Display_Page()));
                    }, child:Text("View Donations"),),
                  ],
                ),
              ],
            ),
            // Row(
            // children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/food donation.jpg',
                    height: 200,
                    width: 150,
                  ),
                ),
                TextButton(onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>User_view_food_booking()));
                }, child:Text("View Food donation"),),
                SizedBox(height: 30,),
                ElevatedButton(onPressed: () {
                   Navigator.push(context,MaterialPageRoute(builder: (context)=>User_craft_Display_page()));
                },child: Text("View Craft Shop")),
                // SizedBox(height: 30,),
                // ElevatedButton(onPressed: () {
                //   Navigator.push(context,MaterialPageRoute(builder: (context)=>()));
                // },child: Text("View Cart")),

              ],
            ),
          ],
        ),

        ),
    );
  }

  data_send_with_uid_screen() {}
}

