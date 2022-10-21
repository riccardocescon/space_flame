import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';

class TapHandler extends PositionComponent {
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
  void onDragStart(DragStartEvent event) {
    tapped = true;
    _tapPosition = event.canvasPosition;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    tapped = true;
    _tapPosition = event.canvasPosition;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    tapped = false;
  }
}
