import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  static const bodyLargeFontSize = 25.0;
  static const bodyMediumFontSize = 20.0;
  static const overlineFontSize = 15.0;
  static TextStyle bodyLarge() {
    return GoogleFonts.roboto(
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
        fontSize: bodyLargeFontSize,
      ),
    );
  }

  static TextStyle bodyMedium() {
    return GoogleFonts.roboto(
      textStyle: const TextStyle(
        fontWeight: FontWeight.normal,
        overflow: TextOverflow.ellipsis,
        fontSize: bodyMediumFontSize,        
      ),
    );
  }

  static TextStyle bodySmall() {
    return GoogleFonts.ebGaramond(
      textStyle: const TextStyle(
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  static TextStyle labelSmall() {
    return GoogleFonts.aBeeZee(
      textStyle: const TextStyle(
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.normal,
        fontSize: overlineFontSize,
      ),
    );
  }
}
