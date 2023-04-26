import 'package:flutter/material.dart';

class SlideInRoute extends PageRouteBuilder {
  final Widget child;

  SlideInRoute({required this.child})
      : super(
          transitionDuration: const Duration(milliseconds: 150),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
