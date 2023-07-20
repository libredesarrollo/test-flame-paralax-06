import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
// import 'package:flame/parallax.dart';
import 'package:parallax06/background/candy_background.dart';
import 'package:parallax06/components/food_component.dart';
import 'package:parallax06/components/hud/hud.dart';
import 'package:parallax06/components/player_component.dart';
import 'package:parallax06/components/food.dart' as food;
import 'package:parallax06/overlay/game_over_overlay.dart';
import 'package:parallax06/overlay/level_selection_overlay.dart';
import 'package:parallax06/overlay/statistics_overlay.dart';
import 'package:parallax06/overlay/type_game_overlay.dart';
import 'package:parallax06/utils/type_game.dart';

class SineCurve extends Curve {
  @override
  double transformInternal(double t) {
    return (sin(pi * (t * 2 - 1 / 2)) + 1) / 2;
  }
}

class MyGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  double foodTimer = 0.0;
  int foodIndex = 0;

  int points = 0;
  int eatenCandy = 0;
  int lostCandy = 0;
  int currentLevel = 1;
  TypeGame typeGame = TypeGame.byPoints;

  late PlayerComponent _playerComponent;

  @override
  void onLoad() async {
    super.onLoad();
    await food.init();
    add(CandyBackground());
    _playerComponent = PlayerComponent();
    add(_playerComponent);
    add(HudComponent());

    // add(ParticleSystemComponent(particle: paintParticle())
    //   ..position = Vector2(500, 500));
  }

  refreshOverlayStatistics() {
    overlays.remove('Statistics');
    overlays.add('Statistics');

    //checkEndGame();
  }

  checkEndGame() {
    switch (oneLost(
        food.getCurrentLevel(level: currentLevel), eatenCandy, lostCandy)) {
      case StateGame.lose:
        print("losing");
        overlays.add('GameOver');
        paused = true;
        break;
      case StateGame.win:
        print("win");
        overlays.add('GameOver');
        paused = true;
        break;
      default:
        break;
    }
  }

  Particle paintParticle() {
    final colors = [
      const Color(0xffff0000),
      const Color(0xff00ff00),
      const Color(0xff0000ff),
    ];
    final positions = [
      Vector2(-10, 10),
      Vector2(10, 10),
      Vector2(0, -14),
    ];

    return Particle.generate(
      count: 3,
      generator: (i) => PaintParticle(
        paint: Paint()..blendMode = BlendMode.difference,
        child: MovingParticle(
          curve: SineCurve(),
          from: positions[i],
          to: i == 0 ? positions.last : positions[i - 1],
          child: CircleParticle(
            radius: 5.0,
            paint: Paint()..color = colors[i],
          ),
        ),
      ),
    );
  }

  Particle circle() {
    return CircleParticle(
      paint: Paint()..color = Colors.white10,
    );
  }

  // Vector2 randomCellVector2() {
  //   return (Vector2.random() - Vector2.random())..multiply(cellSize);
  // }

  // Particle randomMovingParticle() {
  //   return MovingParticle(
  //     to: randomCellVector2(),
  //     child: CircleParticle(
  //       radius: 5 + rnd.nextDouble() * 5,
  //       paint: Paint()..color = Colors.red,
  //     ),
  //   );
  // }

  @override
  void update(double dt) {
    addSpriteFoodToWindow(dt);
    super.update(dt);
  }

  addSpriteFoodToWindow(double dt) {
    if (foodIndex < food.getCurrentLevel(level: currentLevel).length) {
      if (foodTimer >
          food
              .getCurrentLevel(level: currentLevel)[foodIndex]
              .timeToOtherFood) {
        add(FoodComponent(
            foodPreSprite:
                food.getCurrentLevel(level: currentLevel)[foodIndex]));
        foodTimer = 0.0;
        foodIndex++;
      }

      foodTimer += dt;
    }
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

  void reset(
      {bool dead = false,
      int currentLevel = 1,
      TypeGame typeGame = TypeGame.byPoints}) {
    paused = false;
    foodTimer = 0.0;
    foodIndex = 0;

    points = 0;
    eatenCandy = 0;
    lostCandy = 0;

    this.currentLevel = currentLevel;
    this.typeGame = typeGame;

    _playerComponent.reset();

    overlays.remove('GameOver');
    overlays.remove('Statistics');
    overlays.add('Statistics');
  }

  getMetadataTypeGame() {}
}

void main() {
  runApp(GameWidget(
    game: MyGame(),
    overlayBuilderMap: {
      'Statistics': (context, MyGame game) {
        return StatisticsOverlay(game: game);
      },
      'GameOver': (context, MyGame game) {
        return GameOverOverlay(
          game: game,
        );
      },
      'LevelSelection': (context, MyGame game) {
        return LevelSelectionOverlay(
          game: game,
        );
      },
      'TypeGameOverlay': (context, MyGame game) {
        return TypeGameOverlay(
          game: game,
        );
      }
    },
    initialActiveOverlays: const ['Statistics'],
  ));
}
