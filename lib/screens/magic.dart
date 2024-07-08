import 'package:flutter/material.dart';

class Magic extends StatelessWidget {
  const Magic({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Align(
            child: Container(
              height: 200,
              width: 200,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Draggable(
              childWhenDragging: Container(),
              feedback: buildMagicText(),
              child: buildMagicText(),
            ),
          ),
        ],
      ),
    );
  }

  Container buildMagicText() {
    return Container(
        key: const Key('text'),
        foregroundDecoration: const BoxDecoration(
            color: Colors.white, backgroundBlendMode: BlendMode.difference),
        child: const Text('hi',
            style: TextStyle(
                color: Colors.white, decoration: TextDecoration.none)));
  }
}
