import 'package:flutter/material.dart';

// import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
// import 'package:flame/parallax.dart';
import 'package:parallax06/background/candy_background.dart';
import 'package:parallax06/components/player_component.dart';

class MyGame extends FlameGame with HasKeyboardHandlerComponents {
  @override
  void onLoad() async {
    super.onLoad();
    add(CandyBackground());
    add(PlayerComponent(game: this));
  }

  // Future<ParallaxComponent> bgParallax() async {
  //   ParallaxComponent parallaxComponent = await loadParallaxComponent([
  //     // ParallaxImageData('layer06_sky.png', repeat: ImageRepeat.repeatY),
  //     ParallaxImageData('layer06_sky.png'),
  //     ParallaxImageData('layer05_rocks.png'),
  //     ParallaxImageData('layer04_clouds.png'),
  //     ParallaxImageData('layer03_trees.png'),
  //     ParallaxImageData('layer02_cake.png'),
  //     ParallaxImageData('layer01_ground.png'),
  //   ],
  //       baseVelocity: Vector2(10, 0),
  //       velocityMultiplierDelta: Vector2(1.1, 1.1));

  //   return parallaxComponent;
  // }
}

void main() {
  runApp(GameWidget(game: MyGame()));
}
