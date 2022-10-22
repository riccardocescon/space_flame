import 'package:flutter/material.dart';
import 'package:space_flame/game/pages/homepage.dart';
import 'package:space_flame/game/pages/space_flame.dart';
import 'package:space_flame/utils/navigation.dart';

void main() {
  runApp(
    MaterialApp(
      routes: {
        Navigation.homepage: (context) => const HomePage(),
        Navigation.gamepage: (context) => const SpaceFlameGame(),
      },
      initialRoute: Navigation.homepage,
    ),
  );
}
