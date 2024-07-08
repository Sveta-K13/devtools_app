import 'package:flutter/material.dart';

class Drawing extends StatelessWidget {
  const Drawing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                debugDumpApp();
              },
              child: const Text('Calc with sets'),
            ),
            TextButton(
              onPressed: () {
                debugDumpFocusTree();
              },
              child: const Text('Calc with indexes'),
            ),
          ],
        ),
      ),
    );
  }
}
