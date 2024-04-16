import 'package:fancy_page_wave_transition_animation/pages/screen_2.dart';
import 'package:fancy_page_wave_transition_animation/pages/transition_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Container(
        child: Stack(
          children: [
            Positioned(
                bottom: 20,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return TransitionPage();
                      },
                      opaque: false
                    ));
                  },
                  child: Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.green),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
