import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_filter/pages/screen_two.dart';
import 'package:image_filter/utils/matrix.dart';
import 'dart:ui' as ui;


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late List<List<double>> allColor = allType;
  PageController _pageController = PageController(initialPage: 0);
  GlobalKey _globalKey  = GlobalKey();


 void cutImage() async {
   RenderObject? renderObject = _globalKey.currentContext!.findRenderObject();
  if (renderObject is RenderRepaintBoundary) {
    RenderRepaintBoundary repaintBoundary = renderObject;
    ui.Image boxImage = await repaintBoundary.toImage(pixelRatio: 1);
    ByteData? byteData = await boxImage.toByteData(format: ui.ImageByteFormat.png);
    Uint8List uint8list = byteData!.buffer.asUint8List();
    Navigator.of(_globalKey.currentContext!).push(MaterialPageRoute(
      builder: (context) => ScreenTwo(
        imageData: uint8list,
      ),
    ));
}}

  @override
  Widget build(BuildContext context) {
    final sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter Colors"),
        backgroundColor: Colors.grey,
        actions: [
          GestureDetector(
            onTap: cutImage,
            child: Icon(Icons.check, color: Colors.greenAccent, size: 30,))
        ],
      ),
      body: Container(
        child: Stack(
          children: [
             Center(
            child: RepaintBoundary(
              key: _globalKey ,
              child: Container(
                width: sizeWidth,
                height: sizeWidth,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: allColor.length,
                  itemBuilder: (context, index) {
                  return ColorFiltered(
                  colorFilter: ColorFilter.matrix(allColor[index]),
                  child: Image.asset("assets/king.jpg", fit: BoxFit.cover,)
                  );
                },)
              ),
            ),
          ),

          Positioned(
            bottom: 20,
            left: 0,
            child: Container(
              height: 90,
              width: sizeWidth,
              child: ListView.builder(        
                scrollDirection: Axis.horizontal,
                itemCount: allColor.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: (){
                   setState(() {
                      _pageController.jumpToPage(index);
                   });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: index == _pageController.page? Colors.red: Colors.grey)
                    ),
                    child: ColorFiltered(
                    colorFilter: ColorFilter.matrix(allColor[index]),
                    child: Image.asset("assets/king.jpg", fit: BoxFit.cover,)
                    ),
                  ),
                ),)
            )
            )
          ],
        ),
      ),
    );
  }
}
