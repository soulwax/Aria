# Aria

A top-down Zelda-like action-adventure game built with Flutter and Flame.

![Version](https://img.shields.io/badge/version-1.0.0-blue)
![Flutter](https://img.shields.io/badge/Flutter-3.11.0-02569B?logo=flutter)
![Flame](https://img.shields.io/badge/Flame-1.8.0-orange)

## 🎮 Overview

Aria is a 2D action-adventure game featuring top-down gameplay, enemy combat, item collection, and exploration. Built using Flutter's cross-platform capabilities and the Flame game engine, Aria runs on Android, iOS, Web, and Windows.

## ✨ Features

### Core Gameplay
- **Player Movement**: Smooth WASD/Arrow key controls with collision detection
- **Combat System**: Attack enemies with your sword (when acquired)
- **Enemy AI**: Multiple enemy types with intelligent pathfinding
  - **Slime**: Basic enemy that chases the player
  - **Skeleton**: Stronger enemy with extended detection range
- **Item Collection**: Collect various items throughout the world
  - ❤️ **Hearts**: Restore health
  - 💎 **Rupees**: Currency for future shop system
  - 🔑 **Keys**: Unlock doors and chests
  - 💣 **Bombs**: Explosive items (inventory system)
  - ⚔️ **Sword**: Melee weapon for combat
  - 🛡️ **Shield**: Defensive equipment

### World & Environment
- **Tile-based World**: Explore a 20x15 tile map with different terrain types
- **Collision System**: Realistic physics preventing movement through walls
- **Camera System**: Smooth camera that follows the player
- **Multiple Tile Types**: Grass, walls, water, doors, floors, and stairs

### UI Systems
- **HUD (Heads-Up Display)**: Real-time display of:
  - Health bar with current/max health
  - Rupee count
  - Key count
  - Equipped items (sword, shield)
- **Pause Menu**: Pause the game anytime with ESC key
- **Dialogue System**: Framework for NPC interactions (coming soon)

### Save System
- **Game Saving**: Save your progress locally
- **Persistent Data**: Saves player position, health, inventory, and equipment

## 🎯 Controls

| Action | Keyboard |
|--------|----------|
| Move | `W/A/S/D` or `Arrow Keys` |
| Attack | `Space` (when sword is equipped) |
| Interact | `E` |
| Pause | `ESC` |

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.11.0 or higher)
- Dart SDK (included with Flutter)
- For platform-specific builds:
  - **Android**: Android Studio with Android SDK
  - **iOS**: Xcode (macOS only)
  - **Web**: Chrome or any modern browser
  - **Windows**: Visual Studio with C++ tools

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd Aria
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the game**
   ```bash
   flutter run
   ```

### Platform-Specific Instructions

#### Android
```bash
flutter run -d android
```

#### iOS
```bash
flutter run -d ios
```

#### Web
```bash
flutter run -d chrome
```

#### Windows
```bash
flutter run -d windows
```

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry point
├── game/
│   ├── aria_game.dart          # Main game class (FlameGame)
│   ├── data/
│   │   ├── constants.dart      # Game constants
│   │   ├── game_state.dart     # Central game state
│   │   ├── game_save.dart      # Save/load system
│   │   └── player_inventory.dart
│   ├── entities/
│   │   ├── player.dart         # Player character
│   │   ├── enemy.dart          # Base enemy class
│   │   ├── enemy_types.dart    # Enemy implementations
│   │   ├── item.dart           # Collectible items
│   │   └── projectile.dart     # Projectile system
│   ├── systems/
│   │   ├── input_handler.dart  # Input handling
│   │   ├── physics.dart        # Physics utilities
│   │   ├── collision.dart     # Collision detection
│   │   ├── animation.dart     # Animation system
│   │   └── particle_system.dart
│   ├── ui/
│   │   ├── hud.dart           # Heads-up display
│   │   ├── pause_menu.dart    # Pause menu
│   │   ├── dialogue_box.dart  # Dialogue system
│   │   └── menu.dart          # Menu system
│   └── world/
│       ├── world.dart         # World manager
│       ├── tile_map.dart         # Tile map system
│       └── tiles.dart         # Tile definitions
├── widgets/
│   └── game_widget.dart       # Flutter widget wrapper
└── utils/
    ├── helpers.dart           # Utility functions
    └── extensions.dart       # Dart extensions
```

## 🛠️ Technologies

### Core
- **Flutter**: Cross-platform UI framework
- **Flame** (v1.8.0): 2D game engine for Flutter
- **Dart**: Programming language

### State Management
- **Provider** (v6.0.0): State management using ChangeNotifier pattern

### Data Persistence
- **SharedPreferences** (v2.2.0): Local storage for save games
- **Path Provider** (v2.1.0): File system paths

### Audio
- **Flame Audio** (v2.1.0): Audio playback system

### Utilities
- **UUID** (v4.0.0): Unique identifier generation

### Development Tools
- **Flutter Lints** (v6.0.0): Code quality and linting
- **Build Runner** (v2.4.0): Code generation
- **JSON Serializable** (v6.7.0): JSON serialization

## 🏗️ Architecture

Aria uses a **component-based architecture** with the following patterns:

- **Entity-Component-System (ECS)**: Entities (Player, Enemy, Item) with components (Position, Collision, Rendering)
- **System Pattern**: Separate systems for Input, Physics, Collision, Animation
- **State Management**: Centralized `GameState` using Provider pattern
- **World Manager**: Centralized entity and world management

## 🎨 Assets

Game assets are organized in the `assets/` directory:

- `tilesets/`: Tile graphics for the world
- `sprites/`: Character and entity sprites
- `effects/`: Visual effects
- `ui/`: UI elements and icons
- `audio/`: Sound effects and music

## 🧪 Development

### Running in Debug Mode
```bash
flutter run
```

### Running in Release Mode
```bash
flutter run --release
```

### Building for Production

#### Android APK
```bash
flutter build apk --release
```

#### Android App Bundle
```bash
flutter build appbundle --release
```

#### iOS
```bash
flutter build ios --release
```

#### Web
```bash
flutter build web --release
```

#### Windows
```bash
flutter build windows --release
```

### Code Analysis
```bash
flutter analyze
```

### Running Tests
```bash
flutter test
```

## 📝 Current Status

### ✅ Implemented
- Player movement and controls
- Enemy AI and spawning
- Item collection system
- Health and inventory management
- HUD display
- Pause menu
- Save/load system structure
- Tile-based world with collision
- Basic rendering system

### 🚧 In Progress / Planned
- [ ] Sprite rendering (currently using colored rectangles)
- [ ] Complete attack system with hitboxes
- [ ] Animation integration
- [ ] Audio integration
- [ ] Particle effects
- [ ] Dialogue system integration
- [ ] Multiple levels/rooms
- [ ] Boss battles
- [ ] Projectile combat
- [ ] Shop system
- [ ] Save/load UI

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is currently not published. See `pubspec.yaml` for details (`publish_to: 'none'`).

## 🙏 Acknowledgments

- Built with [Flutter](https://flutter.dev/)
- Game engine: [Flame](https://flame-engine.org/)
- Inspired by classic Zelda games

## 📧 Contact

For questions or suggestions, please open an issue on the repository.

---

**Enjoy playing Aria!** 🎮✨

