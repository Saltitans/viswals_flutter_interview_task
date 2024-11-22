import 'package:flutter/material.dart';
import 'package:viswals_flutter_interview_task/ui/style/app_colors.dart';
import 'package:viswals_flutter_interview_task/ui/style/text/montserrat_text_styles.dart';

class AppTab {
  const AppTab({
    required this.label,
    required this.isComplete,
  });

  final String label;
  final bool isComplete;
}

class AppTabBar extends StatelessWidget {
  const AppTabBar({
    super.key,
    this.controller,
    required this.tabs,
  });

  final TabController? controller;
  final List<AppTab> tabs;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.darkGrey,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: TabBar(
          controller: controller,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: AppColors.black,
          ),
          padding: const EdgeInsets.all(2),
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: AppColors.transparent,
          labelPadding: EdgeInsets.zero,
          tabs: [
            for (final tab in tabs)
              Tab(
                child: Row(
                  children: [
                    const Spacer(),
                    Text(
                      tab.label,
                      style: MontserratTextStyles.label11Black.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: tab.isComplete
                                  ? AppColors.blue
                                  : AppColors.grey,
                              shape: BoxShape.circle,
                            ),
                            child: const SizedBox.square(dimension: 4),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
