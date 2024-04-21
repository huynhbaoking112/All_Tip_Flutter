import 'package:flutter/material.dart';
import 'package:page_route_builder/pages/second.dart';
import 'package:page_route_builder/utils/transition.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ElevatedButton(child: Text("nextPae"), onPressed: (){


            //Thực hiện chuyển trang không Animation
            // Navigator.push(context, MaterialPageRoute(builder: (ct) => SecondPage(),));


            //Thực  hiện chuyển hướng có animation
            Navigator.push(context, ScaleTransitionRoute(myWidget: SecondPage())
            );



          },),
        ),
      ),
    );
  }
}