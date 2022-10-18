import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/extensions.dart';
import 'package:space_flame/game/style.dart';

class TapHandler extends PositionComponent with TapCallbacks {
  TapHandler() : super(anchor: Anchor.center);

  bool tapped = false;
  Vector2 _tapPosition = Vector2.zero();

  final _paint = Paint()..color = const Color(0x00000000);

  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);

    size = canvasSize;

    position = canvasSize / 2;
  }

  Vector2 get tapPosition => _tapPosition;

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }

  @override
  void onTapDown(TapDownEvent event) {
    print('object');
    tapped = true;
    _tapPosition = event.canvasPosition;
  }

  @override
  void onTapUp(TapUpEvent event) {
    tapped = false;
  }

  @override
  void onTapCancel(TapCancelEvent event) {}
}
