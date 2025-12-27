import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'dart:ui';
import 'package:flutter/material.dart' as material;
import '../data/game_state.dart';

/// Pause menu overlay
class PauseMenu extends Component with HasGameReference, TapCallbacks {
  final GameState gameState;
  
  PauseMenu({required this.gameState});
  
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    // Semi-transparent background
    final bgPaint = Paint()
      ..color = const Color(0x80000000)
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, gameRef.size.x, gameRef.size.y),
      bgPaint,
    );
    
    // Pause text
    final textPainter = material.TextPainter(
      text: const material.TextSpan(
        text: 'PAUSED\n\nPress ESC to resume',
        style: material.TextStyle(
          color: material.Colors.white,
          fontSize: 32,
          fontWeight: material.FontWeight.bold,
        ),
      ),
      textAlign: material.TextAlign.center,
      textDirection: material.TextDirection.ltr,
    );
    textPainter.layout(maxWidth: gameRef.size.x);
    textPainter.paint(
      canvas,
      Offset(
        gameRef.size.x / 2 - textPainter.width / 2,
        gameRef.size.y / 2 - textPainter.height / 2,
      ),
    );
  }
}

