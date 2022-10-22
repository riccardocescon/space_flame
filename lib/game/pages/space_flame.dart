import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../sprites/enemy.dart';
import '../sprites/ship.dart';
import '../style.dart';

class SpaceFlameGame extends StatefulWidget {
  const SpaceFlameGame({super.key});

  @override
  State<SpaceFlameGame> createState() => _SpaceFlameGameState();
}

class _SpaceFlameGameState extends State<SpaceFlameGame> {
  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: SpaceFlame(),
    );
  }
}

class SpaceFlame extends FlameGame
    with HasDraggableComponents, HasTappableComponents, HasCollisionDetection {
  late Ship ship;
  //late TapHandler tapHandler;
  List<Enemy> enemy = [];
  double respawnTime = 1;
  double timePassed = 0;
  math.Random random = math.Random();
  bool pause = false;
  final double inputTreshold = 1.5;

  late Vector2 touchPosition;

  @override
  Future<void> onLoad() async {
    ship = Ship()
      ..position = Vector2(size.x / 2, size.y / 2)
      ..size = Vector2(64, 64)
      ..setSpeed(500);
    ship.anchor = Anchor.center;
    touchPosition = ship.position;
    await addAll([
      Background(const Color.fromARGB(255, 2, 0, 23)),
      ship,
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
      Enemy e = enemy[i];
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
      if (e.getPosition().y - e.size.y > canvasSize.y) {
        enemy.removeAt(i);
        remove(e);
        i--;
      }
    }
    timePassed += dt;
    if (timePassed >= respawnTime) {
      enemy.add(Enemy()
        ..position = Vector2(random.nextInt(size.x.toInt() - 40) + 20, 0)
        ..setSpeed(random.nextInt(500) + 100));
      timePassed = 0;
      add(
        enemy.last,
      );
    }
    Vector2 direction = touchPosition - ship.position;
    if (direction.x.abs() > inputTreshold &&
        direction.y.abs() > inputTreshold) {
      ship.setMoveDirection(direction);
    } else {
      ship.setMoveDirection(Vector2.zero());
    }
    ship.move(dt);
  }

  @override
  void onDragStart(DragStartEvent event) {
    touchPosition = event.canvasPosition;
    super.onDragStart(event);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    touchPosition = event.canvasPosition;
    super.onDragUpdate(event);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    ship.setMoveDirection(Vector2.zero());
    super.onDragEnd(event);
  }
}
