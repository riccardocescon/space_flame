import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:space_flame/utils/sprite_helper.dart';

class Ship extends SpriteComponent with CollisionCallbacks {
  Vector2 _direction = Vector2.zero();
  double _speed = 0.0;
  Ship() : super(size: Vector2.all(80));
  bool stop = false;
  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(
      SpriteHelper.ship,
    );
    final hitboxPaint = BasicPalette.red.paint()..style = PaintingStyle.stroke;
    add(
      PolygonHitbox.relative(
        SpriteHelper.hitBox[SpriteHelper.ship]!,
        parentSize: size,
      )
      //..paint = hitboxPaint
      /* ..renderShape = true */,
    );
  }

  void moveAt(Vector2 goal) {
    position = goal;
  }

  @override
  void move(double dt) {
    if (!stop) {
      position += _direction.normalized() * dt * _speed;
    }
  }

  void setMoveDirection(Vector2 newMoveDIrection) {
    _direction = newMoveDIrection;
  }

  void setSpeed(double newSpeed) {
    _speed = newSpeed;
  }

  void stopSprite() {
    stop = true;
  }
}
