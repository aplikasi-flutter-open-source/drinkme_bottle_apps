import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// Grey
const Color grey1 = Color(0xFF333333);
const Color grey2 = Color(0xFF4F4F4F);
const Color white = Color(0xFFFFFFFF);
const Color black = Color(0xFF000000);
const Color transparent = Color(0x00000000);
const Color bgColorApp = Color(0xFFF4F5F7);

// Grey
const Color grey = Color(0xFF707070);
const Color greyInput = Color(0xFFD8D8D8);
const Color greyShadow = Color(0xFFDEE1E4);

//const Color colorPrimary = Colors.lightBlue;
//const Color colorPrimary = Color(0xff5BCEEB);
//const Color colorPrimary = Color(0xff43C5E5);
const Color colorPrimary = Color(0xff27A2DB);
const Color bottleHeaderColor = Color(0xff3A556A);

TextStyle text10Normal() => GoogleFonts.rubik(color: black, fontSize: 10.sp);

TextStyle text10Bold() => GoogleFonts.rubik(
    fontWeight: FontWeight.bold, color: black, fontSize: 10.sp);

TextStyle text14Normal() => GoogleFonts.rubik(color: black, fontSize: 14.sp);

TextStyle text14Bold() => GoogleFonts.rubik(
    fontWeight: FontWeight.bold, color: black, fontSize: 14.sp);

TextStyle text12Normal() => GoogleFonts.rubik(color: black, fontSize: 12.sp);

TextStyle text12Bold() => GoogleFonts.rubik(
    fontWeight: FontWeight.bold, color: black, fontSize: 12.sp);

TextStyle text16Bold() => GoogleFonts.rubik(
    color: grey1, fontSize: 16.sp, fontWeight: FontWeight.bold);

TextStyle text18Bold() => GoogleFonts.rubik(
    color: black, fontSize: 18.sp, fontWeight: FontWeight.bold);
