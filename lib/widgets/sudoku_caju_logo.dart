import 'dart:math' as math;

import 'package:flutter/material.dart';

/// 首页使用的数独 Caju 动态品牌标。
class SudokuCajuLogo extends StatefulWidget {
  const SudokuCajuLogo({
    super.key,
    required this.foregroundColor,
    this.title = '数独',
    this.size = 240,
  });

  final Color foregroundColor;
  final String title;
  final double size;

  @override
  State<SudokuCajuLogo> createState() => _SudokuCajuLogoState();
}

class _SudokuCajuLogoState extends State<SudokuCajuLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5600),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    return SizedBox(
      width: widget.size,
      height: widget.size * 0.72,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final progress = reduceMotion ? 0.22 : _controller.value;
          final floatY = reduceMotion
              ? 0.0
              : math.sin(progress * math.pi * 2) * 2.0;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.translate(
                offset: Offset(0, floatY),
                child: SizedBox(
                  width: widget.size,
                  height: widget.size * 0.46,
                  child: CustomPaint(
                    painter: _PremiumMarkPainter(
                      progress: progress,
                      foreground: widget.foregroundColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: widget.size * 0.035),
              _Wordmark(
                title: widget.title,
                color: widget.foregroundColor,
                width: widget.size,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Wordmark extends StatelessWidget {
  const _Wordmark({
    required this.title,
    required this.color,
    required this.width,
  });

  final String title;
  final Color color;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$title Caju',
      child: ExcludeSemantics(
        child: SizedBox(
          width: width,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  style: TextStyle(
                    color: color,
                    fontSize: width * 0.125,
                    height: 1,
                    fontWeight: FontWeight.w800,
                    letterSpacing: width * 0.015,
                  ),
                ),
                Container(
                  width: 1,
                  height: width * 0.11,
                  margin: EdgeInsets.symmetric(horizontal: width * 0.045),
                  color: color.withValues(alpha: 0.42),
                ),
                Text(
                  'CAJU',
                  maxLines: 1,
                  style: TextStyle(
                    color: const Color(0xFFFF9C3D),
                    fontSize: width * 0.062,
                    height: 1,
                    fontWeight: FontWeight.w700,
                    letterSpacing: width * 0.018,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PremiumMarkPainter extends CustomPainter {
  const _PremiumMarkPainter({
    required this.progress,
    required this.foreground,
  });

  final double progress;
  final Color foreground;

  static const _orange = Color(0xFFFF9C3D);
  static const _ink = Color(0xFF4B2A20);

  @override
  void paint(Canvas canvas, Size size) {
    final unit = size.width / 240;
    canvas.scale(unit);

    _paintOrbit(canvas, front: false);
    _paintGrid(canvas);
    _paintOrbit(canvas, front: true);
    _paintShimmer(canvas);
  }

  void _paintOrbit(Canvas canvas, {required bool front}) {
    final orbit = Rect.fromCenter(
      center: const Offset(120, 56),
      width: 174,
      height: 72,
    );
    canvas.save();
    canvas.translate(orbit.center.dx, orbit.center.dy);
    canvas.rotate(-0.11);
    canvas.translate(-orbit.center.dx, -orbit.center.dy);

    if (!front) {
      canvas.drawArc(
        orbit,
        math.pi,
        math.pi,
        false,
        Paint()
          ..color = foreground.withValues(alpha: 0.12)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.1,
      );
    } else {
      canvas.drawArc(
        orbit,
        0,
        math.pi,
        false,
        Paint()
          ..color = foreground.withValues(alpha: 0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.35,
      );
    }

    final angle = progress * math.pi * 2 - math.pi / 2;
    final dotIsFront = math.sin(angle) >= 0;
    if (dotIsFront != front) {
      canvas.restore();
      return;
    }

    for (var i = 7; i >= 0; i--) {
      final opacity = (8 - i) / 8 * (front ? 0.34 : 0.17);
      canvas.drawArc(
        orbit,
        angle - (i + 1) * 0.055,
        0.06,
        false,
        Paint()
          ..color = foreground.withValues(alpha: opacity)
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = front ? 1.8 : 1.2,
      );
    }

    final dot = Offset(
      orbit.center.dx + math.cos(angle) * orbit.width / 2,
      orbit.center.dy + math.sin(angle) * orbit.height / 2,
    );
    canvas.drawCircle(
      dot,
      front ? 6 : 4,
      Paint()
        ..color = foreground.withValues(alpha: front ? 0.14 : 0.07)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
    canvas.drawCircle(
      dot,
      front ? 2.6 : 1.8,
      Paint()..color = foreground.withValues(alpha: front ? 0.9 : 0.42),
    );
    canvas.restore();
  }

  void _paintGrid(Canvas canvas) {
    const rect = Rect.fromLTWH(74.5, 10, 91, 91);
    final board = RRect.fromRectAndRadius(rect, const Radius.circular(16));
    canvas.drawRRect(
      board.shift(const Offset(0, 5)),
      Paint()
        ..color = Colors.black.withValues(alpha: 0.18)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 9),
    );
    canvas.drawRRect(
      board,
      Paint()..color = foreground.withValues(alpha: 0.96),
    );

    const padding = 9.0;
    const gap = 4.0;
    const cell = (91 - padding * 2 - gap * 2) / 3;
    const values = [
      ['5', '', '3'],
      ['', '7', ''],
      ['8', '', '1'],
    ];
    final activePosition = progress * 9;

    for (var row = 0; row < 3; row++) {
      for (var col = 0; col < 3; col++) {
        final index = row * 3 + col;
        final left = rect.left + padding + col * (cell + gap);
        final top = rect.top + padding + row * (cell + gap);
        final cellRect = RRect.fromRectAndRadius(
          Rect.fromLTWH(left, top, cell, cell),
          const Radius.circular(5),
        );
        final distance = math.min(
          (activePosition - index).abs(),
          9 - (activePosition - index).abs(),
        );
        final glow = (1 - distance).clamp(0.0, 1.0);
        canvas.drawRRect(
          cellRect,
          Paint()
            ..color = Color.lerp(
              _orange.withValues(alpha: 0.12),
              _orange.withValues(alpha: 0.96),
              Curves.easeOut.transform(glow),
            )!,
        );

        final value = values[row][col];
        if (value.isEmpty) continue;
        final painter = TextPainter(
          text: TextSpan(
            text: value,
            style: TextStyle(
              color: Color.lerp(foreground, _ink, glow),
              fontSize: 14,
              height: 1,
              fontWeight: FontWeight.w800,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        painter.paint(
          canvas,
          Offset(
            left + (cell - painter.width) / 2,
            top + (cell - painter.height) / 2,
          ),
        );
      }
    }
  }

  void _paintShimmer(Canvas canvas) {
    final shimmerPhase = Curves.easeInOutCubic.transform(progress);
    final shimmerOpacity =
        (math.pow(math.sin(progress * math.pi), 2) * 0.2).toDouble();
    final x = 63 + shimmerPhase * 113;
    canvas.save();
    canvas.clipRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(74.5, 10, 91, 91),
        const Radius.circular(16),
      ),
    );
    canvas.drawRect(
      Rect.fromLTWH(x, 4, 13, 103),
      Paint()
        ..shader = LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0),
            Colors.white.withValues(alpha: shimmerOpacity),
            Colors.white.withValues(alpha: 0),
          ],
        ).createShader(Rect.fromLTWH(x, 4, 13, 103)),
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(_PremiumMarkPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.foreground != foreground;
}
