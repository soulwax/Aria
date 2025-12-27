import '../data/constants.dart';

/// Player inventory management
class PlayerInventory {
  final Map<ItemType, int> _items = {};
  
  /// Add item to inventory
  void addItem(ItemType type, [int quantity = 1]) {
    _items[type] = (_items[type] ?? 0) + quantity;
  }
  
  /// Remove item from inventory
  bool removeItem(ItemType type, [int quantity = 1]) {
    final current = _items[type] ?? 0;
    if (current >= quantity) {
      _items[type] = current - quantity;
      if (_items[type] == 0) {
        _items.remove(type);
      }
      return true;
    }
    return false;
  }
  
  /// Get item count
  int getItemCount(ItemType type) {
    return _items[type] ?? 0;
  }
  
  /// Check if has item
  bool hasItem(ItemType type) {
    return (_items[type] ?? 0) > 0;
  }
  
  /// Clear all items
  void clear() {
    _items.clear();
  }
  
  /// Get all items
  Map<ItemType, int> get allItems => Map.unmodifiable(_items);
}

