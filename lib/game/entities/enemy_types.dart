import 'package:flame/components.dart';
import '../data/constants.dart';
import '../world/world.dart' as game_world;
import 'enemy.dart';
import '../../../utils/helpers.dart';

/// Slime enemy - basic enemy that moves toward player
class Slime extends Enemy {
  Slime({Vector2? position}) : super(
    type: EnemyType.slime,
    maxHealth: 2,
    position: position,
    size: Vector2(18, 18),
  );
  
  @override
  void _updateAI(double dt) {
    final world = parent;
    if (world is! game_world.World || world.player == null) return;
    
    final player = world.player!;
    final distance = Helpers.distance(
      position.x,
      position.y,
      player.position.x,
      player.position.y,
    );
    
    // Move toward player if in detection range
    if (distance <= GameConstants.enemyDetectionRange) {
      final dx = player.position.x - position.x;
      final dy = player.position.y - position.y;
      final normalized = Helpers.normalize(dx, dy);
      
      final speed = GameConstants.enemySpeed * dt;
      final newX = position.x + normalized.x * speed;
      final newY = position.y + normalized.y * speed;
      
      // Check collision
      if (!world.checkTileCollision(newX, newY, size.x, size.y)) {
        position = Vector2(newX, newY);
      }
      
      // Attack if in range
      attackPlayer(player, dt);
    }
  }
}

/// Skeleton enemy - stronger enemy with more health
class Skeleton extends Enemy {
  Skeleton({Vector2? position}) : super(
    type: EnemyType.skeleton,
    maxHealth: 4,
    position: position,
    size: Vector2(22, 22),
  );
  
  @override
  void _updateAI(double dt) {
    final world = parent;
    if (world is! game_world.World || world.player == null) return;
    
    final player = world.player!;
    final distance = Helpers.distance(
      position.x,
      position.y,
      player.position.x,
      player.position.y,
    );
    
    // Move toward player if in detection range
    if (distance <= GameConstants.enemyDetectionRange * 1.5) {
      final dx = player.position.x - position.x;
      final dy = player.position.y - position.y;
      final normalized = Helpers.normalize(dx, dy);
      
      final speed = GameConstants.enemySpeed * 1.2 * dt;
      final newX = position.x + normalized.x * speed;
      final newY = position.y + normalized.y * speed;
      
      // Check collision
      if (!world.checkTileCollision(newX, newY, size.x, size.y)) {
        position = Vector2(newX, newY);
      }
      
      // Attack if in range
      attackPlayer(player, dt);
    }
  }
}

