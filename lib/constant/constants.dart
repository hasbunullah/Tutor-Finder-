import 'package:flutter/material.dart';
import 'package:tutor_finder/services/hexcolor.dart';

class Constants {
  // Colors
  static final Color primaryColor = HexColor('#77D86B');
  static final Color secondaryColor = HexColor('#F4E5C4');
  static final Color introScreenColor = HexColor('#628E9B');
  static final Color loginSignupScreenColor = HexColor('#EDF6F9');
  static final Color landingScreenColor = HexColor('#F4E5C4');
  static final Color imageBorderColor = HexColor('#FFBD59');
  static final Color blockButtonBackground = HexColor('#EB4335');
  static final Color chatButtonBackground = HexColor('#77D86B');
  static final Color shareButtonBackground = HexColor('#628E9B');
  static const Color listCardBackground = Colors.white;
  static final Color senderColor = HexColor('#77D86B');
  static final Color recieverColor = HexColor('#FFBD59');
  static final Color sendingInput = HexColor('#F4E5C4');
  static final Color editButtonBackground = HexColor('#C4C4C4');
  // Sizes and Spacings
  static const double defaultSpacing = 20.0;
  static const double defaultSpacingV = 20.0;
  static const double bordersSize = 1;

  // Text Colors
  static final Color headingTextColor = HexColor('#77D86B');
  static final Color hintColor = HexColor('#707070');
  static final Color forgotPasswordColor = HexColor('#FF0000');
  static const Color bodyTextColor = Colors.black;
  static final Color bottomNavigationColor = HexColor('#F1E8D4');

  // Urls
  static const String apiBaseUrl = 'https://wethere.histudio.co/api/v1';
  static const String backendBaseUrl = 'https://wethere.histudio.co';

  // Shadows

  // Text Styles
  static final TextStyle mainHeadingWithColor = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Constants.headingTextColor,
  );
  static final TextStyle listAlphabitAvtive = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Constants.headingTextColor,
  );
  static const TextStyle mainHeading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static final TextStyle hintText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Constants.hintColor,
  );
  static final TextStyle hintTextLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Constants.hintColor,
  );
  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    color: Constants.bodyTextColor,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle bodyTextBold = TextStyle(
    fontSize: 15,
    color: Constants.bodyTextColor,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle smallLink = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Constants.bodyTextColor,
  );

  static final TextStyle smallText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Constants.hintColor,
  );
  static final TextStyle colorLinkStyle = TextStyle(
    fontSize: 12,
    color: Constants.forgotPasswordColor,
    fontWeight: FontWeight.w500,
  );

  // Sized Boxes
  static Widget vSpace([double size = 1]) {
    return SizedBox(
      height: Constants.defaultSpacingV * size,
    );
  }

  static Widget hSpace([double size = 1]) {
    return SizedBox(
      width: Constants.defaultSpacing * size,
    );
  }
}
