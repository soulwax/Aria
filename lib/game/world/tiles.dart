import '../data/constants.dart';

/// Tile types for the game world
enum TileType {
  grass,
  wall,
  water,
  door,
  floor,
  stairs,
}

/// Tile data structure
class Tile {
  final TileType type;
  final bool isSolid;
  final bool isWalkable;
  
  const Tile({
    required this.type,
    required this.isSolid,
    required this.isWalkable,
  });
  
  /// Get tile properties based on type
  static Tile fromType(TileType type) {
    switch (type) {
      case TileType.grass:
        return const Tile(type: TileType.grass, isSolid: false, isWalkable: true);
      case TileType.wall:
        return const Tile(type: TileType.wall, isSolid: true, isWalkable: false);
      case TileType.water:
        return const Tile(type: TileType.water, isSolid: false, isWalkable: false);
      case TileType.door:
        return const Tile(type: TileType.door, isSolid: true, isWalkable: false);
      case TileType.floor:
        return const Tile(type: TileType.floor, isSolid: false, isWalkable: true);
      case TileType.stairs:
        return const Tile(type: TileType.stairs, isSolid: false, isWalkable: true);
    }
  }
}

