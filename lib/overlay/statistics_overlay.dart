import 'package:flutter/material.dart';
import 'package:parallax06/main.dart';

class StatisticsOverlay extends StatefulWidget {
  final MyGame game;
  StatisticsOverlay({Key? key, required this.game}) : super(key: key);

  @override
  State<StatisticsOverlay> createState() => _StatisticsOverlayState();
}

class _StatisticsOverlayState extends State<StatisticsOverlay> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                child: Image.asset(
                  'assets/images/candy.png',
                  width: 50,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                widget.game.points.toString(),
                style: const TextStyle(
                    fontSize: 30,
                    color: Colors.amber,
                    shadows: [Shadow(color: Colors.black, blurRadius: 5.0)]),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "L",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.blueGrey,
                    shadows: [Shadow(color: Colors.black, blurRadius: 5.0)]),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                widget.game.lostCandy.toString(),
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.blueGrey,
                    shadows: [Shadow(color: Colors.black, blurRadius: 5.0)]),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "E",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.blueGrey,
                    shadows: [Shadow(color: Colors.black, blurRadius: 5.0)]),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                widget.game.eatenCandy.toString(),
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.blueGrey,
                    shadows: [Shadow(color: Colors.black, blurRadius: 5.0)]),
              )
            ],
          ),
        ],
      ),
    );
  }
}