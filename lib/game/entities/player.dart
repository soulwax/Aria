import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/collisions.dart';
import 'dart:ui';
import '../data/constants.dart';
import '../data/game_state.dart';
import '../systems/input_handler.dart';
import '../systems/physics.dart';
import '../world/world.dart' as game_world;

/// Player character entity
class Player extends PositionComponent with HasGameReference, CollisionCallbacks {
  final GameState gameState;
  final InputHandler inputHandler;
  
  Direction _facing = Direction.down;
  PlayerState _state = PlayerState.idle;
  double _attackCooldown = 0.0;
  bool _isMoving = false;
  
  Direction get facing => _facing;
  PlayerState get state => _state;
  
  Player({
    required this.gameState,
    required this.inputHandler,
    Vector2? position,
  }) : super(
          position: position ?? Vector2(100, 100),
          size: Vector2(24, 24),
        );
  
  @override
  Future<void> onLoad() async {
    super.onLoad();
    
    // Add collision shape
    add(RectangleHitbox());
    
    // Set initial position
    if (position == Vector2.zero()) {
      position = Vector2(100, 100);
    }
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    if (gameState.isPaused) return;
    
    // Update attack cooldown
    if (_attackCooldown > 0) {
      _attackCooldown -= dt;
    }
    
    // Handle input
    _handleMovement(dt);
    _handleAttack();
    
    // Update state
    _updateState();
  }
  
  void _handleMovement(double dt) {
    final moveDirection = inputHandler.getMovementDirection();
    
    if (moveDirection.x == 0 && moveDirection.y == 0) {
      _isMoving = false;
      return;
    }
    
    _isMoving = true;
    
    // Update facing direction
    if (moveDirection.x.abs() > moveDirection.y.abs()) {
      _facing = moveDirection.x > 0 ? Direction.right : Direction.left;
    } else {
      _facing = moveDirection.y > 0 ? Direction.down : Direction.up;
    }
    
    // Calculate new position
    final speed = GameConstants.playerSpeed * dt;
    final newX = position.x + moveDirection.x * speed;
    final newY = position.y + moveDirection.y * speed;
    
    // Check collision with world
    final world = parent as game_world.World?;
    if (world != null && !world.checkTileCollision(newX, newY, size.x, size.y)) {
      position = Vector2(newX, newY);
    }
  }
  
  void _handleAttack() {
    if (inputHandler.isAttackPressed() && 
        _attackCooldown <= 0 && 
        gameState.hasSword) {
      _attackCooldown = GameConstants.playerAttackCooldown;
      _state = PlayerState.attacking;
      
      // TODO: Create attack hitbox and check for enemy collisions
    }
  }
  
  void _updateState() {
    if (_state == PlayerState.attacking && _attackCooldown <= 0) {
      _state = _isMoving ? PlayerState.walking : PlayerState.idle;
    } else if (_state != PlayerState.attacking) {
      _state = _isMoving ? PlayerState.walking : PlayerState.idle;
    }
  }
  
  /// Take damage
  void takeDamage(int amount) {
    if (_state == PlayerState.hurt) return; // Invincibility frames
    
    gameState.takeDamage(amount);
    _state = PlayerState.hurt;
    
    // Reset hurt state after a short time
    Future.delayed(const Duration(milliseconds: 500), () {
      if (_state == PlayerState.hurt) {
        _state = PlayerState.idle;
      }
    });
  }
  
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    // Simple rectangle rendering for now
    final paint = Paint()
      ..color = _getPlayerColor()
      ..style = PaintingStyle.fill;
    
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.x, size.y),
      paint,
    );
    
    // Draw direction indicator
    final directionPaint = Paint()
      ..color = const Color(0xFFFF0000)
      ..style = PaintingStyle.fill;
    
    switch (_facing) {
      case Direction.up:
        canvas.drawCircle(Offset(size.x / 2, 0), 3, directionPaint);
        break;
      case Direction.down:
        canvas.drawCircle(Offset(size.x / 2, size.y), 3, directionPaint);
        break;
      case Direction.left:
        canvas.drawCircle(Offset(0, size.y / 2), 3, directionPaint);
        break;
      case Direction.right:
        canvas.drawCircle(Offset(size.x, size.y / 2), 3, directionPaint);
        break;
    }
  }
  
  Color _getPlayerColor() {
    switch (_state) {
      case PlayerState.idle:
        return const Color(0xFF4A90E2);
      case PlayerState.walking:
        return const Color(0xFF357ABD);
      case PlayerState.attacking:
        return const Color(0xFFFFD700);
      case PlayerState.hurt:
        return const Color(0xFFFF0000);
    }
  }
}

