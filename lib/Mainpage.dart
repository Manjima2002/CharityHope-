import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Admin/Admin_splashscreen.dart';
import 'User/user_splashscreen.dart';

class hope extends StatefulWidget {
  const hope({Key? key}) : super(key: key);

  @override
  State<hope> createState() => _hopeState();
}

class _hopeState extends State<hope> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      //     appBar: AppBar(
      // title: Text("Hope",
      // ),
//       centerTitle: true,
//
// ),

    body: Center(
      child: (
      Column(
        children: [ SizedBox(height: 200,),

          Image.asset('assets/images/hope.jpg',height: 100,width: 300,),
          SizedBox(height: 50,),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade500,
              padding: EdgeInsets.only(
                  left: 70, right: 70, top: 15, bottom: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
      // style: ElevatedButton.styleFrom(
      //   primary: Colors.pinkAccent.shade100,
      //   // side: BorderSide(color: Colors.yellow, width: 5),
      //   textStyle: const TextStyle(
      //       color: Colors.black, fontSize: 15, fontStyle: FontStyle.normal),
      //   shape: BeveledRectangleBorder(
      //       borderRadius: BorderRadius.all(Radius.circular(10),)),
      // ),


            onPressed: ()
              {
                Navigator.push(context,MaterialPageRoute(builder: (context)=>Admin_Splashscreen()));
              },
              child: Text("Admin"),
          ),
SizedBox(height: 15,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade500,
              padding: EdgeInsets.only(
                  left: 80, right: 80, top: 15, bottom: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),

    // style: ElevatedButton.styleFrom(
    // primary: Colors.pinkAccent.shade100,
    // // side: BorderSide(color: Colors.yellow, width: 5),
    // textStyle: const TextStyle(
    // color: Colors.black38, fontSize:15, fontStyle: FontStyle.normal),
    // shape: BeveledRectangleBorder(
    // borderRadius: BorderRadius.all(Radius.circular(10))),
    // ),

            onPressed: ()
          {
            Navigator.push(context,MaterialPageRoute(builder: (context)=>User_splashscreen()));
          },
            child: Text("User"),

          ),
        ],
      )
      ),
      )
    );

  }
}
