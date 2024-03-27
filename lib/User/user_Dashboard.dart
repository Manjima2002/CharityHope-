import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'User_Home_page.dart';
import 'User_view_cart.dart';
import 'User_view_foodbookings.dart';
import 'View_Cart_User_Original_file.dart';

class user_Dashboard extends StatefulWidget {
  const user_Dashboard({Key? key}) : super(key: key);

  @override
  State<user_Dashboard> createState() => _user_DashboardState();
}

class _user_DashboardState extends State<user_Dashboard> {
  int currentIndex=0;

  final List Screens =[

    User_homepage(),
    Viewcart_User(),
    User_view_food_booking(),
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
                icon:Icon(Icons.shopping_cart),
                label:'Cart',
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
