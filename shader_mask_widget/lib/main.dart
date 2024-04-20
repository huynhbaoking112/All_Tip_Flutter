import 'package:flutter/material.dart';

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
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1500));

    oneAnimation = ColorTween(begin: Colors.grey, end: Colors.grey.shade100)
        .animate(_controller);
    twoAnimation = ColorTween(begin: Colors.grey.shade100, end: Colors.grey)
        .animate(_controller);

    _controller.addListener(() {

      if(_controller.isCompleted){
        _controller.reverse();
      }else if(_controller.isDismissed){
        _controller.forward();
      }

      setState(() {
        
      });
    });

    _controller.forward();
    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                        colors: [oneAnimation.value, twoAnimation.value])
                    .createShader(rect);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 10,
                    decoration: BoxDecoration(color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 10,
                    decoration: BoxDecoration(color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 50,
                    height: 10,
                    decoration: BoxDecoration(color: Colors.white),
                  ),
                ],
              )),
        ),
      ),
    ));
  }
}
