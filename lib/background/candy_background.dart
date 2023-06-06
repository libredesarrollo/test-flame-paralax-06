import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';

import 'package:parallax06/main.dart';

class CandyBackground extends ParallaxComponent {
  @override
  FutureOr<void> onLoad() async {
    parallax = await gameRef.loadParallax([
      ParallaxImageData('layer06_sky.png'),
      ParallaxImageData('layer05_rocks.png'),
      ParallaxImageData('layer04_clouds.png'),
      ParallaxImageData('layer03_trees.png'),
      ParallaxImageData('layer02_cake.png'),
      ParallaxImageData('layer01_ground.png'),
    ],
        baseVelocity: Vector2(10, 0),
        velocityMultiplierDelta: Vector2(1.1, 1.1));

    return super.onLoad();
  }
}
