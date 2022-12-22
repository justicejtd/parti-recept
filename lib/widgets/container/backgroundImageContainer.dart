import 'package:flutter/material.dart';

class BackgroundImageContainer extends StatelessWidget {
  final Widget child;
  final String assetImage;

  BackgroundImageContainer(
      {Key? key, required this.child, required this.assetImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(assetImage), fit: BoxFit.cover)),
      child: child,
    );
  }
}
