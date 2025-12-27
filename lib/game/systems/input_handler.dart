import 'package:flame/events.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

/// Input handler for keyboard, gamepad, and touch controls
class InputHandler {
  final Set<LogicalKeyboardKey> _pressedKeys = {};
  bool _attackPressed = false;
  bool _interactPressed = false;
  
  /// Handle key down
  void onKeyDown(KeyDownEvent event) {
    _pressedKeys.add(event.logicalKey);
  }
  
  /// Handle key up
  void onKeyUp(KeyUpEvent event) {
    _pressedKeys.remove(event.logicalKey);
  }
  
  /// Get movement direction vector
  Vector2 getMovementDirection() {
    double x = 0;
    double y = 0;
    
    // WASD or Arrow keys
    if (_pressedKeys.contains(LogicalKeyboardKey.keyW) ||
        _pressedKeys.contains(LogicalKeyboardKey.arrowUp)) {
      y -= 1;
    }
    if (_pressedKeys.contains(LogicalKeyboardKey.keyS) ||
        _pressedKeys.contains(LogicalKeyboardKey.arrowDown)) {
      y += 1;
    }
    if (_pressedKeys.contains(LogicalKeyboardKey.keyA) ||
        _pressedKeys.contains(LogicalKeyboardKey.arrowLeft)) {
      x -= 1;
    }
    if (_pressedKeys.contains(LogicalKeyboardKey.keyD) ||
        _pressedKeys.contains(LogicalKeyboardKey.arrowRight)) {
      x += 1;
    }
    
    // Normalize diagonal movement
    if (x != 0 && y != 0) {
      x *= 0.707; // 1/sqrt(2)
      y *= 0.707;
    }
    
    return Vector2(x, y);
  }
  
  /// Check if attack is pressed
  bool isAttackPressed() {
    final pressed = _pressedKeys.contains(LogicalKeyboardKey.space) ||
        _attackPressed;
    _attackPressed = false; // Reset after check
    return pressed;
  }
  
  /// Set attack pressed (for touch/button input)
  void setAttackPressed(bool pressed) {
    _attackPressed = pressed;
  }
  
  /// Check if interact is pressed
  bool isInteractPressed() {
    final pressed = _pressedKeys.contains(LogicalKeyboardKey.keyE) ||
        _interactPressed;
    _interactPressed = false; // Reset after check
    return pressed;
  }
  
  /// Set interact pressed
  void setInteractPressed(bool pressed) {
    _interactPressed = pressed;
  }
  
  /// Check if pause is pressed
  bool isPausePressed() {
    return _pressedKeys.contains(LogicalKeyboardKey.escape);
  }
  
  /// Clear all input
  void clear() {
    _pressedKeys.clear();
    _attackPressed = false;
    _interactPressed = false;
  }
}

