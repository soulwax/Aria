import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'dart:ui';
import '../data/constants.dart';
import '../world/world.dart' as game_world;
import '../../utils/helpers.dart';

/// Projectile entity (arrows, magic, etc.)
class Projectile extends PositionComponent with HasGameReference, CollisionCallbacks {
  final Vector2 velocity;
  final double damage;
  final double lifetime;
  double _age = 0.0;
  bool _isExpired = false;
  
  Projectile({
    required Vector2 startPosition,
    required this.velocity,
    this.damage = 1.0,
    this.lifetime = 3.0,
    Vector2? size,
  }) : super(
          position: startPosition,
          size: size ?? Vector2(8, 8),
        );
  
  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(RectangleHitbox());
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    if (_isExpired) return;
    
    _age += dt;
    if (_age >= lifetime) {
      expire();
      return;
    }
    
    // Update position
    position += velocity * dt;
    
    // Check collision with world
    final world = parent;
    if (world is game_world.World) {
      if (world.checkTileCollision(position.x, position.y, size.x, size.y)) {
        expire();
        return;
      }
    }
  }
  
  void expire() {
    if (_isExpired) return;
    _isExpired = true;
    removeFromParent();
  }
  
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    if (_isExpired) return;
    
    final paint = Paint()
      ..color = const Color(0xFFFFFF00)
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      size.x / 2,
      paint,
    );
  }
}

