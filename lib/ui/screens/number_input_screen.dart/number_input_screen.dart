import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:viswals_flutter_interview_task/ui/style/app_colors.dart';
import 'package:viswals_flutter_interview_task/ui/style/text/montserrat_text_styles.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/app_screen.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/app_text_field.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/primary_button.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/text_field_unfocuser.dart';

class NumberInputScreen extends HookWidget {
  const NumberInputScreen({
    super.key,
    this.number,
  });

  final String? number;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: number ?? '');
    final isInputValid = useState<bool>(false);

    useEffect(() {
      void inputValidator() {
        if (controller.text.length >= 8) {
          isInputValid.value = true;
          return;
        }
        isInputValid.value = false;
      }

      controller.addListener(inputValidator);

      return () {
        controller.removeListener(inputValidator);
      };
    });

    return TextFieldUnfocuser(
      child: AppScreen(
        resizeToAvoidBottomInset: true,
        backButton: const AppBackButton(),
        title: 'Number',
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 16),
              AppTextField(
                controller: controller,
                autofocus: true,
                borderColor: AppColors.blueOpacity50,
                borderRadius: 5,
                backgroundColor: AppColors.blueOpacity05,
                label: 'Number',
                labelColor: AppColors.darkGrey3,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(20),
                ],
              ),
              const Spacer(),
              PrimaryButton(
                backgroundColor: isInputValid.value
                    ? AppColors.blue
                    : AppColors.blueOpacity15,
                label: Text(
                  'SAVE',
                  style: MontserratTextStyles.label13Bold.copyWith(
                    color: isInputValid.value
                        ? AppColors.white
                        : AppColors.whiteOpacity15,
                  ),
                ),
                onTap: isInputValid.value
                    ? () => Navigator.of(context).maybePop(controller.text)
                    : null,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
