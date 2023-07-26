import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class RotateButton extends HudButtonComponent {
  RotateButton({
    required button,
    buttonDown,
    EdgeInsets? margin,
    Vector2? size,
    Anchor anchor = Anchor.center,
    onPressed,
  }) : super(
            button: button,
            buttonDown: buttonDown,
            margin: margin,
            size: size ?? button.size,
            anchor: anchor,
            onPressed: onPressed);

  // @override
  // void onTapDown(TapDownEvent event) {
  //   super.onTapDown(event);
  // }

  // @override
  // void onTapUp(TapUpEvent event) {
  //   super.onTapUp(event);
  // }

  // @override
  // void onTapCancel(TapCancelEvent event) {
  //   super.onTapCancel(event);
  // }
}
