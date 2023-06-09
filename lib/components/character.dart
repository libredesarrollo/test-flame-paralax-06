import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

enum MovementType { idle, right, left, up, down, rotate }

class Character extends SpriteAnimationComponent
    with KeyboardHandler, CollisionCallbacks {
  MovementType movementType = MovementType.idle;

  Vector2 velocity = Vector2(0, 0);

  double speed = 160;

  final double spriteSheetWidth = 269, spriteSheetHeight = 118;

  late SpriteAnimation chewAnimation, idleAnimation;

  late RectangleHitbox body;
}
