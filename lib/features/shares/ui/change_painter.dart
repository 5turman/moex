import 'package:flutter/cupertino.dart';
import 'package:com.example.moex/app_colors.dart';

class ChangePainter extends CustomPainter {
  final double change;

  ChangePainter(this.change);

  @override
  void paint(Canvas canvas, Size size) {
    if (change == 0) return;

    final w = size.width;
    final h = size.height;

    final path = Path();
    if (change > 0) {
      path
        ..moveTo(w / 2, 0)
        ..lineTo(w, h)
        ..lineTo(0, h)
        ..close();
    } else {
      path
        ..lineTo(w, 0)
        ..lineTo(w / 2, h)
        ..close();
    }

    final paint = Paint()..color = (change > 0) ? AppColors.up : AppColors.down;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(ChangePainter oldDelegate) =>
      (oldDelegate.change != change);
}
