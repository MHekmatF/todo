import 'package:flutter/material.dart';

class DefaultElevatedButton extends StatelessWidget {
  Widget child;
  // voidCallback onPress;
  void Function() onPress;
  DefaultElevatedButton({Key? key, required this.child, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPress, child: child);
  }
}
