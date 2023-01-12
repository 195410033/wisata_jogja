import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color orangeColor = Color(0xffF68414);
const Color blackColor = Color(0xff000000);
const Color whiteColor = Color(0xffFFFFFF);
const Color greyColor = Color(0xff82868E);
const Color subtitleColor = Color(0xff504F5E);
const Color tileColor = Color(0xffF3F1F1);
const Color transparantColor = Colors.transparent;

List<BoxShadow> kBoxShadows = [
  BoxShadow(
      color: Colors.black.withOpacity(0.19),
      offset: const Offset(0.5, 4),
      spreadRadius: 1,
      blurRadius: 8),
  BoxShadow(
      color: Colors.white.withOpacity(0.4),
      offset: const Offset(-3, -4),
      spreadRadius: -2,
      blurRadius: 20),
];

double edge = 24;
double defaultMargin = 25;

TextStyle blackTextStyle = GoogleFonts.poppins(
  color: blackColor,
);

TextStyle whiteTextStyle = GoogleFonts.poppins(
  color: whiteColor,
);

TextStyle greyTextStyle = GoogleFonts.poppins(
  color: greyColor,
);

TextStyle orangeTextStyle = GoogleFonts.poppins(
  color: orangeColor,
);

TextStyle regularTextStyle = GoogleFonts.poppins(
  color: blackColor,
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
