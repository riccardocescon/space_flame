import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:space_flame/game/router_game.dart';

void main() {
  final game = RouterGame();
  runApp(
    GameWidget(
      game: game,
    ),
  );
}
