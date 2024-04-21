import 'package:flutter/material.dart';

class ScaleTransitionRoute extends PageRouteBuilder {
  final Widget myWidget;

  ScaleTransitionRoute({required this.myWidget})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            return myWidget;
          },
          transitionDuration: Duration(seconds: 1),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            animation = CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
            // Trả về một widget chứa ScaleTransition
            return AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return ScaleTransition(
                  scale: animation,
                  alignment: Alignment.center,
                  child: child,
                );
              },
              child: child,
            );
          },
        );
}