import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
import 'package:space_flame/game/router_game.dart';
import 'package:space_flame/game/style.dart';

class Homepage extends Component with TapCallbacks, HasGameRef<RouterGame> {
  @override
  Future<void> onLoad() async {
    addAll(
      [
        Background(const Color.fromARGB(255, 194, 49, 49)),
        TextBoxComponent(
          text: 'Homepage',
          textRenderer: TextPaint(
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
          align: Anchor.center,
          size: gameRef.canvasSize,
        ),
      ],
    );
  }
}
