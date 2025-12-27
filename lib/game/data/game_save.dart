import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'game_state.dart';

/// Save game data structure
class GameSave {
  final int currentHealth;
  final int maxHealth;
  final int rupees;
  final int keys;
  final bool hasSword;
  final bool hasShield;
  final int currentLevel;
  final Map<String, int> inventory;
  final double playerX;
  final double playerY;
  
  GameSave({
    required this.currentHealth,
    required this.maxHealth,
    required this.rupees,
    required this.keys,
    required this.hasSword,
    required this.hasShield,
    required this.currentLevel,
    required this.inventory,
    required this.playerX,
    required this.playerY,
  });
  
  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'currentHealth': currentHealth,
      'maxHealth': maxHealth,
      'rupees': rupees,
      'keys': keys,
      'hasSword': hasSword,
      'hasShield': hasShield,
      'currentLevel': currentLevel,
      'inventory': inventory,
      'playerX': playerX,
      'playerY': playerY,
    };
  }
  
  /// Create from JSON
  factory GameSave.fromJson(Map<String, dynamic> json) {
    return GameSave(
      currentHealth: json['currentHealth'] as int,
      maxHealth: json['maxHealth'] as int,
      rupees: json['rupees'] as int,
      keys: json['keys'] as int,
      hasSword: json['hasSword'] as bool,
      hasShield: json['hasShield'] as bool,
      currentLevel: json['currentLevel'] as int,
      inventory: Map<String, int>.from(json['inventory'] as Map),
      playerX: (json['playerX'] as num).toDouble(),
      playerY: (json['playerY'] as num).toDouble(),
    );
  }
}

/// Save/load system
class SaveSystem {
  static const String _saveKey = 'aria_save_game';
  
  /// Save game state
  static Future<bool> saveGame(
    GameState gameState,
    double playerX,
    double playerY,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Convert inventory to JSON-serializable format
      final inventoryMap = <String, int>{};
      gameState.inventory.allItems.forEach((type, count) {
        inventoryMap[type.name] = count;
      });
      
      final save = GameSave(
        currentHealth: gameState.currentHealth,
        maxHealth: gameState.maxHealth,
        rupees: gameState.rupees,
        keys: gameState.keys,
        hasSword: gameState.hasSword,
        hasShield: gameState.hasShield,
        currentLevel: gameState.currentLevel,
        inventory: inventoryMap,
        playerX: playerX,
        playerY: playerY,
      );
      
      final jsonString = jsonEncode(save.toJson());
      return await prefs.setString(_saveKey, jsonString);
    } catch (e) {
      debugPrint('Error saving game: $e');
      return false;
    }
  }
  
  /// Load game state
  static Future<GameSave?> loadGame() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_saveKey);
      
      if (jsonString == null) {
        return null;
      }
      
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return GameSave.fromJson(json);
    } catch (e) {
      debugPrint('Error loading game: $e');
      return null;
    }
  }
  
  /// Check if save exists
  static Future<bool> hasSaveGame() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_saveKey);
  }
  
  /// Delete save game
  static Future<bool> deleteSaveGame() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_saveKey);
    } catch (e) {
      debugPrint('Error deleting save game: $e');
      return false;
    }
  }
}

