import 'package:flutter/foundation.dart';
import 'player_inventory.dart';
import 'constants.dart';

/// Main game state management
class GameState extends ChangeNotifier {
  int _currentHealth = GameConstants.playerStartingHealth;
  int _maxHealth = GameConstants.playerMaxHealth;
  int _rupees = 0;
  int _keys = 0;
  bool _hasSword = false;
  bool _hasShield = false;
  int _currentLevel = 1;
  bool _isPaused = false;
  
  final PlayerInventory _inventory = PlayerInventory();
  
  // Getters
  int get currentHealth => _currentHealth;
  int get maxHealth => _maxHealth;
  int get rupees => _rupees;
  int get keys => _keys;
  bool get hasSword => _hasSword;
  bool get hasShield => _hasShield;
  int get currentLevel => _currentLevel;
  bool get isPaused => _isPaused;
  PlayerInventory get inventory => _inventory;
  
  /// Take damage
  void takeDamage(int amount) {
    _currentHealth = (_currentHealth - amount).clamp(0, _maxHealth);
    notifyListeners();
  }
  
  /// Heal player
  void heal(int amount) {
    _currentHealth = (_currentHealth + amount).clamp(0, _maxHealth);
    notifyListeners();
  }
  
  /// Add rupees
  void addRupees(int amount) {
    _rupees += amount;
    notifyListeners();
  }
  
  /// Spend rupees
  bool spendRupees(int amount) {
    if (_rupees >= amount) {
      _rupees -= amount;
      notifyListeners();
      return true;
    }
    return false;
  }
  
  /// Add keys
  void addKey() {
    _keys++;
    notifyListeners();
  }
  
  /// Use key
  bool useKey() {
    if (_keys > 0) {
      _keys--;
      notifyListeners();
      return true;
    }
    return false;
  }
  
  /// Acquire sword
  void acquireSword() {
    _hasSword = true;
    notifyListeners();
  }
  
  /// Acquire shield
  void acquireShield() {
    _hasShield = true;
    notifyListeners();
  }
  
  /// Advance to next level
  void nextLevel() {
    _currentLevel++;
    notifyListeners();
  }
  
  /// Toggle pause state
  void togglePause() {
    _isPaused = !_isPaused;
    notifyListeners();
  }
  
  /// Reset game state
  void reset() {
    _currentHealth = GameConstants.playerStartingHealth;
    _maxHealth = GameConstants.playerMaxHealth;
    _rupees = 0;
    _keys = 0;
    _hasSword = false;
    _hasShield = false;
    _currentLevel = 1;
    _isPaused = false;
    _inventory.clear();
    notifyListeners();
  }
}

