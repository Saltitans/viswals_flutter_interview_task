import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:viswals_flutter_interview_task/ui/style/app_colors.dart';

class AppCheckbox extends HookWidget {
  const AppCheckbox({
    super.key,
    this.value = false,
    required this.onPress,
  });

  final bool value;
  final ValueSetter<bool> onPress;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = value ? AppColors.blue : AppColors.darkGrey;

    return GestureDetector(
      onTap: () => onPress.call(!value),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: effectiveColor,
            width: 2,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: SizedBox.square(
          dimension: 32,
          child: Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: effectiveColor,
                borderRadius: const BorderRadius.all(Radius.circular(2)),
              ),
              child: const SizedBox.square(dimension: 16),
            ),
          ),
        ),
      ),
    );
  }
}
