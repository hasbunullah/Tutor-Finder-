import 'package:flutter/material.dart';
enum TransitionType {
  defaultTransition,
  none,
  size,
  scale,
  fade,
  rotate,
  slideDown,
  slideUp,
  slideLeft,
  slideRight
}

class Transitions<T> extends PageRouteBuilder<T> {
  final TransitionType? transitionType;
  final Curve curve;
  final Curve reverseCurve;
  final Duration duration;
  final Widget? widget;

  Transitions(
      {this.transitionType,
        this.curve = Curves.elasticInOut,
        this.reverseCurve = Curves.easeOut,
        this.duration = const Duration(milliseconds: 500),
        this.widget})
      : super(
    transitionDuration: duration,
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return widget!;
    },
    transitionsBuilder: (BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child) {

      switch (transitionType) {
        case TransitionType.none:
          return child;
        case TransitionType.size:
          return Align(
            child: SizeTransition(
              sizeFactor:
              animation,
              child: child,
            ),
          );
        case TransitionType.scale:
          return ScaleTransition(
            scale: animation,
            alignment: Alignment.topRight,
            child: child,
          );
        case TransitionType.fade:
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        case TransitionType.rotate:
          return RotationTransition(
            alignment: Alignment.center,
            turns: animation,
            child: ScaleTransition(
              alignment: Alignment.center,
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          );
        case TransitionType.slideDown:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, -1.0),
              end: const Offset(0.0, 0.0),
            ).animate(animation),
            child: child,
          );
        case TransitionType.slideUp:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: const Offset(0.0, 0.0),
            ).animate(animation),
            child: child,
          );
        case TransitionType.slideLeft:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: const Offset(0.0, 0.0),
            ).animate(animation),
            child: child,
          );
        case TransitionType.slideRight:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: const Offset(0.0, 0.0),
            ).animate(animation),
            child: child,
          );

        default:
          return FadeTransition(opacity: animation, child: child);
      }
    },
  );
}
