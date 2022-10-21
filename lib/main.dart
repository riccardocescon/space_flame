import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:space_flame/game/pages/space_flame.dart';

void main() {
  final game = SpaceFlame();
  runApp(
    GameWidget(
      game: game,
    ),
  );
}
