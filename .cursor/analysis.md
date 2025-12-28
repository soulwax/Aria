# Aria - Codebase Analysis

## Project Overview

**Aria** is a top-down Zelda-like action-adventure game built with Flutter and the Flame game engine. The game features a player character that can move around a tile-based world, fight enemies, collect items, and manage inventory.

## Main Features

### Core Gameplay
- **Player Movement**: WASD/Arrow key controls with smooth movement and collision detection
- **Combat System**: Player can attack enemies with a sword (when acquired), enemies can attack the player
- **Enemy AI**: Multiple enemy types (Slime, Skeleton) with pathfinding toward the player
- **Item Collection**: Collectible items including hearts (health), rupees (currency), keys, bombs, sword, and shield
- **Inventory System**: Player inventory management with item tracking
- **Health System**: Player health with damage/healing mechanics
- **Pause Menu**: Game can be paused with ESC key

### World & Environment
- **Tile-based World**: 20x15 tile map with different tile types (grass, wall, water, door, floor, stairs)
- **Collision Detection**: Tile-based collision system preventing movement through walls
- **Camera System**: Camera follows the player character
- **Test Map**: Currently uses a procedurally generated test map with walls

### UI Systems
- **HUD (Heads-Up Display)**: Shows health bar, rupee count, key count, and equipped items
- **Pause Menu**: Overlay menu when game is paused
- **Dialogue System**: Dialogue box component (structure exists)

### Save System
- **Game Saving**: Save/load functionality using SharedPreferences
- **Persistent Data**: Saves player position, health, inventory, rupees, keys, and equipment

## File Structure

```
lib/
├── main.dart                    # App entry point, sets up Provider and MaterialApp
├── game/
│   ├── aria_game.dart          # Main game class (FlameGame)
│   ├── data/
│   │   ├── constants.dart      # Game constants (speeds, sizes, etc.)
│   │   ├── game_state.dart     # Central game state (ChangeNotifier)
│   │   ├── game_save.dart      # Save/load system
│   │   └── player_inventory.dart # Inventory management
│   ├── entities/
│   │   ├── player.dart         # Player character component
│   │   ├── enemy.dart          # Base enemy class
│   │   ├── enemy_types.dart    # Specific enemy implementations (Slime, Skeleton)
│   │   ├── item.dart           # Collectible items
│   │   └── projectile.dart     # Projectile system (arrows, magic)
│   ├── systems/
│   │   ├── input_handler.dart  # Keyboard input handling
│   │   ├── physics.dart        # Physics and collision utilities
│   │   ├── collision.dart     # Collision detection system
│   │   ├── animation.dart      # Sprite animation system
│   │   └── particle_system.dart # Visual effects particles
│   ├── ui/
│   │   ├── hud.dart            # Heads-up display
│   │   ├── pause_menu.dart     # Pause menu overlay
│   │   ├── dialogue_box.dart # Dialogue system
│   │   └── menu.dart            # Menu system
│   └── world/
│       ├── world.dart          # World manager (entities, tilemap)
│       ├── tile_map.dart       # Tile map system
│       └── tiles.dart          # Tile type definitions
├── widgets/
│   └── game_widget.dart        # Flutter widget wrapper for Flame game
└── utils/
    ├── helpers.dart            # Utility functions (distance, normalize, etc.)
    └── extensions.dart         # Dart extensions
```

## Key Technologies

### Core Framework
- **Flutter**: UI framework and app structure
- **Flame** (v1.8.0): 2D game engine built for Flutter
  - Component-based architecture
  - Built-in collision detection
  - Sprite and animation support
  - Camera system

### State Management
- **Provider** (v6.0.0): State management using ChangeNotifier pattern
  - `GameState` class manages all game state
  - Reactive UI updates through `notifyListeners()`

### Data Persistence
- **SharedPreferences** (v2.2.0): Local storage for save games
- **Path Provider** (v2.1.0): File system paths

### Audio
- **Flame Audio** (v2.1.0): Audio playback system (configured but not actively used in current code)

### Utilities
- **UUID** (v4.0.0): Unique identifier generation

### Development Tools
- **Flutter Lints** (v6.0.0): Code quality and linting
- **Build Runner** (v2.4.0): Code generation
- **JSON Serializable** (v6.7.0): JSON serialization (for save system)

## Architecture Patterns

### Component-Based Architecture (Flame)
- All game entities extend `PositionComponent` or `Component`
- Uses Flame's component tree system
- Components can be added/removed dynamically

### Entity-Component-System (ECS) Style
- **Entities**: Player, Enemy, Item, Projectile
- **Components**: Position, Collision, Rendering
- **Systems**: Physics, Collision, Input, Animation

### State Management Pattern
- Centralized `GameState` class using Provider pattern
- Reactive updates through `ChangeNotifier`
- Game state includes: health, rupees, keys, equipment, inventory, level, pause state

### System Pattern
- Separate system classes for different concerns:
  - `InputHandler`: Handles all input
  - `CollisionSystem`: Manages collision detection
  - `Physics`: Physics utilities
  - `AnimationSystem`: Animation helpers
  - `ParticleSystem`: Visual effects

### World Manager Pattern
- `World` class manages all entities (player, enemies, items)
- Centralized entity management
- Tile map integration

## Notable Patterns & Design Decisions

### 1. Direction-Based Movement
- Uses `Direction` enum (up, down, left, right)
- Player facing direction tracked separately from movement
- Diagonal movement normalized to prevent faster movement

### 2. State-Based Player Actions
- `PlayerState` enum: idle, walking, attacking, hurt
- State transitions managed in player update loop
- Invincibility frames during hurt state

### 3. Enemy AI Pattern
- Base `Enemy` class with abstract `_updateAI()` method
- Each enemy type (Slime, Skeleton) implements its own AI
- Detection range and movement speed vary by enemy type

### 4. Item Collection
- Items auto-collect when player is within pickup range
- Items modify game state directly (heal, add rupees, etc.)
- Items removed from world after collection

### 5. Collision Detection
- AABB (Axis-Aligned Bounding Box) collision for entities
- Tile-based collision for world boundaries
- Multi-point collision checking (corners + center)

### 6. Camera Following
- Camera follows player using Flame's built-in camera system
- Camera anchored to center for consistent view

## Current Implementation Status

### ✅ Implemented
- Basic player movement and controls
- Enemy spawning and AI (Slime, Skeleton)
- Item collection system
- Health and inventory management
- HUD display
- Pause menu
- Save/load system structure
- Tile-based world with collision
- Basic rendering (colored rectangles for entities)

### 🚧 Partially Implemented / TODO
- **Attack System**: Attack hitbox creation and enemy damage (marked with TODO)
- **Sprite Rendering**: Currently using colored rectangles, sprite system exists but not integrated
- **Animation System**: Animation system exists but not actively used
- **Particle Effects**: Basic particle system exists but not integrated
- **Projectile System**: Projectile class exists but not used in combat
- **Dialogue System**: Dialogue box component exists but not integrated
- **Audio**: Flame Audio configured but no audio files/implementation
- **Game Reset**: Reset function exists but incomplete
- **Boss Enemies**: Boss enemy type defined but not implemented
- **Multiple Levels**: Level system exists but only one level

## Dependencies Summary

### Production Dependencies
- `flutter`: SDK
- `cupertino_icons`: ^1.0.8
- `flame`: ^1.8.0 (Game engine)
- `flame_audio`: ^2.1.0 (Audio)
- `provider`: ^6.0.0 (State management)
- `shared_preferences`: ^2.2.0 (Local storage)
- `path_provider`: ^2.1.0 (File paths)
- `uuid`: ^4.0.0 (UUID generation)

### Dev Dependencies
- `flutter_test`: SDK
- `flutter_lints`: ^6.0.0 (Linting)
- `build_runner`: ^2.4.0 (Code generation)
- `json_serializable`: ^6.7.0 (JSON serialization)

## Platform Support

The project is configured for:
- **Android**: Full configuration with Kotlin
- **iOS**: Full configuration with Swift
- **Web**: Basic web support
- **Windows**: CMake configuration

## Asset Organization

Assets are organized in `assets/` directory:
- `tilesets/`: Tile graphics
- `sprites/`: Character and entity sprites
- `effects/`: Visual effects
- `ui/`: UI elements
- `audio/`: Sound effects and music

## Code Quality

- Uses Flutter Lints for code quality
- Follows Dart style guidelines
- Component-based architecture promotes reusability
- Separation of concerns (systems, entities, UI)
- Type-safe enums for game constants

## Future Development Notes

1. **Sprite Integration**: Replace colored rectangles with actual sprites
2. **Animation Integration**: Connect animation system to entities
3. **Combat Completion**: Implement attack hitboxes and damage dealing
4. **Audio Integration**: Add sound effects and background music
5. **Level System**: Implement multiple levels/rooms
6. **Boss Battles**: Implement boss enemy type
7. **Dialogue System**: Integrate dialogue for NPCs/story
8. **Projectile Combat**: Add ranged weapons
9. **Particle Effects**: Integrate particles for visual feedback
10. **Save/Load UI**: Add menu for save/load operations

