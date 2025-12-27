import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'dart:ui';

/// Particle system for visual effects
class ParticleSystem extends Component {
  /// Create explosion effect
  static void createExplosion(Vector2 position, Component parent) {
    for (int i = 0; i < 10; i++) {
      final particle = Particle(position: position);
      parent.add(particle);
    }
  }
}

/// Simple particle component
class Particle extends PositionComponent {
  final Vector2 velocity;
  final double lifetime;
  double _age = 0.0;
  
  Particle({
    required Vector2 position,
    Vector2? velocity,
    this.lifetime = 0.5,
  })  : velocity = velocity ?? Vector2.zero(),
        super(position: position, size: Vector2(4, 4));
  
  @override
  void update(double dt) {
    super.update(dt);
    
    _age += dt;
    if (_age >= lifetime) {
      removeFromParent();
      return;
    }
    
    position += velocity * dt;
  }
  
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    final alpha = 1.0 - (_age / lifetime);
    final paint = Paint()
      ..color = Color.fromRGBO(255, 255, 0, alpha)
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      size.x / 2,
      paint,
    );
  }
}

