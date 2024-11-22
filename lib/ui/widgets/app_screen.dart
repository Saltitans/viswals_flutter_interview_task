import 'package:flutter/material.dart';
import 'package:viswals_flutter_interview_task/ui/style/app_colors.dart';
import 'package:viswals_flutter_interview_task/ui/style/text/montserrat_text_styles.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({
    super.key,
    this.resizeToAvoidBottomInset = false,
    this.backButton,
    this.title,
    this.actions = const [],
    required this.body,
  });

  final bool resizeToAvoidBottomInset;
  final AppBackButton? backButton;
  final String? title;
  final List<Widget> actions;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 44,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (backButton != null)
                    Expanded(
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          backButton!,
                        ],
                      ),
                    )
                  else
                    const Spacer(),
                  if (title != null)
                    Text(
                      title!,
                      style: MontserratTextStyles.label13Black.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  if (actions.isNotEmpty)
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ...actions,
                          const SizedBox(width: 20),
                        ],
                      ),
                    )
                  else
                    const Spacer(),
                ],
              ),
            ),
            Expanded(child: body),
          ],
        ),
      ),
    );
  }
}

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? Navigator.of(context).maybePop,
      child: const Icon(
        size: 28,
        Icons.chevron_left,
        color: AppColors.white,
      ),
    );
  }
}
