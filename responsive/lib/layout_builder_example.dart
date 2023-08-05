import 'package:flutter/material.dart';

class LayoutBuilderExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth * 0.8,
          height: constraints.maxHeight * 0.5,
          color: Colors.green,
          child: Center(
            child: Text(
              'Hello, LayoutBuilder!',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
