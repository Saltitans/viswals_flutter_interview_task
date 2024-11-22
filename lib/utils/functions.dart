import 'package:flutter/material.dart';
import 'package:viswals_flutter_interview_task/ui/style/app_colors.dart';

Future<T?> showAppModalBottomSheet<T>({
  required BuildContext context,
  required Widget child,
}) async =>
    showModalBottomSheet<T>(
      context: context,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.blackOpacity95,
      builder: (context) => child,
    );

Future<T?> showAppModalDialogSheet<T>({
  required BuildContext context,
  required Widget child,
}) async =>
    showDialog<T>(
      context: context,
      barrierColor: AppColors.blackOpacity95,
      builder: (context) => child,
    );
