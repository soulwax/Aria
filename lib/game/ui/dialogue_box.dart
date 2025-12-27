import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'dart:ui';
import 'package:flutter/material.dart' as material;

/// Dialogue box for NPC conversations
class DialogueBox extends Component with HasGameReference, TapCallbacks {
  final String text;
  final VoidCallback? onClose;
  
  DialogueBox({
    required this.text,
    this.onClose,
  });
  
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    // Box dimensions
    final boxWidth = gameRef.size.x * 0.8;
    final boxHeight = gameRef.size.y * 0.3;
    final boxX = (gameRef.size.x - boxWidth) / 2;
    final boxY = gameRef.size.y - boxHeight - 20;
    
    // Background
    final bgPaint = Paint()
      ..color = const Color(0xFF2a2a3e)
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(boxX, boxY, boxWidth, boxHeight),
      bgPaint,
    );
    
    // Border
    final borderPaint = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(
      Rect.fromLTWH(boxX, boxY, boxWidth, boxHeight),
      borderPaint,
    );
    
    // Text
    final textPainter = material.TextPainter(
      text: material.TextSpan(
        text: text,
        style: const material.TextStyle(
          color: material.Colors.white,
          fontSize: 18,
        ),
      ),
      textAlign: material.TextAlign.left,
      textDirection: material.TextDirection.ltr,
      maxLines: 5,
    );
    textPainter.layout(maxWidth: boxWidth - 20);
    textPainter.paint(
      canvas,
      Offset(boxX + 10, boxY + 10),
    );
    
    // Close hint
    final hintPainter = material.TextPainter(
      text: const material.TextSpan(
        text: 'Press E to continue',
        style: material.TextStyle(
          color: material.Colors.grey,
          fontSize: 14,
        ),
      ),
      textAlign: material.TextAlign.right,
      textDirection: material.TextDirection.ltr,
    );
    hintPainter.layout();
    hintPainter.paint(
      canvas,
      Offset(boxX + boxWidth - hintPainter.width - 10, boxY + boxHeight - 25),
    );
  }
  
  @override
  bool onTapDown(TapDownEvent event) {
    onClose?.call();
    removeFromParent();
    return true;
  }
}

