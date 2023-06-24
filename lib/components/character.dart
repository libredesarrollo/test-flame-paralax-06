import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:parallax06/utils/helper.dart';

enum MovementType { idle, right, left, up, down }

// enum RotateType { right, left, up, down }

class Character extends SpriteAnimationComponent
    with KeyboardHandler, CollisionCallbacks {
  MovementType movementType = MovementType.idle;
  SideType rotateType = SideType.left;

  Vector2 velocity = Vector2(0, 0);

  double speed = 350;

  final double spriteSheetWidth = 269, spriteSheetHeight = 118;

  late SpriteAnimation chewAnimation, idleAnimation;

  late RectangleHitbox body, mouth;
}
