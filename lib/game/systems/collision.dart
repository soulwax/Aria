import 'package:flame/components.dart';
import '../data/constants.dart';
import '../world/world.dart' as game_world;
import '../entities/player.dart';
import '../entities/enemy.dart';
import 'physics.dart';

/// Collision detection system
class CollisionSystem {
  /// Check collision between player and enemies
  static void checkPlayerEnemyCollisions(Player player, game_world.World world) {
    for (final enemy in world.enemies) {
      if (enemy.isDead) continue;
      
      if (Physics.checkAABBCollision(
        player.position,
        player.size,
        enemy.position,
        enemy.size,
      )) {
        // Player takes damage
        player.takeDamage(1);
      }
    }
  }
  
  /// Check collision between player and items
  static void checkPlayerItemCollisions(Player player, game_world.World world) {
    for (final item in world.items) {
      final distance = (player.position - item.position).length;
      if (distance <= GameConstants.itemPickupRange) {
        // Item will handle collection in its update method
      }
    }
  }
  
  /// Check if position is valid (no collision)
  static bool isValidPosition(
    Vector2 position,
    Vector2 size,
    game_world.World world,
  ) {
    return !world.checkTileCollision(
      position.x,
      position.y,
      size.x,
      size.y,
    );
  }
}

