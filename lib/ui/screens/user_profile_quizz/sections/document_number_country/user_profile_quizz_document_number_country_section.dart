import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viswals_flutter_interview_task/models/country.dart';
import 'package:viswals_flutter_interview_task/state/user_profile_provider.dart';
import 'package:viswals_flutter_interview_task/ui/screens/number_input_screen.dart/number_input_screen.dart';
import 'package:viswals_flutter_interview_task/ui/style/app_colors.dart';
import 'package:viswals_flutter_interview_task/ui/style/text/montserrat_text_styles.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/content_field.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/country_selection_dialog.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/primary_button.dart';
import 'package:viswals_flutter_interview_task/utils/functions.dart';

class UserProfileQuizzDocumentNumberCountrySection extends StatelessWidget {
  const UserProfileQuizzDocumentNumberCountrySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context, provider, _) {
        final isActive =
            provider.documentNumber != null && provider.documentCountry != null;

        return Column(
          children: [
            ContentField(
              label: 'Number',
              content: provider.documentNumber,
              onTap: () async {
                final result = await Navigator.of(context).push<String>(
                  MaterialPageRoute(
                    builder: (context) =>
                        NumberInputScreen(number: provider.documentNumber),
                  ),
                );
                if (result == null) return;
                provider.setDocumentNumber(result);
              },
            ),
            const SizedBox(height: 16),
            ContentField(
              label: 'Country',
              content: provider.documentCountry?.name.common,
              trailingIcon: Icons.arrow_drop_down,
              onTap: () async {
                final result = await showAppModalDialogSheet<Country>(
                  context: context,
                  child: CountrySelectionDialog(
                    selectedCountry: provider.documentCountry,
                  ),
                );
                if (result == null) return;
                provider.setDocumentCountry(result);
              },
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    backgroundColor: AppColors.grey,
                    label: Text(
                      'PREV',
                      style: MontserratTextStyles.label13Bold
                          .copyWith(color: AppColors.grey2),
                    ),
                    onTap: provider.previousSection,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: PrimaryButton(
                    backgroundColor:
                        isActive ? AppColors.blue : AppColors.blueOpacity15,
                    label: Text(
                      'NEXT',
                      style: MontserratTextStyles.label13Bold.copyWith(
                        color: isActive
                            ? AppColors.white
                            : AppColors.whiteOpacity15,
                      ),
                    ),
                    onTap: isActive ? provider.jumpToNextSection : null,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
