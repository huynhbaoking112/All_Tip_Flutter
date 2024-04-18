import 'dart:typed_data';

import 'package:flutter/material.dart';

class ScreenTwo extends StatelessWidget {

  final Uint8List imageData; 

  const ScreenTwo({super.key, required this.imageData});


  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: Container(
        child: Center(
          child:   Container(
            height: size,
            width: size,
            child: Image.memory(imageData, fit: BoxFit.cover,),
          ),
        ),
      ),
    );
  }
}