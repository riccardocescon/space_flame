import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:space_flame/utils/sprite_helper.dart';

import '../sprites/enemy.dart';
import '../sprites/ship.dart';
import '../style.dart';

class SpaceFlameGame extends StatefulWidget {
  const SpaceFlameGame({super.key});

  @override
  State<SpaceFlameGame> createState() => _SpaceFlameGameState();
}

class _SpaceFlameGameState extends State<SpaceFlameGame> {
  bool showFirstScreen = true;
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      setState(() {
        showFirstScreen = false;
      });
    });
    super.initState();
  }

  int life = 3;
  StateSetter? lifeSetState;
  @override
  Widget build(BuildContext context) {
    timeDilation = 5.0;
    if (showFirstScreen) {
      return firsScreen();
    }
    timeDilation = 1.0;
    return Stack(
      children: [
        GameWidget(
          game: SpaceFlame(onGameOver: gameOverDialog, onLoseLife: onLifeLose),
        ),
        const Icon(Icons.menu, size: 40, color: Colors.white),
        Align(
          alignment: Alignment.bottomRight,
          child: StatefulBuilder(
            builder: (context, lifeSetState) {
              this.lifeSetState ??= lifeSetState;
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  for (int i = 0; i < life; i++)
                    const Icon(Icons.favorite, size: 40, color: Colors.red),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  int onLifeLose() {
    lifeSetState!(() {
      life--;
    });
    return life;
  }

  void gameOverDialog(Function onResume) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Game Over"),
        content: const Text("You lose"),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  Widget firsScreen() {
    return Column(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Hero(
                tag: "map",
                child: Container(
                  color: const Color.fromARGB(255, 2, 0, 23),
                ),
              ),
              Hero(
                tag: "ship",
                child: SizedBox(
                  width: 64,
                  height: 64,
                  child: Image.asset(
                    SpriteHelper.spritePath + SpriteHelper.ship,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class SpaceFlame extends FlameGame
    with HasDraggableComponents, HasTappableComponents, HasCollisionDetection {
  late Ship ship;
  List<Enemy> enemy = [];
  double respawnTime = 0.3;
  double timePassed = 0;
  math.Random random = math.Random();
  bool pause = false;
  final double inputTreshold = 2;

  late Vector2 touchPosition;

  final Function(Function) onGameOver;
  final int Function() onLoseLife;
  SpaceFlame({required this.onGameOver, required this.onLoseLife});

  @override
  Future<void> onLoad() async {
    ship = Ship()
      ..position = Vector2(size.x / 2, size.y / 2)
      ..size = Vector2(64, 64)
      ..setSpeed(1000);
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
    for (int i = 0; i < enemy.length; i++) {
      Enemy e = enemy[i];
      e.move(dt);
      if (e.getCollidingInfo()) {
        if (onLoseLife() == 0) {
          onGameOver.call(() {
            enemy.removeAt(i);
            remove(e);
            i--;
            resumeEngine();
          });
          pauseEngine();
        }
        enemy.removeAt(i);
        remove(e);
        i--;
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
        ..setSpeed(random.nextInt(200) + 400));
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
    //ship.move(dt);
    ship.moveAt(touchPosition);
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
