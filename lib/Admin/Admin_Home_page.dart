import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'Admin_Add Event..dart';
import 'Admin_Donation_Display.dart';
import 'Admin_Edit event_Display.dart';
import 'Admin_Edit_craft_display_page.dart';
import 'Admin_Event_Edit_Page.dart';
import 'Admin_add_craft.dart';
import 'Admin_cancel_foodbookings.dart';
import 'Admin_edit_craft_with_img.dart';
import 'Admin_login page.dart';
import 'Admin_remove_craft.dart';

class Admin_Home_Page extends StatefulWidget {
  const Admin_Home_Page({Key? key}) : super(key: key);

  @override
  _Admin_Home_PageState createState() => _Admin_Home_PageState();
}

class _Admin_Home_PageState extends State<Admin_Home_Page> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home Page"),
        backgroundColor: Colors.purpleAccent,
      ),

      //drawer:Drawer(),
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
              accountEmail: Text("Admin"),
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
                  MaterialPageRoute(builder: (context) => Add_event()));
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Edit Events'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Admin_Edit_event_Display_Page()));
            },
          ),
          ListTile(
            leading: Icon(Icons.cancel),
            title: Text('Cancel food bookings'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Admin_cancel_food_booking()));
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Add craft item'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => craft_Image()));
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Edit craft item'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Admin_Edit_craft_Display_page()));
            },
          ),
          ListTile(
            leading: Icon(Icons.remove_circle),
            title: Text('Remove craft item'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Admin_remove_craft_item()));
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Log out'),
            onTap: () async {
              final SharedPreferences sharedpreferences =
                  await SharedPreferences.getInstance();
              sharedpreferences.remove('admin_id');
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Admin_loginpage()));
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
      Navigator.push(context,MaterialPageRoute(builder: (context)=>Admin_Edit_event_Display_Page()));
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
     Navigator.push(context,MaterialPageRoute(builder: (context)=>Admin_donation_Display_Page()));
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
    Navigator.push(context,MaterialPageRoute(builder: (context)=>Admin_cancel_food_booking()));
    }, child:Text("View Food donation"),),
      ElevatedButton(onPressed: () {
        Navigator.push(context,MaterialPageRoute(builder: (context)=>Admin_Edit_craft_Display_page()));
      },child: Text("View Craft Shop")),
          ],
        ),
    ],
        ),
      ),

           // children:[


    );
  }

  data_send_with_uid_screen() {}
}
