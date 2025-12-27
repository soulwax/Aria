import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' show KeyEventResult;
import 'data/constants.dart';
import 'data/game_state.dart';
import 'systems/input_handler.dart';
import 'entities/player.dart';
import 'entities/enemy_types.dart';
import 'entities/item.dart';
import 'world/world.dart' as game_world;
import 'ui/hud.dart';
import 'ui/pause_menu.dart';
import 'systems/collision.dart';

/// Main game class extending Flame's Game
class AriaGame extends FlameGame with HasKeyboardHandlerComponents {
  late GameState gameState;
  late InputHandler inputHandler;
  late game_world.World gameWorld;
  late Player player;
  late HUD hud;
  
  @override
  Future<void> onLoad() async {
    super.onLoad();
    
    // Initialize game state
    gameState = GameState();
    
    // Initialize input handler
    inputHandler = InputHandler();
    
    // Initialize world
    gameWorld = game_world.World();
    await add(gameWorld);
    
    // Initialize player
    player = Player(
      gameState: gameState,
      inputHandler: inputHandler,
      position: Vector2(
        GameConstants.gameWidth / 2,
        GameConstants.gameHeight / 2,
      ),
    );
    gameWorld.initialize(player);
    
    // Initialize HUD
    hud = HUD(gameState: gameState);
    await add(hud);
    
    // Set up camera to follow player
    camera.follow(player);
    camera.viewfinder.anchor = Anchor.center;
    
    // Spawn some test enemies
    _spawnTestEnemies();
    
    // Spawn some test items
    _spawnTestItems();
  }
  
  void _spawnTestEnemies() {
    // Spawn a few slimes
    for (int i = 0; i < 3; i++) {
      final slime = Slime(
        position: Vector2(
          200 + i * 100,
          200 + i * 50,
        ),
      );
      gameWorld.addEnemy(slime);
    }
    
    // Spawn a skeleton
    final skeleton = Skeleton(
      position: Vector2(400, 300),
    );
    gameWorld.addEnemy(skeleton);
  }
  
  void _spawnTestItems() {
    // Spawn some hearts
    for (int i = 0; i < 2; i++) {
      final heart = Item(
        type: ItemType.heart,
        position: Vector2(150 + i * 50, 150),
      );
      gameWorld.addItem(heart);
    }
    
    // Spawn some rupees
    for (int i = 0; i < 3; i++) {
      final rupee = Item(
        type: ItemType.rupee,
        position: Vector2(300 + i * 40, 400),
      );
      gameWorld.addItem(rupee);
    }
    
    // Spawn a key
    final key = Item(
      type: ItemType.key,
      position: Vector2(500, 200),
    );
    gameWorld.addItem(key);
    
    // Spawn sword
    final sword = Item(
      type: ItemType.sword,
      position: Vector2(600, 300),
    );
    gameWorld.addItem(sword);
  }
  
  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is KeyDownEvent) {
      inputHandler.onKeyDown(event);
    } else if (event is KeyUpEvent) {
      inputHandler.onKeyUp(event);
      
      // Handle pause
      if (event.logicalKey == LogicalKeyboardKey.escape) {
        gameState.togglePause();
        if (gameState.isPaused) {
          add(PauseMenu(gameState: gameState));
        } else {
          final pauseMenus = children.whereType<PauseMenu>().toList();
          for (final menu in pauseMenus) {
            menu.removeFromParent();
          }
        }
      }
    }
    
    return super.onKeyEvent(event, keysPressed);
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    if (gameState.isPaused) return;
    
    // Update collision checks
    if (gameWorld.player != null) {
      CollisionSystem.checkPlayerEnemyCollisions(player, gameWorld);
      CollisionSystem.checkPlayerItemCollisions(player, gameWorld);
    }
  }
  
  /// Reset game
  void resetGame() {
    gameState.reset();
    // TODO: Reset player position, respawn enemies, etc.
  }
}

