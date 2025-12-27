/// Game constants and configuration values
class GameConstants {
  // Screen and camera settings
  static const double gameWidth = 800.0;
  static const double gameHeight = 600.0;
  static const double tileSize = 32.0;
  
  // Player settings
  static const double playerSpeed = 150.0; // pixels per second
  static const double playerAttackRange = 40.0;
  static const double playerAttackCooldown = 0.5; // seconds
  static const int playerMaxHealth = 6;
  static const int playerStartingHealth = 3;
  
  // Enemy settings
  static const double enemySpeed = 80.0;
  static const double enemyDetectionRange = 200.0;
  static const double enemyAttackRange = 30.0;
  static const double enemyAttackCooldown = 1.5;
  
  // Item settings
  static const double itemPickupRange = 20.0;
  
  // Animation settings
  static const double animationSpeed = 0.1; // seconds per frame
  
  // Collision settings
  static const double collisionBuffer = 2.0;
  
  // Game world settings
  static const int worldWidth = 20; // tiles
  static const int worldHeight = 15; // tiles
  
  // UI settings
  static const double hudPadding = 10.0;
  static const double healthBarWidth = 200.0;
  static const double healthBarHeight = 20.0;
}

/// Direction enum for movement and facing
enum Direction {
  up,
  down,
  left,
  right,
}

/// Player animation states
enum PlayerState {
  idle,
  walking,
  attacking,
  hurt,
}

/// Enemy types
enum EnemyType {
  slime,
  skeleton,
  boss,
}

/// Item types
enum ItemType {
  heart,
  rupee,
  key,
  bomb,
  sword,
  shield,
}

