import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:viswals_flutter_interview_task/ui/style/app_colors.dart';
import 'package:viswals_flutter_interview_task/ui/style/text/roboto_text_styles.dart';

class AppTextField extends HookWidget {
  const AppTextField({
    super.key,
    required this.controller,
    this.autofocus = false,
    this.borderColor = AppColors.blue,
    this.borderRadius = 7.0,
    this.backgroundColor,
    required this.label,
    this.labelColor,
    this.keyboardType,
    this.inputFormatters,
    this.prefixIcon,
  });

  final TextEditingController controller;
  final bool autofocus;
  final Color borderColor;
  final double borderRadius;
  final Color? backgroundColor;
  final String label;
  final Color? labelColor;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    final displaySuffixIcon = useState<bool>(false);

    useEffect(() {
      void onInputReact() {
        if (controller.text.isNotEmpty) {
          displaySuffixIcon.value = true;
          return;
        }
        displaySuffixIcon.value = false;
      }

      controller.addListener(onInputReact);

      return () {
        controller.removeListener(onInputReact);
      };
    });

    final border = OutlineInputBorder(
      borderSide: BorderSide(color: borderColor),
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
    );

    final effectiveBackgroundColor = backgroundColor ?? Colors.transparent;

    final effectiveLabelColor = labelColor ?? AppColors.grey2;

    return SizedBox(
      height: 48,
      child: Theme(
        data: ThemeData(
          textSelectionTheme: const TextSelectionThemeData(
            selectionHandleColor: AppColors.blue,
          ),
        ),
        child: TextField(
          controller: controller,
          autofocus: autofocus,
          style:
              RobotoTextStyles.label13Regular.copyWith(color: AppColors.white),
          cursorColor: AppColors.blue,
          cursorWidth: 1,
          decoration: InputDecoration(
            filled: true,
            fillColor: effectiveBackgroundColor,
            focusColor: effectiveBackgroundColor,
            border: border,
            enabledBorder: border,
            focusedBorder: border,
            hintText: label,
            hintStyle: RobotoTextStyles.label13Regular
                .copyWith(color: effectiveLabelColor),
            prefixIcon: prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 12, right: 8),
                    child: prefixIcon,
                  )
                : null,
            prefixIconConstraints: const BoxConstraints(),
            suffixIcon: displaySuffixIcon.value
                ? GestureDetector(
                    onTap: controller.clear,
                    child: const Icon(
                      Icons.cancel,
                      size: 16,
                      color: AppColors.blue,
                    ),
                  )
                : null,
          ),
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
        ),
      ),
    );
  }
}
