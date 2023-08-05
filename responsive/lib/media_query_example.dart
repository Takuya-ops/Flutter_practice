import 'package:flutter/material.dart';

class MediaQueryExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.5,
      color: Colors.blue,
      child: Center(
        child: Text(
          'Hello, MediaQuery!',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
