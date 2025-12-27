import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'dart:ui';
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';

/// Main menu component
class MainMenu extends Component with HasGameReference, TapCallbacks {
  final VoidCallback onStartGame;
  final VoidCallback onLoadGame;
  final VoidCallback onQuit;
  
  MainMenu({
    required this.onStartGame,
    required this.onLoadGame,
    required this.onQuit,
  });
  
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    // Background
    final bgPaint = Paint()
      ..color = const Color(0xFF1a1a2e)
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, gameRef.size.x, gameRef.size.y),
      bgPaint,
    );
    
    // Title
    final titlePainter = material.TextPainter(
      text: const material.TextSpan(
        text: 'ARIA',
        style: material.TextStyle(
          color: material.Colors.white,
          fontSize: 64,
          fontWeight: material.FontWeight.bold,
        ),
      ),
      textAlign: material.TextAlign.center,
      textDirection: material.TextDirection.ltr,
    );
    titlePainter.layout(maxWidth: gameRef.size.x);
    titlePainter.paint(
      canvas,
      Offset(
        gameRef.size.x / 2 - titlePainter.width / 2,
        gameRef.size.y / 4,
      ),
    );
    
    // Menu options
    final menuY = gameRef.size.y / 2;
    final menuItems = ['Start Game', 'Load Game', 'Quit'];
    final menuCallbacks = [onStartGame, onLoadGame, onQuit];
    
    for (int i = 0; i < menuItems.length; i++) {
      final itemPainter = material.TextPainter(
        text: material.TextSpan(
          text: menuItems[i],
          style: const material.TextStyle(
            color: material.Colors.white,
            fontSize: 24,
          ),
        ),
        textAlign: material.TextAlign.center,
        textDirection: material.TextDirection.ltr,
      );
      itemPainter.layout(maxWidth: gameRef.size.x);
      itemPainter.paint(
        canvas,
        Offset(
          gameRef.size.x / 2 - itemPainter.width / 2,
          menuY + i * 50,
        ),
      );
    }
  }
}

