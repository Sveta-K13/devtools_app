import 'dart:math';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

const Color green = Colors.green;
const Color blue = Colors.blue;
const Color violet = Colors.purple;
const Color unknownColor = Colors.pink;
Color bgColor = Colors.yellow.shade200;

class _MyHomePageState extends State<MyHomePage> {
  Widget get colorBox {
    return Container(
      height: 200,
      width: 200,
      key: const Key('Color Box '),
      color: Color.alphaBlend(green.withOpacity(0.5), blue),
    );
  }

  Widget get linearGradientBox {
    return Container(
      height: 200,
      width: 200,
      key: const Key('Linear Gradient Box '),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [green, blue],
        stops: [0, 0.7],
        transform: GradientRotation(0),
      )),
    );
  }

  Widget get linearGradientExamples {
    return Row(children: [
      Container(
        height: 200,
        width: 200,
        key: const Key('Unknown Colored Text Background'),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                transform: const GradientRotation(pi / 2),
                colors: [
              Color.alphaBlend(unknownColor.withOpacity(0.6), bgColor),
              bgColor,
            ],
                stops: [
              0,
              1
            ])),
        child: const Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Пункт 1',
              style: TextStyle(color: unknownColor),
            ),
          ),
        ),
      ),
      const SizedBox(width: 20),
      Container(
        height: 200,
        width: 200,
        key: const Key('LinearGradient Rotated Repeated'),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(0, 0),
                end: Alignment(0, 0.2),
                colors: [unknownColor, Colors.transparent],
                stops: [0.1, 0.1],
                transform: GradientRotation(pi / 6),
                tileMode: TileMode.repeated)),
      ),
      const SizedBox(width: 20),
      shapeGradient,
    ]);
  }

  Widget get shapeGradient {
    return Container(
      key: const Key('RadialGradient Example'),
      height: 200,
      width: 200,
      decoration: const BoxDecoration(
          backgroundBlendMode: BlendMode.darken,
          gradient: RadialGradient(
            colors: [unknownColor, Colors.transparent],
            stops: [0.1, 0.1],
            tileMode: TileMode.repeated,
            focal: Alignment(-1, 0),
            center: Alignment(0.2, 0),
            transform: GradientRotation(10 * pi / 6),
          )),
    );
  }

  Widget get sweepGradientExample {
    return Container(
      key: const Key('Sweep Gradient Example'),
      height: 200,
      width: 200,
      decoration: const BoxDecoration(
          backgroundBlendMode: BlendMode.multiply,
          gradient: SweepGradient(
            colors: [unknownColor, Colors.transparent, unknownColor],
            stops: [0.7, 0.7, 0.75],
            transform: GradientRotation(0),
            startAngle: -pi / 2,
            endAngle: pi,
          )),
    );
  }

  Image get profileImg => Image.network(
        'https://raw.githubusercontent.com/Sveta-K13/flutter_colors_demo/master/images/profile.png',
        height: 80,
      );
  Image get profileImgColored => Image.network(
        'https://raw.githubusercontent.com/Sveta-K13/flutter_colors_demo/master/images/profile.png',
        height: 80,
        color: Colors.deepPurple,
      );
  Image get meImg => Image.network(
        'https://raw.githubusercontent.com/Sveta-K13/flutter_colors_demo/master/images/me.png',
        height: 80,
      );
  Image get paintImg => Image.network(
        'https://raw.githubusercontent.com/Sveta-K13/flutter_colors_demo/master/images/paint.png',
        height: 80,
      );
  //

  //

  //

  //

  @override
  Widget build(BuildContext context) {
    return PageView(children: [
      //
      //
      //
      //
      //
      //
      //
      //
      //
      Scaffold(
        body: SafeArea(
          child: Flex(
            direction: Axis.vertical,
            children: [
              colorBox,
              linearGradientBox,
              linearGradientExamples,
              sweepGradientExample,
            ],
          ),
        ),
      ),
      //
      //
      //
      //
      //
      //
      //
      //
      //
      //
      //
      //
      Scaffold(
          body: SafeArea(
              child: Column(children: [
        profileImg,
        profileImgColored,
        const SizedBox(height: 30),
        buildShaderMask(),
      ]))),

      //
      //
      //
      //
      //
      //
      //
      //
      //
      //
      //
      //
      //
      //
      //
      //
      Container(
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
      ),
    ]);
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

  ShaderMask buildGradientText() {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => const LinearGradient(
          colors: [Colors.indigo, Colors.red],
          stops: [0.3, 0.7]).createShader(bounds),
      child: const Text(
        'I love Flutter',
        style: TextStyle(fontSize: 65, fontWeight: FontWeight.bold),
      ),
    );
  }

  Draggable buildDraggableTransparentText() {
    return Draggable(
      childWhenDragging: const SizedBox(),
      feedback: buildTransparentText(),
      child: buildTransparentText(),
    );
  }

  ShaderMask buildTransparentText() {
    return ShaderMask(
      blendMode: BlendMode.srcOut,
      shaderCallback: (bounds) => const LinearGradient(
          colors: [Colors.indigo, Colors.red],
          stops: [0.3, 0.7]).createShader(bounds),
      child: const Text(
        'I love Flutter',
        style: TextStyle(
            fontSize: 65,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none),
      ),
    );
  }

  // ShaderMask buildRichWidget() {
  //   return ShaderMask(
  //     blendMode: BlendMode.difference,
  //     shaderCallback: (bounds) => const LinearGradient(
  //         colors: [Colors.indigo, Colors.red],
  //         stops: [0.3, 0.7]).createShader(bounds),
  //     child: Container(
  //       width: double.infinity,
  //       key: const Key('Container with mask'),
  //       decoration: const BoxDecoration(
  //           backgroundBlendMode: BlendMode.clear, color: Colors.amber),
  //       child: Stack(
  //         alignment: AlignmentDirectional.topCenter,
  //         children: [
  //           Image.asset(
  //             'images/paint.png',
  //             width: 280,
  //           ),
  //           const Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text('хорошего дня!'),
  //               Text('  хорошего дня!'),
  //               Text('хорошего дня!'),
  //               Text('  хорошего дня!'),
  //               Text('хорошего дня!'),
  //               Text('  хорошего дня!'),
  //               Text('хорошего дня!'),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Container buildOutIcon() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: <Color>[
          Colors.white,
          Colors.black,
        ],
        stops: [0.3, 1],
        tileMode: TileMode.clamp,
      )),
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return const LinearGradient(
            colors: <Color>[
              blue,
              green,
            ],
            stops: [0.3, 1],
            tileMode: TileMode.clamp,
          ).createShader(bounds);
        },
        blendMode: BlendMode.srcOut,
        child: profileImgColored,
      ),
    );
  }

  ShaderMask buildShaderMask() {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          colors: <Color>[green, blue],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcIn,
      child: profileImgColored,
    );
  }
}

class InvertedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double rectSize = size.width / 2;
    return Path.combine(
      PathOperation.difference,
      Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
      Path()
        ..addRect(Rect.fromLTWH((size.width - rectSize) / 2,
            (size.height - rectSize) / 2, rectSize, rectSize))
        ..close(),
    );
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
