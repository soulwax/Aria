import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import '../game/aria_game.dart';

/// Flutter widget wrapper for the Flame game
class AriaGameWidget extends StatelessWidget {
  final AriaGame game;
  
  const AriaGameWidget({
    super.key,
    required this.game,
  });
  
  @override
  Widget build(BuildContext context) {
    return GameWidget.controlled(gameFactory: () => game);
  }
}

