import 'package:flutter/material.dart';

class QrOverlay extends StatelessWidget {
  const QrOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width * 0.6;
    final height = size.width * 0.6;
    return Positioned.fill(
      child: Center(
        child: CustomPaint(
          size: Size(width, height),
          painter: RoundedCornerPainter(),
        ),
      ),
    );
  }
}

class RoundedCornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    const cornerRadius = 20.0; // Radio de las esquinas redondeadas
    const distance = 50.0; // Distancia de las líneas a las esquinas

    // Esquina superior izquierda
    canvas.drawArc(
        Rect.fromCircle(
            center: const Offset(cornerRadius, cornerRadius),
            radius: cornerRadius),
        3.14,
        1.57,
        false,
        paint);
    canvas.drawLine(const Offset(cornerRadius, 0), const Offset(distance, 0),
        paint); // Línea superior
    canvas.drawLine(const Offset(0, cornerRadius), const Offset(0, distance),
        paint); // Línea izquierda

    // Esquina superior derecha
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width - cornerRadius, cornerRadius),
            radius: cornerRadius),
        -1.57,
        1.57,
        false,
        paint);
    canvas.drawLine(
        Offset(size.width - cornerRadius, 0),
        Offset(size.width - distance, 0),
        paint); // Línea superior esquina derecha
    canvas.drawLine(Offset(size.width, cornerRadius),
        Offset(size.width, distance), paint); // Línea derecha

    // Esquina inferior izquierda
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(cornerRadius, size.height - cornerRadius),
            radius: cornerRadius),
        1.57,
        1.57,
        false,
        paint);
    canvas.drawLine(
        Offset(0, size.height - cornerRadius),
        Offset(0, size.height - distance),
        paint); // Línea izquierda esquina inferior
    canvas.drawLine(Offset(cornerRadius, size.height),
        Offset(distance, size.height), paint); // Línea inferior

    // Esquina inferior derecha
    canvas.drawArc(
        Rect.fromCircle(
            center:
                Offset(size.width - cornerRadius, size.height - cornerRadius),
            radius: cornerRadius),
        0,
        1.57,
        false,
        paint);
    canvas.drawLine(
        Offset(size.width, size.height - cornerRadius),
        Offset(size.width, size.height - distance),
        paint); // Línea derecha esquina inferior
    canvas.drawLine(
        Offset(size.width - cornerRadius, size.height),
        Offset(size.width - distance, size.height),
        paint); // Línea inferior esquina derecha
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
