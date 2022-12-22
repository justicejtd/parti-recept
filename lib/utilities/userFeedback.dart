import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String message) {
  // Find the ScaffoldMessenger in the widget tree
  // and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
  );
}