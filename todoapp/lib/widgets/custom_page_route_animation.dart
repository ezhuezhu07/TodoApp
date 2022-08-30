import 'package:flutter/cupertino.dart';

class CustomPageRouteAnimation extends PageRouteBuilder {
  final Widget child;
  CustomPageRouteAnimation({
    required this.child,
  }) : super(
            transitionDuration: const Duration(seconds: 1),
            reverseTransitionDuration: const Duration(seconds: 1),
            pageBuilder: (context, animation, secondaryAnimation) => child);

  @override
  Widget buildTrasitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
        // scale: animation,
        position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
            .animate(animation),
        child: child,
      );
}
