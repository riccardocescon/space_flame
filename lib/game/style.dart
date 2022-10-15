import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';

class Background extends Component {
  Background(this.color);
  final Color color;

  @override
  void render(Canvas canvas) {
    canvas.drawColor(color, BlendMode.srcATop);
  }
}

class Button extends PositionComponent with TapCallbacks {
  /* final String text;
  final void Function() onTap;
  final TextPainter _textDrawable;
  late final Offset _textOffset;
  late final RRect _rect;
  late final Paint _borderPaint;
  late final Paint _bgPaint; */
}
