import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:parallax06/main.dart';

class LevelSelectionOverlay extends StatefulWidget {
  final MyGame game;
  LevelSelectionOverlay({Key? key, required this.game}) : super(key: key);

  @override
  State<LevelSelectionOverlay> createState() => _LevelSelectionOverlayState();
}

class _LevelSelectionOverlayState extends State<LevelSelectionOverlay> {
  late double screenWidth, screenHeight;

  @override
  Widget build(BuildContext context) {
// MediaQuery.fromView(
    // view: View.of(context),

    screenWidth = MediaQueryData.fromView(View.of(context)).size.width;
    screenHeight = MediaQueryData.fromView(View.of(context)).size.height;

    return Container(
      color: Colors.black45,
      height: screenHeight,
      width: screenWidth,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          height: screenHeight - 150,
          width: screenWidth - 150,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            children: [
              const Text(
                "Level Selection",
                style: TextStyle(fontSize: 40),
              ),
              Expanded(
                child: GridView.count(
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this produces 2 rows.
                  crossAxisCount: screenWidth > 900 ? 6 : 3,
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(6, (index) {
                    return _getLevel(index + 1);
                  }),
                ),
              ),
            ],
          ),
        ),

        // Column(
        //   children: [
        //     const Text(
        //       "Level Selection",
        //       style: TextStyle(fontSize: 40),
        //     ),
        //     Row(children: [
        //       _getLevel(1),
        //       _getLevel(2),
        //       _getLevel(3),
        //       _getLevel(4),
        //       _getLevel(5),
        //       _getLevel(6),
        //     ]),
        //   ],
        // ),
        // ),
      ),
    );
  }

  _getLevel(int level) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent, width: 5),
        ),
        width: 100,
        height: 100,
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            widget.game.reset(currentLevel: level);
            widget.game.overlays.remove("LevelSelection");
          },
          child: Text(
            level.toString(),
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}
