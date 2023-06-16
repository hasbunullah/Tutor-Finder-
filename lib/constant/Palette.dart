import 'package:flutter/material.dart';
class Palette {

  final Color maincolor = Color(0xffD9B56B);
  final Color fontcolor = Color(0xff4F4F4F);
static Color primary = Color(0xc7e9ff);
  static Color secondary = Color(0xa4dbfc);
  static Color deepBlue = Color(0x55b3ed);
  static Color fullBlue = Color(0x18a0f5);


  static const MaterialColor mainColor = const MaterialColor(
    0xffD9B56B, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xffD9B56B ),//10%
      100: const Color(0xffD9B56B),//20%
      200: const Color(0xffD9B56B),//30%
      300: const Color(0xffD9B56B),//40%
      400: const Color(0xffD9B56B),//50%
      500: const Color(0xffD9B56B),//60%
      600: const Color(0xffD9B56B),//70%
      700: const Color(0xffD9B56B),//80%
      800: const Color(0xffD9B56B),//90%
      900: const Color(0xffD9B56B),//100%
    },
  );
}