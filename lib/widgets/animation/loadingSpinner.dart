import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingSpinner extends StatefulWidget {
  final int? duration;

  const LoadingSpinner({Key? key, this.duration}) : super(key: key);

  @override
  _LoadingSpinnerState createState() => _LoadingSpinnerState();
}

class _LoadingSpinnerState extends State<LoadingSpinner>
    with TickerProviderStateMixin {
  late AnimationController loadingController;

  @override
  void initState() {
    loadingController =
        AnimationController(vsync: this, duration: Duration(seconds: this.widget.duration ?? 2))
            ..addListener(() {
      setState(() {});
    });
    loadingController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        value: loadingController.value,
        semanticsLabel: 'Linear progress indicator',
      ),
    );
  }
}
