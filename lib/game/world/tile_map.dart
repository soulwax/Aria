import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import '../data/constants.dart';
import 'tiles.dart';

/// Tilemap system for rendering and collision
class TileMap {
  final int width;
  final int height;
  final List<List<Tile>> _tiles;
  
  TileMap({
    required this.width,
    required this.height,
  }) : _tiles = List.generate(
          height,
          (_) => List.generate(width, (_) => Tile.fromType(TileType.grass)),
        );
  
  /// Get tile at position
  Tile getTile(int x, int y) {
    if (x < 0 || x >= width || y < 0 || y >= height) {
      return Tile.fromType(TileType.wall); // Out of bounds = wall
    }
    return _tiles[y][x];
  }
  
  /// Set tile at position
  void setTile(int x, int y, TileType type) {
    if (x < 0 || x >= width || y < 0 || y >= height) return;
    _tiles[y][x] = Tile.fromType(type);
  }
  
  /// Check if position is walkable
  bool isWalkable(int x, int y) {
    return getTile(x, y).isWalkable;
  }
  
  /// Check if position is solid (collision)
  bool isSolid(int x, int y) {
    return getTile(x, y).isSolid;
  }
  
  /// Check if world position is walkable
  bool isWorldPositionWalkable(double x, double y) {
    final tileX = (x / GameConstants.tileSize).floor();
    final tileY = (y / GameConstants.tileSize).floor();
    return isWalkable(tileX, tileY);
  }
  
  /// Create a simple test map
  static TileMap createTestMap() {
    final map = TileMap(width: GameConstants.worldWidth, height: GameConstants.worldHeight);
    
    // Create walls around the edges
    for (int x = 0; x < map.width; x++) {
      map.setTile(x, 0, TileType.wall);
      map.setTile(x, map.height - 1, TileType.wall);
    }
    for (int y = 0; y < map.height; y++) {
      map.setTile(0, y, TileType.wall);
      map.setTile(map.width - 1, y, TileType.wall);
    }
    
    // Add some interior walls
    for (int x = 5; x < 10; x++) {
      map.setTile(x, 5, TileType.wall);
    }
    for (int y = 7; y < 12; y++) {
      map.setTile(15, y, TileType.wall);
    }
    
    return map;
  }
}

