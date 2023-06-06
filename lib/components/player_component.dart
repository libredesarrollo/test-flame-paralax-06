import 'package:flutter/services.dart';

import 'package:flame/collisions.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';

import 'package:parallax06/utils/create_animation_by_limit.dart';
import 'package:parallax06/components/character.dart';
import 'package:parallax06/main.dart';

class PlayerComponent extends Character {
  MyGame game;

  // bool blockPlayer = false;
  // double blockPlayerTime = 2.0;
  // double blockPlayerElapseTime = 0;

  // bool inviciblePlayer = false;
  // double inviciblePlayerTime = 8.0;
  // double inviciblePlayerElapseTime = 0;

  PlayerComponent({required this.game}) : super() {
    anchor = Anchor.center;
    debugMode = true;
    position = Vector2(spriteSheetWidth, spriteSheetHeight);
    size = Vector2(spriteSheetWidth, spriteSheetHeight);
  }

  int count = 0;

  @override
  Future<void>? onLoad() async {
    final spriteImage = await Flame.images.load('shark.png');
    final spriteSheet = SpriteSheet(
        image: spriteImage,
        srcSize: Vector2(spriteSheetWidth, spriteSheetHeight));

    // init animation
    idleAnimation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 0, step: 4, sizeX: 2, stepTime: .08);
    // end animation

    animation = idleAnimation;

    body = RectangleHitbox(
        size: Vector2(spriteSheetWidth / 4 - 70, spriteSheetHeight / 4),
        position: Vector2(25, 0))
      ..collisionType = CollisionType.active;

    // mouth = RectangleHitbox(
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
      // isMoving = false;
    }
    // else {
    //   isMoving = true;
    // }

    //**** RIGHT
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight) ||
        keysPressed.contains(LogicalKeyboardKey.keyD)) {
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

    return true;
  }

  void movePlayer(double delta) {
    // if (movementType == playerCollisionDirection) {
    //   return;
    // }

    // if (playerCollisionDirection.contains(movementType)) {
    //   return;
    // }

    switch (movementType) {
      case MovementType.right:
      case MovementType.left:
        if (position.x < 500 - size.x) {
          position.add(Vector2(
              delta * speed * (movementType == MovementType.left ? -1 : 1), 0));
        }

        break;
      case MovementType.up:
      case MovementType.down:
        if (position.y > 0) {
          position.add(Vector2(
              0, delta * speed * (movementType == MovementType.up ? -1 : 1)));
        }
        break;
      case MovementType.idle:
        break;
    }
  }
}
