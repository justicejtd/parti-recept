import 'package:flutter/material.dart';

class HorizontalLine extends StatelessWidget {
  final Size size;
  final Color color;

  const HorizontalLine({Key? key, required this.size, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Container(
        color: color,
      ),
    );
  }
}
