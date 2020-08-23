import 'package:flutter/material.dart';

class BottleReflection extends StatelessWidget {
  final BoxConstraints constraints;

  const BottleReflection(this.constraints);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: constraints.maxHeight * 0.10,
            width: constraints.maxWidth * 0.07,
            decoration: ShapeDecoration(
              color: Colors.white.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(15), bottom: Radius.circular(12))),
            )),
        SizedBox(height: constraints.maxHeight * 0.02),
        Container(
          height: constraints.maxHeight * 0.15,
          width: constraints.maxWidth * 0.07,
          decoration: ShapeDecoration(
            color: Colors.white.withOpacity(0.3),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(15), bottom: Radius.circular(12))),
          ),
        )
      ],
    );
  }
}