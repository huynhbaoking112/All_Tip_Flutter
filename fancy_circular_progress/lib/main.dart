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

class _HomePageState extends State<HomePage> {
  double size = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Progress Indicator'),
        ),
        body: Center(
          child: Container(
              height: size,
              width: size,
              child: TweenAnimationBuilder(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(seconds: 4),
                  builder: (context, value, child) {
                    int percent = (value * 100).round();
                    return Stack(
                      children: [
                        Center(
                          child: ShaderMask(
                            shaderCallback: (rect) {
                              return SweepGradient(
                                colors: [Colors.green, Colors.transparent],
                                stops: [value, value],
                                center: Alignment.center,
                                startAngle: 0,
                                endAngle: 3.14 * 2,
                              ).createShader(rect);
                            },
                            child: Container(
                              height: size,
                              width: size,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image:
                                          Image.asset('assets/radial_scale.png')
                                              .image)),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            width: size - 40,
                            height: size - 40,
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: Center(
                                child: Text(
                              percent.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )),
                          ),
                        )
                      ],
                    );
                  })),
        ));
  }
}
