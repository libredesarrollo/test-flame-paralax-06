import 'package:flame/components.dart';
import 'package:parallax06/components/hud/rotate_button.dart';
import 'package:parallax06/components/hud/joystick.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class HudComponent extends PositionComponent {
  HudComponent() : super(priority: 20);

  late Joystick joystick;
  late RotateButton rotateButton;
  // late ScoreText scoreText;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final joystickKnobPaint = BasicPalette.red.withAlpha(200).paint();
    final joystickBackgroundPaint = BasicPalette.black.withAlpha(100).paint();
    final buttonRotatePaint = BasicPalette.blue.withAlpha(200).paint();
    final buttonDownRotatePaint = BasicPalette.blue.withAlpha(100).paint();
    joystick = Joystick(
      knob: CircleComponent(radius: 30.0, paint: joystickKnobPaint),
      background:
          CircleComponent(radius: 100.0, paint: joystickBackgroundPaint),
      margin: const EdgeInsets.only(left: 40, top: 100),
    );
    rotateButton = RotateButton(
        button: CircleComponent(radius: 25.0, paint: buttonRotatePaint),
        buttonDown: CircleComponent(radius: 25.0, paint: buttonDownRotatePaint),
        margin: const EdgeInsets.only(right: 20, bottom: 50),
        onPressed: () => {});
    // scoreText = ScoreText(margin: const EdgeInsets.only(left: 40, top: 60));
    add(joystick);
    add(rotateButton);
    // add(scoreText);
    // positionType = PositionType.viewport;
  }
}
