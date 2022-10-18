import 'dart:ui';

import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/particles.dart';
import 'package:space_flame/game/sprites/ship.dart';
import 'package:space_flame/game/style.dart';
import 'package:space_flame/utils/tap_handler.dart';

class SpaceFlame extends FlameGame with HasTappableComponents {
  late Ship ship;
  late TapHandler tapHandler;
  @override
  Future<void> onLoad() async {
    ship = Ship()
      ..position = Vector2(size.x / 2, size.y / 2)
      ..size = Vector2(64, 64)
      ..setSpeed(100);
    tapHandler = TapHandler();
    ship.anchor = Anchor.center;
    await addAll([
      Background(Palette.background),
      ship,
      tapHandler,
    ]);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(canvasSize.toRect(), Paint()..color = Palette.buttonBlu);
  }

  @override
  void update(double dt) {
    // TODO: implement update
    if (tapHandler.tapped) {
      print('tapped');
      Vector2 moveDirection = Vector2(
          tapHandler.tapPosition.x - ship.position.x,
          tapHandler.tapPosition.y - ship.position.y);
      ship.setMoveDirection(moveDirection);
    } else {
      ship.setMoveDirection(Vector2.zero());
    }
    super.update(dt);
  }
}
