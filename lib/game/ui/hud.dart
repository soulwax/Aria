import 'package:flame/components.dart';
import 'dart:ui';
import 'package:flutter/material.dart' as material;
import '../data/constants.dart';
import '../data/game_state.dart';

/// Heads-up display showing health, inventory, etc.
class HUD extends Component with HasGameReference {
  final GameState gameState;
  
  HUD({required this.gameState});
  
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    // Draw health bar
    _drawHealthBar(canvas);
    
    // Draw rupees
    _drawRupees(canvas);
    
    // Draw keys
    _drawKeys(canvas);
    
    // Draw equipped items
    _drawEquippedItems(canvas);
  }
  
  void _drawHealthBar(Canvas canvas) {
    const barX = GameConstants.hudPadding;
    const barY = GameConstants.hudPadding;
    const barWidth = GameConstants.healthBarWidth;
    const barHeight = GameConstants.healthBarHeight;
    
    // Background
    final bgPaint = Paint()
      ..color = const Color(0xFF333333)
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(barX, barY, barWidth, barHeight),
      bgPaint,
    );
    
    // Health fill
    final healthRatio = gameState.currentHealth / gameState.maxHealth;
    final healthPaint = Paint()
      ..color = const Color(0xFFFF0000)
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(barX, barY, barWidth * healthRatio, barHeight),
      healthPaint,
    );
    
    // Border
    final borderPaint = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(
      Rect.fromLTWH(barX, barY, barWidth, barHeight),
      borderPaint,
    );
    
    // Health text
    final textPainter = material.TextPainter(
      text: material.TextSpan(
        text: '${gameState.currentHealth}/${gameState.maxHealth}',
        style: const material.TextStyle(
          color: material.Colors.white,
          fontSize: 14,
          fontWeight: material.FontWeight.bold,
        ),
      ),
      textDirection: material.TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(barX + barWidth / 2 - textPainter.width / 2, barY + 2),
    );
  }
  
  void _drawRupees(Canvas canvas) {
    const iconX = GameConstants.hudPadding;
    const iconY = GameConstants.hudPadding + GameConstants.healthBarHeight + 10;
    
    // Rupee icon (green square)
    final iconPaint = Paint()
      ..color = const Color(0xFF00FF00)
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(iconX, iconY, 20, 20),
      iconPaint,
    );
    
    // Rupee count
    final textPainter = material.TextPainter(
      text: material.TextSpan(
        text: '${gameState.rupees}',
        style: const material.TextStyle(
          color: material.Colors.white,
          fontSize: 16,
          fontWeight: material.FontWeight.bold,
        ),
      ),
      textDirection: material.TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(iconX + 25, iconY + 2));
  }
  
  void _drawKeys(Canvas canvas) {
    const iconX = GameConstants.hudPadding;
    const iconY = GameConstants.hudPadding + GameConstants.healthBarHeight + 35;
    
    // Key icon (yellow square)
    final iconPaint = Paint()
      ..color = const Color(0xFFFFD700)
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(iconX, iconY, 20, 20),
      iconPaint,
    );
    
    // Key count
    final textPainter = material.TextPainter(
      text: material.TextSpan(
        text: '${gameState.keys}',
        style: const material.TextStyle(
          color: material.Colors.white,
          fontSize: 16,
          fontWeight: material.FontWeight.bold,
        ),
      ),
      textDirection: material.TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(iconX + 25, iconY + 2));
  }
  
  void _drawEquippedItems(Canvas canvas) {
    const startX = GameConstants.hudPadding;
    const startY = GameConstants.hudPadding + GameConstants.healthBarHeight + 60;
    
    int offset = 0;
    
    if (gameState.hasSword) {
      final swordPaint = Paint()
        ..color = const Color(0xFFC0C0C0)
        ..style = PaintingStyle.fill;
      canvas.drawRect(
        Rect.fromLTWH(startX + offset * 25, startY, 20, 20),
        swordPaint,
      );
      offset++;
    }
    
    if (gameState.hasShield) {
      final shieldPaint = Paint()
        ..color = const Color(0xFF8B4513)
        ..style = PaintingStyle.fill;
      canvas.drawRect(
        Rect.fromLTWH(startX + offset * 25, startY, 20, 20),
        shieldPaint,
      );
      offset++;
    }
  }
}

