import 'package:flutter/material.dart';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';

class MyGame extends FlameGame {
  // late TileMapComponent background;

  @override
  void onLoad() async {
    super.onLoad();

    ParallaxComponent parallaxComponent = await loadParallaxComponent(
      [
        ParallaxImageData('layer01_ground.png'),
        ParallaxImageData('layer02_cake.png'),
      ],
      baseVelocity: Vector2(10, 0),
      // velocityMultiplierDelta: Vector2(1.6, 1.0)
    );

    add(parallaxComponent);
  }
}

void main() {
  runApp(GameWidget(game: MyGame()));
}
