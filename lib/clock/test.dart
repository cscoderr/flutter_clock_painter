// ignore_for_file: cascade_invocations

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ClockFace extends StatefulWidget {
  const ClockFace({
    super.key,
  });

  @override
  State<ClockFace> createState() => _ClockFaceState();
}

class _ClockFaceState extends State<ClockFace>
    with SingleTickerProviderStateMixin {
  final location = ValueNotifier(Offset.zero);
  final progressRadian = ValueNotifier<double>(5);
  Offset previousOffset = Offset.zero;

  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();
  }

  @override
  void dispose() {
    super.dispose();

    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Listener(
        onPointerDown: (event) {},
        onPointerUp: (event) {},
        onPointerMove: (PointerMoveEvent event) {
          if (progressRadian.value < 360) {
            if (previousOffset.dx < event.position.dx ||
                previousOffset.dy < event.position.dy) {
              progressRadian.value += 1;
            } else {
              if (progressRadian.value < 1) return;
              progressRadian.value -= 1;
            }
          }

          setState(() {
            previousOffset = event.position;
          });
        },
        child: ValueListenableBuilder(
          valueListenable: progressRadian,
          builder: (context, value, child) {
            return CustomPaint(
              painter: ClockFacePainter(
                animation: animationController,
                startDegree: value,
              ),
              size: MediaQuery.of(context).size,
            );
          },
        ),
      ),
    );
  }
}

class ClockFacePainter extends CustomPainter {
  ClockFacePainter({
    required this.animation,
    required this.startDegree,
  }) : super(repaint: animation) {
    angleAnimation = Tween<double>(begin: 10, end: 20).animate(
      CurvedAnimation(parent: animation, curve: Curves.easeInOut),
    );

    radianAnimation = Tween<double>(begin: 10, end: startDegree).animate(
      CurvedAnimation(parent: animation, curve: Curves.easeInOut),
    );
  }

  late Animation<double> angleAnimation;
  late Animation<double> radianAnimation;

  final double startDegree;

  final AnimationController animation;
  @override
  void paint(Canvas canvas, Size size) {
    final circlePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = const Color(0xFF171C26)
      ..strokeWidth = 50;

    final arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = const Color(0xFF00D9F6)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 50;

    final tickPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white
      ..strokeWidth = 2;

    final tickPaint2 = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white12
      ..strokeWidth = 1;

    final center = size / 2;

    canvas.drawCircle(
      Offset(center.width, center.height),
      center.width - 40,
      circlePaint,
    );

    final arcRect = Rect.fromCircle(
      center: Offset(center.width, center.height),
      radius: center.width - 40,
    );
    canvas.drawArc(
      arcRect,
      -90.radians,
      (radianAnimation.value * 30).radians,
      false,
      arcPaint,
    );

    for (var i = 0; i < 360; i += 6) {
      final x1 = center.width + (center.height - 115) * math.cos(i.radians);
      final y1 = center.height + (center.width - 70) * math.sin(i.radians);

      final x2 = center.width + (center.width - 90) * math.cos(i.radians);
      final y2 = center.height + (center.width - 80) * math.sin(i.radians);

      if ((i % 90) == 0) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: ((i + 90) ~/ 30).toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: 'Arial',
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();

        textPainter.paint(
          canvas,
          Offset(
            center.width + 72 * math.cos(i.radians),
            center.height + 72 * math.sin(i.radians),
          ),
        );
      }

      if ((i % 30) == 0) {
        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), tickPaint);
      } else {
        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), tickPaint2);
      }
    }

    final textPainter = TextPainter(
      text: TextSpan(
        text: (radianAnimation.value.toInt()).toString().formatText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 70,
          fontWeight: FontWeight.w700,
          fontFamily: 'Arial',
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    textPainter.paint(
      canvas,
      Offset(center.width - 30, center.height - 40),
    );

    final notificationPaint = Paint()
      ..color = const Color(0xFF0E121B)
      ..style = PaintingStyle.fill;
    //math.cos((radianAnimation.value * 30).radians).abs()
    canvas.drawCircle(
      Offset(
        center.width - 20 + 20,
        center.height - 160 + 22,
      ),
      20,
      notificationPaint,
    );
    final iconPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(LineIcons.powerOff.codePoint),
        style: TextStyle(
          color: const Color(0xFF00D9F6),
          fontSize: 30,
          fontFamily: LineIcons.powerOff.fontFamily,
          package: LineIcons.powerOff.fontPackage,
        ),
      ),
      textDirection: TextDirection.rtl,
    );
    iconPainter.layout();

    iconPainter.paint(
      canvas,
      Offset(
        center.width - 15,
        center.height - 154,
      ),
    );

    final bottomPaint = Paint()
      ..color = const Color(0xFF0E121B)
      ..style = PaintingStyle.fill;
    //math.cos((radianAnimation.value * 30).radians).abs()
    canvas.drawCircle(
      Offset(
        center.width + 60 + 10,
        center.height + 105 + 12,
      ),
      20,
      bottomPaint,
    );

    final bottomIconPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(LineIcons.bell.codePoint),
        style: TextStyle(
          color: const Color(0xFF00D9F6),
          fontSize: 30,
          fontFamily: LineIcons.bell.fontFamily,
          package: LineIcons.bell.fontPackage,
        ),
      ),
      textDirection: TextDirection.rtl,
    );
    bottomIconPainter.layout();

    bottomIconPainter.paint(
      canvas,
      Offset(center.width + 55, center.height + 100),
    );
  }

  @override
  bool shouldRepaint(ClockFacePainter oldDelegate) =>
      oldDelegate.startDegree != startDegree;

  @override
  bool shouldRebuildSemantics(ClockFacePainter oldDelegate) => false;
}

extension NumX<T extends num> on T {
  double get radians => (this * math.pi) / 180.0;
}

extension StringX on String {
  String get formatText => length < 2 ? '0$this' : this;
}

Offset toPolar(Offset center, double radians, double radius) {
  return center +
      Offset(radius * math.cos(radians), radius * math.sin(radians));
}
