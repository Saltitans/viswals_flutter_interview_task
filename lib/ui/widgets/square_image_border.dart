import 'package:flutter/widgets.dart';

class SquareImageBorder extends StatelessWidget {
  const SquareImageBorder({
    super.key,
    required this.borderColor,
    required this.borderWidth,
    required this.child,
  });

  final Color borderColor;
  final double borderWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: borderColor),
      child: Padding(
        padding: EdgeInsets.all(borderWidth),
        child: ClipRRect(
          child: child,
        ),
      ),
    );
  }
}
