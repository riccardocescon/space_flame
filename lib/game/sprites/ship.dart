import 'package:flame/components.dart';
import 'package:space_flame/utils/sprite_helper.dart';

class Ship extends SpriteComponent {
  Vector2 _direction = Vector2.zero();
  double _speed = 0.0;
  Ship() : super(size: Vector2.all(80));
  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(
      SpriteHelper.ship,
    );
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    position += _direction.normalized() * dt * _speed;
  }

  void setMoveDirection(Vector2 newMoveDIrection) {
    _direction = newMoveDIrection;
  }

  void setSpeed(double newSpeed) {
    _speed = newSpeed;
  }
}
