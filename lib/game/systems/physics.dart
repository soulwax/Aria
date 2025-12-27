import 'package:flame/components.dart';
import '../data/constants.dart';
import '../world/world.dart' as game_world;

/// Physics system for movement and collision
class Physics {
  /// Move entity with collision checking
  static Vector2 moveWithCollision(
    Vector2 currentPosition,
    Vector2 velocity,
    Vector2 size,
    game_world.World world,
    double dt,
  ) {
    final newX = currentPosition.x + velocity.x * dt;
    final newY = currentPosition.y + velocity.y * dt;
    
    // Check collision
    if (world.checkTileCollision(newX, currentPosition.y, size.x, size.y)) {
      // Try X movement only
      if (!world.checkTileCollision(newX, currentPosition.y, size.x, size.y)) {
        return Vector2(newX, currentPosition.y);
      }
    } else if (world.checkTileCollision(currentPosition.x, newY, size.x, size.y)) {
      // Try Y movement only
      if (!world.checkTileCollision(currentPosition.x, newY, size.x, size.y)) {
        return Vector2(currentPosition.x, newY);
      }
    } else {
      // Both directions are clear
      return Vector2(newX, newY);
    }
    
    // No valid movement
    return currentPosition;
  }
  
  /// Check AABB collision between two rectangles
  static bool checkAABBCollision(
    Vector2 pos1,
    Vector2 size1,
    Vector2 pos2,
    Vector2 size2,
  ) {
    return pos1.x < pos2.x + size2.x &&
        pos1.x + size1.x > pos2.x &&
        pos1.y < pos2.y + size2.y &&
        pos1.y + size1.y > pos2.y;
  }
  
  /// Resolve collision by pushing entity out
  static Vector2 resolveCollision(
    Vector2 entityPos,
    Vector2 entitySize,
    Vector2 obstaclePos,
    Vector2 obstacleSize,
  ) {
    // Calculate overlap
    final overlapX = (entityPos.x + entitySize.x / 2) - (obstaclePos.x + obstacleSize.x / 2);
    final overlapY = (entityPos.y + entitySize.y / 2) - (obstaclePos.y + obstacleSize.y / 2);
    
    // Determine push direction (smaller overlap)
    if (overlapX.abs() < overlapY.abs()) {
      // Push horizontally
      return Vector2(
        entityPos.x + (overlapX > 0 ? 1 : -1) * overlapX.abs(),
        entityPos.y,
      );
    } else {
      // Push vertically
      return Vector2(
        entityPos.x,
        entityPos.y + (overlapY > 0 ? 1 : -1) * overlapY.abs(),
      );
    }
  }
}

