import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import '../data/constants.dart';

/// Animation system for sprite animations
class AnimationSystem {
  /// Create sprite animation from sprite sheet
  static SpriteAnimation createAnimation(
    SpriteSheet spriteSheet,
    int startFrame,
    int endFrame,
    double stepTime,
  ) {
    return spriteSheet.createAnimation(
      row: 0,
      stepTime: stepTime,
      from: startFrame,
      to: endFrame,
    );
  }
  
  /// Create animation from individual sprites
  static SpriteAnimation createAnimationFromSprites(
    List<Sprite> sprites,
    double stepTime,
  ) {
    return SpriteAnimation.spriteList(
      sprites,
      stepTime: stepTime,
      loop: true,
    );
  }
}

