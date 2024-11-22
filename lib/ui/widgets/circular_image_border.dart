import 'package:flutter/material.dart';

class CircularImageBorder extends StatelessWidget {
  const CircularImageBorder({
    super.key,
    required this.outerBorderColor,
    required this.innerBorderColor,
    required this.child,
  });

  final Color outerBorderColor;
  final Color innerBorderColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: outerBorderColor,
          width: 4,
        ),
        color: innerBorderColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(500)),
          child: child,
        ),
      ),
    );
  }
}
