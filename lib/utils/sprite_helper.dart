import 'package:flame/input.dart';

class SpriteHelper {
  static Map<String, List<Vector2>> hitBox = {
    'sprites/ships/ship_001.png': [
      Vector2(0.0, -1.0),
      Vector2(-0.8, 0.4),
      Vector2(-0.4, 0.9),
      Vector2(0.4, 0.9),
      Vector2(0.8, 0.4),
    ],
  };
  static const String ship = "sprites/ships/ship_001.png";
  static const String enemy = "sprites/ships/ship_020.png";
}
