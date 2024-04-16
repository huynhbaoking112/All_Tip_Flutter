import 'package:fancy_page_wave_transition_animation/pages/screen_2.dart';
import 'package:flutter/material.dart';

class TransitionPage extends StatefulWidget {
  const TransitionPage({super.key});

  @override
  State<TransitionPage> createState() => _TransitionPageState();
}

class _TransitionPageState extends State<TransitionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return TweenAnimationBuilder(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: Duration(milliseconds: 1500),
        child: ScreenTwo(),
        builder: (context, value, child) {
          return ShaderMask(shaderCallback: (rect) {
            return RadialGradient(
                radius: value*5,
                colors: [Colors.white, Colors.white, Colors.transparent, Colors.transparent],
                stops: [0.0, 0.55, 0.6, 1],
                center: FractionalOffset(0.95, 0.9)
            ).createShader(rect);
          }, child: child,);
        },);
        },
      ),
    );
  }
}
