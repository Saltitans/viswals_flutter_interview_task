import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.borderRadius = 5,
    required this.backgroundColor,
    required this.label,
    required this.onTap,
  });

  final double borderRadius;
  final Color backgroundColor;
  final Widget label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 48,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                label,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
