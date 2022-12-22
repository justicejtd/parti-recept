import 'package:flutter/material.dart';
import 'package:partirecept/themes/TextThemeOswald.dart';

class BodyTest extends StatelessWidget {
  const BodyTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(child: Text("Coming soon", style: TextThemeOswald(Colors.white).headline2)),
      ],
    );
  }
}
