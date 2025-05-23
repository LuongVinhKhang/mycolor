import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  var kTextStyleWithFont = GoogleFonts.montserrat();

  var kTextStyleFourteenWithThemeColor = GoogleFonts.montserrat(
      fontSize: 14, color: AppColors().kPrimaryTextColor);

  var kTextStyleTwelveWithGreyColor = GoogleFonts.montserrat(
      fontSize: 12, color: AppColors().kSecondaryTextColor);
}
