import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
import 'package:space_flame/game/router_game.dart';
import 'package:space_flame/game/style.dart';

import '../../utils/navigation.dart';

class Homepage extends Component with TapCallbacks, HasGameRef<RouterGame> {
  late final Button _button1;
  late final TextBoxComponent _title;

  Homepage() {
    addAll(
      [
        Background(Palette.background),
        _title = TextBoxComponent(
          boxConfig: TextBoxConfig(
            growingBox: true,
          ),
          text: 'Homepage',
          textRenderer: TextPaint(
            style: const TextStyle(
              color: Colors.white,
              fontSize: 50,
            ),
          ),
          anchor: Anchor.center,
          align: Anchor.center,
        ),
        _button1 = Button(
          text: 'Play',
          action: () => gameRef.router.pushNamed(Navigation.gamepage),
          color: Palette.buttonBlu,
          borderColor: Colors.transparent,
        ),
      ],
    );
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _title.position = Vector2(size.x / 2, size.y / 2 - 100);
    _button1.position = size / 2;
  }
}
