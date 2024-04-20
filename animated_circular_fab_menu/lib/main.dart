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
  late Animation<double> animation;
  late AnimationController animationController;

  _currentTime() {
    return "${DateTime.now().hour} : ${(DateTime.now().minute).toString().padLeft(2,'0')}";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animationController.addListener(() {


      if(animationController.isCompleted){
        animationController.reverse();
      }else if(animationController.isDismissed){
        animationController.forward();
      }

      setState(() {
        
      });
    });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    animation = CurvedAnimation(
        parent: animationController, curve: Curves.easeInOut);
    animation = Tween(begin: -0.5, end: 0.5).animate(animation);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Center(
            child: Text(
          'Clock',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        )),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.deepOrange,
        child: Center(
          child: Column(
            children: [
              Material(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                elevation: 10.0,
                color: Colors.brown.shade900,
                child: Container(
                  width: 320,
                  height: 320,
                  child: Center(
                      child: Text(
                    _currentTime(),
                    style: TextStyle(
                        fontSize: 70,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),

              //Clock
              Transform(
                alignment: FractionalOffset(0.5, 0.1),
                transform: Matrix4.rotationZ(animation.value),
                child: Container(
                  child: Image.asset(
                    "images/pandulum.png",
                    height: 250,
                    width: 100,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
