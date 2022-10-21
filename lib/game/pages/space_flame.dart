import 'dart:async';
import 'dart:math';

import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:space_flame/game/sprites/enemy.dart';
import 'package:space_flame/game/sprites/ship.dart';
import 'package:space_flame/game/style.dart';
import 'package:space_flame/utils/tap_handler.dart';

class SpaceFlame extends FlameGame
    with HasDraggableComponents, HasCollisionDetection, HasTappableComponents {
  late Ship ship;
  late TapHandler tapHandler;
  late List<Enemy> enemy = List.empty(growable: true);
  double respawnTime = 1;
  double timePassed = 0;
  Random random = Random();
  bool pause = false;

  @override
  Future<void> onLoad() async {
    ship = Ship()
      ..position = Vector2(size.x / 2, size.y / 2)
      ..size = Vector2(64, 64)
      ..setSpeed(500);
    ship.anchor = Anchor.center;
    await addAll([
      Background(const Color.fromARGB(255, 2, 0, 23)),
      ship,
      tapHandler = TapHandler(),
    ]);
  }

  @override
  /* void render(Canvas canvas) {
    canvas.drawRect(canvasSize.toRect(), Paint()..color = Palette.buttonBlu);
    super.render(canvas);
  } */

  @override
  void update(double dt) {
    super.update(dt);
    if (pause) {
      return;
    }
    for (int i = 0; i < enemy.length; i++) {
      Enemy e = enemy.elementAt(i);
      e.move(dt);
      if (e.getCollidingInfo()) {
        print("colliding in main");
        pause = true;
        for (Enemy e in enemy) {
          e.stopSprite();
        }
        ship.stopSprite();
        pauseEngine();
      }
      if (e.getPosition().y - e.size.y < canvasSize.y) {
        continue;
      }
      enemy.removeAt(i);
      remove(e);
      i--;
    }
    timePassed += dt;
    if (timePassed >= respawnTime) {
      enemy.add(Enemy()
        ..position = Vector2(random.nextInt(size.x.toInt() - 20) + 20, 0)
        ..setSpeed(random.nextInt(500) + 100));
      timePassed = 0;
      add(
        enemy.last,
      );
    }
    if (tapHandler.tapped) {
      if ((tapHandler.tapPosition.x - ship.position.x).abs() > 2 &&
          (tapHandler.tapPosition.y - ship.position.y).abs() > 2) {
        Vector2 moveDirection = Vector2(
            tapHandler.tapPosition.x - ship.position.x,
            tapHandler.tapPosition.y - ship.position.y);
        ship.setMoveDirection(moveDirection);
      } else {
        ship.setMoveDirection(Vector2.zero());
      }
    } else {
      ship.setMoveDirection(Vector2.zero());
    }
    ship.move(dt);
  }
}
