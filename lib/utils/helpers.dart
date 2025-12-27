import 'dart:math' as math;
import 'package:flame/components.dart';
import '../game/data/constants.dart';

/// Utility helper functions
class Helpers {
  /// Calculate distance between two points
  static double distance(double x1, double y1, double x2, double y2) {
    final dx = x2 - x1;
    final dy = y2 - y1;
    return math.sqrt(dx * dx + dy * dy);
  }
  
  /// Normalize a vector
  static Vector2 normalize(double x, double y) {
    final length = math.sqrt(x * x + y * y);
    if (length == 0) return Vector2.zero();
    return Vector2(x / length, y / length);
  }
  
  /// Clamp value between min and max
  static double clamp(double value, double min, double max) {
    return value.clamp(min, max);
  }
  
  /// Convert tile coordinates to world coordinates
  static double tileToWorld(int tile) {
    return tile * GameConstants.tileSize;
  }
  
  /// Convert world coordinates to tile coordinates
  static int worldToTile(double world) {
    return (world / GameConstants.tileSize).floor();
  }
  
  /// Check if point is within rectangle
  static bool pointInRect(
    double x,
    double y,
    double rectX,
    double rectY,
    double rectWidth,
    double rectHeight,
  ) {
    return x >= rectX &&
        x <= rectX + rectWidth &&
        y >= rectY &&
        y <= rectY + rectHeight;
  }
}

