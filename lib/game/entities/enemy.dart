import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'dart:ui';
import '../data/constants.dart';
import '../world/world.dart' as game_world;
import 'player.dart';
import '../../../utils/helpers.dart';

/// Base enemy class
abstract class Enemy extends PositionComponent with HasGameReference, CollisionCallbacks {
  final EnemyType type;
  int _health;
  final int maxHealth;
  double _attackCooldown = 0.0;
  bool _isDead = false;
  
  int get health => _health;
  bool get isDead => _isDead;
  
  Enemy({
    required this.type,
    required int maxHealth,
    Vector2? position,
    Vector2? size,
  })  : _health = maxHealth,
        maxHealth = maxHealth,
        super(
          position: position ?? Vector2.zero(),
          size: size ?? Vector2(20, 20),
        );
  
  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(RectangleHitbox());
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    if (_isDead) return;
    
    if (_attackCooldown > 0) {
      _attackCooldown -= dt;
    }
    
    _updateAI(dt);
  }
  
  /// Update AI behavior (to be implemented by subclasses)
  void _updateAI(double dt) {
    // Override in subclasses
  }
  
  /// Take damage
  void takeDamage(int amount) {
    if (_isDead) return;
    
    _health -= amount;
    if (_health <= 0) {
      _isDead = true;
      onDeath();
    }
  }
  
  /// Called when enemy dies
  void onDeath() {
    // Remove from world
    final world = parent;
    if (world is game_world.World) {
      world.removeEnemy(this);
    }
    removeFromParent();
  }
  
  /// Attack player if in range
  void attackPlayer(Player player, double dt) {
    if (_attackCooldown > 0) return;
    
    final distance = Helpers.distance(
      position.x,
      position.y,
      player.position.x,
      player.position.y,
    );
    
    if (distance <= GameConstants.enemyAttackRange) {
      player.takeDamage(1);
      _attackCooldown = GameConstants.enemyAttackCooldown;
    }
  }
  
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    final paint = Paint()
      ..color = _getEnemyColor()
      ..style = PaintingStyle.fill;
    
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.x, size.y),
      paint,
    );
  }
  
  Color _getEnemyColor() {
    switch (type) {
      case EnemyType.slime:
        return const Color(0xFF00FF00);
      case EnemyType.skeleton:
        return const Color(0xFFCCCCCC);
      case EnemyType.boss:
        return const Color(0xFFFF0000);
    }
  }
}

