import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hidden_bottom_bar/pages/home_future.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  late bool hiddenBar;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hiddenBar = true;
  }


  @override
  Widget build(BuildContext context) {
    var sizeWidth = MediaQuery.of(context).size.width;
    var sizeHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
          height: sizeHeight,
          width: sizeWidth,
          child: GestureDetector(
            onPanEnd: (details) {
              if(details.velocity.pixelsPerSecond.dy <- 100){
                setState(() {
                  hiddenBar = false;
                });
              }else if(details.velocity.pixelsPerSecond.dy >100){
                setState(() {
                  hiddenBar = true;
                });
              }
            },
            child: Stack(
              children: [
            
                // Các tính năng của home
                HomeFuture(),
            
            
            
                // Lớp nền 
                AnimatedOpacity(
                  duration: Duration(milliseconds: 500),
                  opacity: hiddenBar ? 0 : 1,
                  child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), child: Container(
                    color: Colors.black.withOpacity(0.2),
                  ),),
                ),
            
            
                // Lớp bar
                AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  left: 0,
                  bottom: hiddenBar?-sizeHeight/3:0,
                  child: HiddenBar())
            
              ],
            ),
          )),
    );
  }
}



class HiddenBar extends StatefulWidget {

  const HiddenBar({super.key});

  @override
  State<HiddenBar> createState() => _HiddenBarState();
}

class _HiddenBarState extends State<HiddenBar> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height/3 + 60,
      width: size.width,
      color: Colors.orange,
    );
  }
}