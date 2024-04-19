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
  late PageController pageController;
  final double fraction = 0.5;
  double pageCurrent = 2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: 2, viewportFraction: fraction);
    pageController.addListener(() {
      setState(() {
        pageCurrent = pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black54,
      body: Container(
        child: Center(
          child: AspectRatio(
            aspectRatio: 1,
            child: PageView.builder(
              controller: pageController,
              physics: BouncingScrollPhysics(),
              itemCount: 12,
              itemBuilder: (context, index) {
                double diff = index - pageCurrent;
                // ra am thi no o ben trai
                // ra duong thi no o ben phai
                // ra 0 thi trung;
            
                final Matrix4 pvMatrix = Matrix4.identity()
                  ..setEntry(3, 3, 0.9) // Increasing Scale by 90%
                  ..setEntry(1, 1, fraction) // Changing Scale Along Y Axis
                  ..setEntry(3, 0, 0.004 * -diff);
            
                return Transform(
                  transform: pvMatrix,
                  alignment: Alignment.center, 
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                Image.asset('images/image_${index + 1}.jpg').image,
                            fit: BoxFit.fill)),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
