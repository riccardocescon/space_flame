import 'package:flame/game.dart';
import 'package:space_flame/game/sprites/ship.dart';

class SpaceFlame extends FlameGame {
  @override
  Future<void> onLoad() async {
    await add(Ship());
  }
}
