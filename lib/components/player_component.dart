import 'dart:math' as math;

import 'package:flutter/services.dart';

import 'package:flame/collisions.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';

import 'package:parallax06/utils/create_animation_by_limit.dart';
import 'package:parallax06/components/character.dart';
import 'package:parallax06/main.dart';
import 'package:parallax06/utils/helper.dart';

class PlayerComponent extends Character {
  MyGame game;

  PlayerComponent({required this.game}) : super() {
    anchor = Anchor.center;
    debugMode = true;
    position = Vector2(spriteSheetWidth, spriteSheetHeight);
    size = Vector2(spriteSheetWidth, spriteSheetHeight);
    // scale = Vector2.all(1.5);
  }
// flipHorizontally();
  @override
  Future<void>? onLoad() async {
    final spriteImage = await Flame.images.load('shark.png');
    final spriteSheet = SpriteSheet(
        image: spriteImage,
        srcSize: Vector2(spriteSheetWidth, spriteSheetHeight));

    // init animation
    idleAnimation = spriteSheet.createAnimationByLimit(
        xInit: 1, yInit: 0, step: 1, sizeX: 2, stepTime: .08);
    chewAnimation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 0, step: 4, sizeX: 2, stepTime: .08);
    // end animation

    animation = chewAnimation;

    body = RectangleHitbox()..collisionType = CollisionType.active;

    //
    //
    // size: Vector2(spriteSheetWidth / 4 - 70, spriteSheetHeight / 4),
    // position: Vector2(25, 0)
    //mouth = RectangleHitbox(
    //     size: Vector2(50, 10),
    //     position: Vector2(55, spriteSheetHeight / 4 - 20))
    //   ..collisionType = CollisionType.passive;

    add(body);
    // add(foot);

    return super.onLoad();
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.isEmpty) {
      movementType = MovementType.idle;
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowRight) ||
        keysPressed.contains(LogicalKeyboardKey.keyD)) {
      //**** RIGHT
      movementType = MovementType.right;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) || //**** LEFT
        keysPressed.contains(LogicalKeyboardKey.keyA)) {
      movementType = MovementType.left;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowUp) || //**** TOP
        keysPressed.contains(LogicalKeyboardKey.keyW)) {
      movementType = MovementType.up;
    } else if (keysPressed
            .contains(LogicalKeyboardKey.arrowDown) || //**** BOTTOM
        keysPressed.contains(LogicalKeyboardKey.keyS)) {
      movementType = MovementType.down;
    }

    if (keysPressed.contains(LogicalKeyboardKey.keyR)) {
      //**** R

      switch (rotateType) {
        case SideType.right:
          rotateType = SideType.down;
          break;
        case SideType.down:
          rotateType = SideType.left;
          break;
        case SideType.left:
          rotateType = SideType.up;
          break;
        case SideType.up:
          rotateType = SideType.right;
          break;
      }

      angle += math.pi * 1 / 2;
      // print(rotateType);
      if (rotateType == SideType.left || rotateType == SideType.right) {
        print("flipVertically");
        flipVertically();
      }
    }

    return true;
  }

  @override
  void update(double dt) {
    super.update(dt);

    movePlayer(dt);
  }

  void movePlayer(double delta) {
    switch (movementType) {
      case MovementType.right:
      case MovementType.left:
        position.add(Vector2(
            delta * speed * (movementType == MovementType.left ? -1 : 1), 0));
        break;
      case MovementType.up:
      case MovementType.down:
        position.add(Vector2(
            0, delta * speed * (movementType == MovementType.up ? -1 : 1)));
        break;
      // case MovementType.rotate:
      // angle += math.pi * 1 / 2 * delta;
      // break;
      case MovementType.idle:
        break;
    }
  }
}
