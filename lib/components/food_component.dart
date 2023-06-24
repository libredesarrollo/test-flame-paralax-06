import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flame/collisions.dart';
import 'package:flame/flame.dart';
import 'package:flame/palette.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components.dart';
import 'package:parallax06/components/food.dart';

import 'package:parallax06/utils/create_animation_by_limit.dart';
import 'package:parallax06/utils/helper.dart';

class FoodComponent extends SpriteComponent with CollisionCallbacks {
  FoodPreSprite foodPreSprite;

  int factX = 0, factY = 0;

  FoodComponent({required this.foodPreSprite}) : super() {
    debugMode = true;
  }

  // static const int circleSpeed = 500;
  //static const double circleWidth = 100.0, circleHeight = 100.0;

  Random random = Random();

  late double screenWidth, screenHeight;

  final ShapeHitbox hitbox = CircleHitbox();

  //final double spriteSheetWidth = 512, spriteSheetHeight = 512;

  _initPosition() {
    screenWidth = MediaQueryData.fromWindow(window).size.width;
    screenHeight = MediaQueryData.fromWindow(window).size.height;

    if (foodPreSprite.sideType == SideType.up ||
        foodPreSprite.sideType == SideType.down) {
      position = Vector2(
          random.nextDouble() * screenWidth, factY == 1 ? 1 : screenHeight);
      // position = Vector2(/*screenWidth*/ 0,  factY == 1 ? 1 : screenHeight); // PRUEBAS para los extremos

      // verificamos que el dulce generado no este muy pegado al lado derecho/izquierdo
      // if (position.x > (screenWidth - size.x / 2)) {
      // muy pegado al lado derecho
      //print("muy pegado al lado derecho X" + position.x.toString());
      //colocamos el dulce en una posicion visible en la pantalla
      //position.x = screenWidth - size.x;
      /*} else*/
      // if (position.x - size.x <= 0) {
      //   // muy pegado al lado izquierdo
      //   print("muy pegado al lado izquierdo X" + position.x.toString());
      //   //colocamos el dulce en una posicion visible en la pantalla
      //   position.x = 0;
      // }
    } else {
      position = Vector2(
          factX == 1 ? 1 : screenWidth, random.nextDouble() * screenHeight);
      position = Vector2(factX == 1 ? 1 : screenWidth, screenHeight);

      if (position.y > (screenHeight - size.y / 2)) {
        //   // muy pegado al lado derecho
        //   print("muy pegado al lado derecho " + position.y.toString());
        position.y = screenHeight - size.y;
        // } else if (position.y - size.y <= 0) {
        //   // muy pegado al lado izquierdo
        print("muy pegado al lado izquierdo " + position.y.toString());
        //   position.y = size.y;
      }
    }
  }

  @override
  Future<void>? onLoad() async {
    size = Vector2(50, 50);

    if (foodPreSprite.sideType == SideType.up) {
      factY = 1;
    } else if (foodPreSprite.sideType == SideType.down) {
      factY = -1;
    } else if (foodPreSprite.sideType == SideType.left) {
      factX = 1;
    } else if (foodPreSprite.sideType == SideType.right) {
      factX = -1;
    }

    _initPosition();

    // hitbox.renderShape = false;
    hitbox.collisionType = CollisionType.passive;
    add(hitbox);

    sprite = foodPreSprite.food.sprite;

    return super.onLoad();
  }

  @override
  void update(double dt) {
    // position.y += circleSpeed * dt;

    position.add(Vector2(
        foodPreSprite.speed * dt * factX, foodPreSprite.speed * dt * factY));

    // remover dulces cuando ya no sean visibles en la ventana
    if (foodPreSprite.sideType == SideType.up && position.y > screenHeight) {
      removeFromParent();
      print("remove! SideType.up");
    } else if (foodPreSprite.sideType == SideType.down &&
        position.y < -size.y) {
      removeFromParent();
      print("remove! SideType.down");
    } else if (foodPreSprite.sideType == SideType.left &&
        position.x > screenWidth) {
      removeFromParent();
      print("remove! SideType.left");
    } else if (foodPreSprite.sideType == SideType.right &&
        position.x < -size.x) {
      removeFromParent();
      print("remove! SideType.right");
    }

    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (other is ScreenHitbox) {}

    super.onCollision(points, other);
  }
}
