import 'package:flame/components.dart';
import 'entities/player.dart';
import 'entities/enemy.dart';
import 'entities/item.dart';
import 'tile_map.dart';

/// World manager - handles all entities and world state
class World extends Component {
  late TileMap _tileMap;
  final List<Enemy> _enemies = [];
  final List<Item> _items = [];
  Player? _player;
  
  TileMap get tileMap => _tileMap;
  List<Enemy> get enemies => List.unmodifiable(_enemies);
  List<Item> get items => List.unmodifiable(_items);
  Player? get player => _player;
  
  @override
  Future<void> onLoad() async {
    super.onLoad();
    _tileMap = TileMap.createTestMap();
  }
  
  /// Initialize world with player
  void initialize(Player player) {
    _player = player;
    add(player);
  }
  
  /// Add enemy to world
  void addEnemy(Enemy enemy) {
    _enemies.add(enemy);
    add(enemy);
  }
  
  /// Remove enemy from world
  void removeEnemy(Enemy enemy) {
    _enemies.remove(enemy);
    remove(enemy);
  }
  
  /// Add item to world
  void addItem(Item item) {
    _items.add(item);
    add(item);
  }
  
  /// Remove item from world
  void removeItem(Item item) {
    _items.remove(item);
    remove(item);
  }
  
  /// Check collision with tiles
  bool checkTileCollision(double x, double y, double width, double height) {
    // Check all four corners and center
    final positions = [
      (x, y), // top-left
      (x + width, y), // top-right
      (x, y + height), // bottom-left
      (x + width, y + height), // bottom-right
      (x + width / 2, y + height / 2), // center
    ];
    
    for (final (px, py) in positions) {
      if (!_tileMap.isWorldPositionWalkable(px, py)) {
        return true;
      }
    }
    
    return false;
  }
  
  /// Get all entities at position
  List<Component> getEntitiesAt(double x, double y, double radius) {
    final entities = <Component>[];
    
    if (_player != null) {
      final dx = _player!.position.x - x;
      final dy = _player!.position.y - y;
      if (dx * dx + dy * dy <= radius * radius) {
        entities.add(_player!);
      }
    }
    
    for (final enemy in _enemies) {
      final dx = enemy.position.x - x;
      final dy = enemy.position.y - y;
      if (dx * dx + dy * dy <= radius * radius) {
        entities.add(enemy);
      }
    }
    
    for (final item in _items) {
      final dx = item.position.x - x;
      final dy = item.position.y - y;
      if (dx * dx + dy * dy <= radius * radius) {
        entities.add(item);
      }
    }
    
    return entities;
  }
}

