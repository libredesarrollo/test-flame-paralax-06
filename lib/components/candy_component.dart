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

class CandyComponent extends SpriteComponent with CollisionCallbacks {
  Food food;

  CandyComponent({required this.food}) : super() {
    debugMode = true;
  }

  static const int circleSpeed = 500;
  static const double circleWidth = 100.0, circleHeight = 100.0;

  Random random = Random();

  late double screenWidth, screenHeight;

  final ShapeHitbox hitbox = CircleHitbox();

  final double spriteSheetWidth = 512, spriteSheetHeight = 512;

  @override
  Future<void>? onLoad() async {
    screenWidth = MediaQueryData.fromWindow(window).size.width;
    screenHeight = MediaQueryData.fromWindow(window).size.height;

    position = Vector2(random.nextDouble() * screenWidth, circleHeight);
    size = Vector2(circleWidth, circleHeight);

    hitbox.renderShape = false;
    hitbox.collisionType = CollisionType.passive;
    add(hitbox);

    sprite = food.sprite;

    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.y += circleSpeed * dt;

    if (position.y > screenHeight) {
      removeFromParent();
      print("remove!");
    }

    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (other is ScreenHitbox) {}

    super.onCollision(points, other);
  }
}
