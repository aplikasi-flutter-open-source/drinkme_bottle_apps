import 'package:flutter/material.dart';

class BottleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    final roundnessFactor = size.width * 0.20;
    final bottleNeckHeight = size.height * 0.03;
    final bottleNeckWidth = size.width * 0.15;

//    final someAddHigh = bottleNeckHeight;
    final someAddHigh = 0;

    path.moveTo(bottleNeckWidth, 0);

    //top left
    path.lineTo(bottleNeckWidth, bottleNeckHeight);
    path.quadraticBezierTo(
        0, bottleNeckHeight, 0, roundnessFactor - someAddHigh);

    //bottom left
    path.lineTo(0, size.height - roundnessFactor);
    path.quadraticBezierTo(0, size.height, roundnessFactor, size.height);

    //bottom right
    path.lineTo(size.width - roundnessFactor, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - roundnessFactor);

    //top right
    path.lineTo(size.width, roundnessFactor - someAddHigh);
    path.quadraticBezierTo(size.width, bottleNeckHeight,
        size.width - bottleNeckWidth, bottleNeckHeight);

    path.lineTo(size.width - bottleNeckWidth, bottleNeckHeight);
    path.lineTo(size.width - bottleNeckWidth, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
