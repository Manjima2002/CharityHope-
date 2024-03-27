import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Admin_Donation_Display.dart';
import 'Admin_Home_page.dart';
import 'Admin_cancel_foodbookings.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIndex=0;

  final List Screens =[

  Admin_Home_Page(),
  Admin_donation_Display_Page(),
  Admin_cancel_food_booking(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type:BottomNavigationBarType.fixed,
          backgroundColor:Colors.white,elevation:4,
          selectedItemColor:Colors.black,
          unselectedItemColor:Colors.grey,
          selectedFontSize:15,unselectedFontSize:13,
          currentIndex:currentIndex,
          onTap:(Index)=>setState(()=>
          currentIndex=Index),
          items: [
            BottomNavigationBarItem(
                icon:Icon(Icons.home),
                label:'Home',
                backgroundColor:Colors.purpleAccent),

            BottomNavigationBarItem(
                icon:Icon(Icons.monetization_on_outlined),
                label:'Donation',
                backgroundColor:Colors.purpleAccent),

            BottomNavigationBarItem(
                icon:Icon(Icons.fastfood),
                label:'food_booking',
                backgroundColor:Colors.purpleAccent),




          ]
      ),
    );
  }
}
