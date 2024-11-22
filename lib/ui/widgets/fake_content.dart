import 'package:flutter/material.dart';

class FakeContent extends StatelessWidget {
  const FakeContent({
    super.key,
    required this.color,
    required this.height,
    this.width,
  });

  final Color color;
  final double height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: SizedBox(
        height: height,
        width: width,
      ),
    );
  }
}
