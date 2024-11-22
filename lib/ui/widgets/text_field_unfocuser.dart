import 'package:flutter/material.dart';

class TextFieldUnfocuser extends StatelessWidget {
  const TextFieldUnfocuser({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: child,
    );
  }
}
