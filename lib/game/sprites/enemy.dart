import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:space_flame/game/sprites/ship.dart';
import 'package:space_flame/utils/movement.dart';
import 'package:space_flame/utils/sprite_helper.dart';

class Enemy extends SpriteComponent with CollisionCallbacks {
  Vector2 _direction = Move.DOWN;
  double _speed = 0.0;
  Enemy() : super(size: Vector2.all(50));
  bool colliding = false;
  bool stop = false;

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(
      SpriteHelper.enemy,
    );
    final hitboxPaint = BasicPalette.white.paint()
      ..style = PaintingStyle.stroke;
    add(
      PolygonHitbox.relative(
        [
          Vector2(0.0, -1.0),
          Vector2(-1.0, -0.1),
          Vector2(-0.2, 0.4),
          Vector2(0.2, 0.4),
          Vector2(1.0, -0.1),
        ],
        parentSize: size,
      )
        ..paint = hitboxPaint
        ..renderShape = true,
    );
    flipVertically();
  }

  bool getCollidingInfo() {
    return colliding;
  }

  Vector2 getPosition() {
    return (Vector2(position.x, position.y));
  }

  @override
  void update(double dt) {
    // TODO: implement update
    if (!stop) {
      super.update(dt);
      position += _direction.normalized() * dt * _speed;
    }
  }

  void setMoveDirection(Vector2 newMoveDIrection) {
    _direction = newMoveDIrection;
  }

  void setSpeed(double newSpeed) {
    _speed = newSpeed;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Ship) {
      print("collide");
      colliding = true;
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    // TODO: implement onCollisionEnd
    colliding = false;
    super.onCollisionEnd(other);
  }

  void stopSprite() {
    stop = true;
  }
}
