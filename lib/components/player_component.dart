import 'dart:math' as math;

import 'package:flutter/services.dart';

import 'package:flame/collisions.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:parallax06/components/food.dart';
import 'package:parallax06/components/food_component.dart';

import 'package:parallax06/utils/create_animation_by_limit.dart';
import 'package:parallax06/components/character.dart';
import 'package:parallax06/main.dart';
import 'package:parallax06/utils/helper.dart';

class PlayerComponent extends Character with HasGameRef<MyGame> {
  double changeAnimationTimer = 0;
  double timeToChangeAnimation = 0;
  bool chewing = false;
  final double maxVelocity = 10;

  PlayerComponent() : super() {
    _init();
  }
  _init() {
    anchor = Anchor.center;
    debugMode = true;
    position = Vector2(spriteSheetWidth, spriteSheetHeight);
    size = Vector2(spriteSheetWidth, spriteSheetHeight);
    scale = Vector2.all(.5);
  }

  reset() {
    _init();
    changeAnimationTimer = 0;
    timeToChangeAnimation = 0;
    chewing = false;
    animation = idleAnimation;
  }

// flipHorizontally();
  @override
  Future<void>? onLoad() async {
    final spriteImage = await Flame.images.load('shark.png');
    final spriteSheet = SpriteSheet(
        image: spriteImage,
        srcSize: Vector2(spriteSheetWidth, spriteSheetHeight));

    // init animation
    chewAnimation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 0, step: 4, sizeX: 2, stepTime: .08);

    idleAnimation = spriteSheet.createAnimationByLimit(
        xInit: 1, yInit: 0, step: 1, sizeX: 2, stepTime: .08);

    // end animation

    animation = idleAnimation;

    body = RectangleHitbox()..collisionType = CollisionType.active;

    //
    //
    // size: Vector2(spriteSheetWidth / 4 - 70, spriteSheetHeight / 4),
    // position: Vector2(25, 0)
    mouth = RectangleHitbox(size: Vector2(50, 35), position: Vector2(40, 65))
      ..collisionType = CollisionType.active;

    add(body);
    add(mouth);

    game.hudComponent.rotateButton.onPressed = () {
      _rotate();
    };

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
      _rotate();
    }

    return true;
  }

  void _rotate() {
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
      flipVertically();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (chewing) {
      changeAnimationTimer += dt;
      if (changeAnimationTimer >= timeToChangeAnimation) {
        timeToChangeAnimation = 0;
        changeAnimationTimer = 0;
        chewing = false;
        animation = idleAnimation;
      }
    }

    movePlayer(dt);
    movePlayerJoystick(dt);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (mouth.isColliding &&
        other is FoodComponent &&
        !chewing &&
        rotateType == other.foodPreSprite.sideType) {
      timeToChangeAnimation = other.foodPreSprite.food.chewed;
      chewing = true;
      animation = chewAnimation;

      gameRef.points++;
      gameRef.eatenCandy++;
      game.refreshOverlayStatistics();

      other.removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
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

  void movePlayerJoystick(double delta) {
    if (gameRef.hudComponent.joystick.direction != JoystickDirection.idle) {
      print(gameRef.hudComponent.joystick.delta);
      position.add(gameRef.hudComponent.joystick.delta * maxVelocity * delta);
    }
  }
}
