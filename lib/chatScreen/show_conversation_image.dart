import 'package:flutter/material.dart';
import 'package:tutor_finder/chatScreen/Widgets/theme_helper.dart';

class ShowConversationImage extends StatelessWidget {
  final String message;
  const ShowConversationImage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
          color: Palette.secondary.withOpacity(.20),
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: NetworkImage(message)
          )
      ),
    );
  }
}
