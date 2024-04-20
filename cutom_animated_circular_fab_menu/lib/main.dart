// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_literals_to_create_immutables

// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late Animation oneAnimation;
  late Animation twoAnimation;
  late Animation threeAnimation;
  late AnimationController animationController;

  late Animation spinAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    //oneAnimation
    oneAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.4), weight: 75),
      TweenSequenceItem(tween: Tween(begin: 1.4, end: 1.0), weight: 25)
    ]).animate(animationController);

    //twoAnimation
    twoAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.5), weight: 65),
      TweenSequenceItem(tween: Tween(begin: 1.5, end: 1.0), weight: 35)
    ]).animate(animationController);

    //threeAnimation
    threeAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.2), weight: 70),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 30)
    ]).animate(animationController);

    spinAnimation = Tween(begin: pi, end: 0.0).animate(animationController);

    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                bottom: 15,
                right: 15,
                child: Stack(
                  children: [
                    //Button 1
                    Transform.translate(
                        offset:
                            Offset.fromDirection(pi, oneAnimation.value * 100),
                        child: Transform(
                            transform: Matrix4.rotationZ(spinAnimation.value)..scale(oneAnimation.value ),
                            child: CutomButton(
                              color: Colors.green,
                              height: 60,
                              width: 60,
                              icon: Icon(Icons.home),
                              onPressed: () {},
                            ))),

                    //Button 2
                    Transform.translate(
                        offset: Offset.fromDirection(
                            pi + 45 * pi / 180, twoAnimation.value * 100),
                        child: Transform(
                            transform: Matrix4.rotationZ(spinAnimation.value)..scale(twoAnimation.value),
                            child: CutomButton(
                              color: Colors.blue,
                              height: 60,
                              width: 60,
                              icon: Icon(Icons.person),
                              onPressed: () {},
                            ))),

                    //Button3
                    Transform.translate(
                        offset: Offset.fromDirection(
                            pi + 90 * pi / 180, threeAnimation.value * 100),
                        child: Transform(
                            transform: Matrix4.rotationZ(spinAnimation.value)..scale(threeAnimation.value),
                            child: CutomButton(
                              color: Colors.orange,
                              height: 60,
                              width: 60,
                              icon: Icon(Icons.add),
                              onPressed: () {},
                            ))),

                    //Button Menu
                    Transform.translate(
                        offset: Offset.fromDirection(pi, 0),
                        child: CutomButton(
                          color: Colors.red,
                          height: 70,
                          width: 70,
                          icon: Icon(Icons.menu),
                          onPressed: () {
                            if (animationController.isCompleted) {
                              animationController.reverse();
                            } else {
                              animationController.forward();
                            }
                          },
                        ))
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class CutomButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Function onPressed;
  final Icon icon;

  const CutomButton({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width,
      width: height,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: IconButton(
        icon: icon,
        color: Colors.white,
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}
