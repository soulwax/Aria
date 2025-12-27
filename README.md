# Aria - Zelda-like Game

A top-down Zelda-like game built with Flutter and Flame game engine.

## Project Structure

```
lib/
├── main.dart                          # App entry point
├── game/
│   ├── aria_game.dart                # Main Flame game class
│   ├── world/                        # World and tilemap system
│   ├── entities/                     # Game entities (player, enemies, items)
│   ├── systems/                      # Game systems (collision, input, physics)
│   ├── ui/                           # UI components (HUD, menus, dialogue)
│   └── data/                         # Game state and data management
├── widgets/                          # Flutter widget wrappers
└── utils/                            # Utility functions and extensions
```

## Features

- ✅ Top-down camera system
- ✅ Player movement (WASD/Arrow keys)
- ✅ Enemy AI with pathfinding
- ✅ Collision detection
- ✅ Health and inventory system
- ✅ Item collection system
- ✅ HUD display
- ✅ Pause menu
- ✅ Save/load system (ready for implementation)

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK

### Installation

1. Install dependencies:
```bash
flutter pub get
```

2. Run the game:
```bash
flutter run
```

### Controls

- **WASD** or **Arrow Keys**: Move player
- **Space**: Attack (when sword is equipped)
- **E**: Interact
- **ESC**: Pause/Resume

## Development Status

### Phase 1: Foundation ✅
- [x] Project initialization
- [x] Basic game loop
- [x] Player movement
- [x] Tilemap system
- [x] Input handling

### Phase 2: Game Systems ✅
- [x] Enemy system
- [x] Collision detection
- [x] Combat mechanics
- [x] HUD display

### Phase 3: Content & Polish (In Progress)
- [ ] Sprite animations
- [ ] Multiple enemy types
- [ ] Item usage system
- [ ] NPC dialogue system
- [ ] Visual effects

### Phase 4: Advanced Features (Planned)
- [ ] Boss encounters
- [ ] Save/load system integration
- [ ] Inventory management UI
- [ ] Mini-map
- [ ] Audio (music and SFX)

## Assets

Place game assets in the following directories:
- `assets/tilesets/` - Tilemap textures
- `assets/sprites/` - Character and enemy sprites
- `assets/effects/` - Particle effect textures
- `assets/ui/` - UI elements and icons
- `assets/audio/` - Music and sound effects

## Building

### Android
```bash
flutter build apk
```

### iOS
```bash
flutter build ios
```

### Windows
```bash
flutter build windows
```

### Web
```bash
flutter build web
```

## License

This project is for educational purposes.
