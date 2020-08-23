import 'dart:math';
import 'package:flutter/material.dart';

class WaterWaves extends StatefulWidget {
  final Color borderColor, fillColor;
  final double progress;

  WaterWaves(this.borderColor, this.fillColor, this.progress);

  @override
  WaterWavesState createState() => new WaterWavesState();
}

class WaterWavesState extends State<WaterWaves> with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
//    WidgetsBinding widgetsBinding = WidgetsBinding.instance;
//    widgetsBinding.addPostFrameCallback((callback) {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
    );
    controller.repeat();
//    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return CustomPaint(
              painter: WaterWavesPainter(controller, widget.borderColor,
                  widget.fillColor, widget.progress));
        });
  }
}

class WaterWavesPainter extends CustomPainter {
  Animation<double> _animation;
  Color borderColor, fillColor;
  double _progress;

  WaterWavesPainter(
      this._animation, this.borderColor, this.fillColor, this._progress)
      : super(repaint: _animation);

  @override
  void paint(Canvas canvas, Size size) {
    // draw small wave
    Paint wave2Paint = new Paint()..color = fillColor.withOpacity(0.5);
    double p = _progress / 100.0;
    double n = 4.2;
    double amp = 4.0;
    double baseHeight = (1 - p) * size.height;

    Path path = Path();
    path.moveTo(0.0, baseHeight);
    for (double i = 0.0; i < size.width; i++) {
      path.lineTo(
          i,
          baseHeight +
              sin((i / size.width * 2 * pi * n) +
                      (_animation.value * 2 * pi) +
                      pi * 1) *
                  amp);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    canvas.drawPath(path, wave2Paint);

    // draw big wave
    Paint wave1Paint = new Paint()..color = fillColor;
    n = 2.2;
    amp = 10.0;

    path = Path();
    path.moveTo(0.0, baseHeight);
    for (double i = 0.0; i < size.width; i++) {
      path.lineTo(
          i,
          baseHeight +
              sin((i / size.width * 2 * pi * n) + (_animation.value * 2 * pi)) *
                  amp);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    canvas.drawPath(path, wave1Paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
