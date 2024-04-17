import 'package:fancy_page_wave_transition_animation/pages/screen_2.dart';
import 'package:flutter/material.dart';

class TransitionPage extends StatefulWidget {
  const TransitionPage({super.key});

  @override
  State<TransitionPage> createState() => _TransitionPageState();
}
// Widget trang tiếp theo 
//required 


//Thời gian thực hiện
//default = 1500

//Mức độ đường tròn 
//default =10


//Tọa độ lan đầu
//default = (0.95, 0.9)

class _TransitionPageState extends State<TransitionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return TweenAnimationBuilder(
        tween: Tween(begin: 0.0, end: 1),
        duration: Duration(milliseconds: 1000),//----
        child: ScreenTwo(),//---
        builder: (context, value, child) {
          return ShaderMask(shaderCallback: (rect) {
            return RadialGradient(
                radius: value*10, //--- 
                colors: [Colors.white, Colors.white, Colors.transparent, Colors.transparent],
                stops: [0.0, 0.3, 0.6, 1],
                center: FractionalOffset(0.95, 0.9)//---
            ).createShader(rect);
          }, child: child,);
        },);
        },
      ),
    );
  }
}
