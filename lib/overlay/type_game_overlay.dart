import 'package:flutter/material.dart';
import 'package:parallax06/main.dart';
import 'package:parallax06/utils/type_game.dart';

class TypeGameOverlay extends StatefulWidget {
  final MyGame game;
  const TypeGameOverlay({super.key, required this.game});

  @override
  State<TypeGameOverlay> createState() => _TypeGameOverlayState();
}

class _TypeGameOverlayState extends State<TypeGameOverlay> {
  late double screenWidth, screenHeight;

  @override
  Widget build(BuildContext context) {
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
          child: GridView.count(
            padding: const EdgeInsets.all(2),

            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2.5,
            crossAxisCount: 2,

            // Generate 100 widgets that display their index in the List.
            children: List.generate(4, (index) {
              return _getTypeGame(index);
            }),
          ),
        ),
      ),
    );
    // return Container(
    //   color: Colors.black45,
    //   height: screenHeight,
    //   width: screenWidth,
    //   child: Center(
    //     child: Container(
    //       padding: const EdgeInsets.all(5.0),
    //       height: screenHeight - 150,
    //       width: screenWidth - 150,
    //       decoration: const BoxDecoration(
    //           color: Colors.white,
    //           borderRadius: BorderRadius.all(Radius.circular(20))),
    //       child: Column(
    //         children: [
    //           const Text(
    //             "Type Game Selection",
    //             style: TextStyle(fontSize: 40),
    //           ),
    //           Expanded(
    //             child: GridView.count(
    //               padding: const EdgeInsets.all(2),
    //               primary: false,
    //               crossAxisSpacing: 10,
    //               mainAxisSpacing: 10,
    //               // Create a grid with 2 columns. If you change the scrollDirection to
    //               // horizontal, this produces 2 rows.
    //               crossAxisCount: 2,

    //               // Generate 100 widgets that display their index in the List.
    //               children: List.generate(4, (index) {
    //                 return _getTypeGame(index);
    //               }),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  _getTypeGame(int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent, width: 5),
      ),
      height: 100,
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          // widget.game.reset(currentLevel: level);
          widget.game.reset(typeGame: TypeGame.values[index]);
          widget.game.overlays.remove("TypeGameOverlay");
        },
        child: Text(
          TypeGame.values[index].name,
          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
