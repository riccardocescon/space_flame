import 'package:flame/components.dart';
import 'package:space_flame/utils/sprite_helper.dart';

class Ship extends SpriteComponent {
  Ship() : super(size: Vector2.all(256));
  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(SpriteHelper.ship);
  }
}
