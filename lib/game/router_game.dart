import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:space_flame/game/pages/homepage.dart';
import 'package:space_flame/game/pages/space_flame.dart';
import 'package:space_flame/utils/navigation.dart';

class RouterGame extends FlameGame
    with HasTappableComponents, HasDraggableComponents, HasCollisionDetection {
  late final RouterComponent router;

  @override
  Future<void> onLoad() async {
    add(
      router = RouterComponent(
        routes: {
          Navigation.homepage: Route(
            Homepage.new,
          ),
          Navigation.gamepage: Route(
            () => SpaceFlame(),
          ),
        },
        initialRoute: Navigation.gamepage,
      ),
    );
  }
}
