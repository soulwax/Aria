import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'dart:ui';
import '../data/constants.dart';
import '../world/world.dart' as game_world;
import 'player.dart';
import '../../utils/helpers.dart';

/// Collectible item entity
class Item extends PositionComponent with HasGameReference, CollisionCallbacks {
  final ItemType type;
  bool _collected = false;
  
  Item({
    required this.type,
    Vector2? position,
  }) : super(
          position: position ?? Vector2.zero(),
          size: Vector2(16, 16),
        );
  
  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(RectangleHitbox());
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    if (_collected) return;
    
    // Check if player is near
    final world = parent;
    if (world is game_world.World && world.player != null) {
      final player = world.player!;
      final distance = Helpers.distance(
        position.x,
        position.y,
        player.position.x,
        player.position.y,
      );
      
      if (distance <= GameConstants.itemPickupRange) {
        collect(player);
      }
    }
  }
  
  /// Collect the item
  void collect(Player player) {
    if (_collected) return;
    _collected = true;
    
    // Handle item collection based on type
    switch (type) {
      case ItemType.heart:
        player.gameState.heal(1);
        break;
      case ItemType.rupee:
        player.gameState.addRupees(1);
        break;
      case ItemType.key:
        player.gameState.addKey();
        break;
      case ItemType.bomb:
        player.gameState.inventory.addItem(ItemType.bomb);
        break;
      case ItemType.sword:
        player.gameState.acquireSword();
        break;
      case ItemType.shield:
        player.gameState.acquireShield();
        break;
    }
    
    // Remove from world
    final world = parent;
    if (world is game_world.World) {
      world.removeItem(this);
    }
    removeFromParent();
  }
  
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    if (_collected) return;
    
    final paint = Paint()
      ..color = _getItemColor()
      ..style = PaintingStyle.fill;
    
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.x, size.y),
      paint,
    );
  }
  
  Color _getItemColor() {
    switch (type) {
      case ItemType.heart:
        return const Color(0xFFFF0000);
      case ItemType.rupee:
        return const Color(0xFF00FF00);
      case ItemType.key:
        return const Color(0xFFFFD700);
      case ItemType.bomb:
        return const Color(0xFF000000);
      case ItemType.sword:
        return const Color(0xFFC0C0C0);
      case ItemType.shield:
        return const Color(0xFF8B4513);
    }
  }
}

