import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:viswals_flutter_interview_task/models/country.dart';
import 'package:viswals_flutter_interview_task/services/countries_service.dart';
import 'package:viswals_flutter_interview_task/ui/style/app_colors.dart';
import 'package:viswals_flutter_interview_task/ui/style/text/montserrat_text_styles.dart';
import 'package:viswals_flutter_interview_task/ui/style/text/roboto_text_styles.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/app_loading_indicator.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/app_text_field.dart';
import 'package:viswals_flutter_interview_task/ui/widgets/primary_button.dart';
import 'package:viswals_flutter_interview_task/utils/hooks.dart';

class CountrySelectionDialogState with ChangeNotifier {
  CountrySelectionDialogState({
    required CountriesService countriesService,
  }) {
    _countriesService = countriesService;
    getCountries();
  }

  late final CountriesService _countriesService;

  var _isLoading = false;
  var _hasError = false;
  var _countries = <Country>[];
  var _effectiveCountries = <Country>[];

  bool get isLoading => _isLoading;

  bool get hasError => _hasError;

  List<Country> get countries => _effectiveCountries;

  void getCountries() {
    _isLoading = true;
    _countriesService.getAllCountries().then((countries) {
      _isLoading = false;
      _countries = countries;
      _effectiveCountries = countries;
      notifyListeners();
    }).onError((error, stackTrace) {
      _isLoading = false;
      _hasError = true;
      notifyListeners();
    });
    notifyListeners();
  }

  void setSearchValue(String searchValue) {
    final filteredCountries = _countries
        .where(
          (c) => c.name.common.contains(
            RegExp(
              searchValue,
              caseSensitive: false,
            ),
          ),
        )
        .toList();
    _effectiveCountries = filteredCountries;
    notifyListeners();
  }
}

class CountrySelectionDialog extends StatelessWidget {
  const CountrySelectionDialog({
    super.key,
    this.selectedCountry,
  });

  final Country? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CountriesService,
        CountrySelectionDialogState>(
      create: (context) {
        final countriesService =
            Provider.of<CountriesService>(context, listen: false);
        return CountrySelectionDialogState(
          countriesService: countriesService,
        );
      },
      update: (context, countriesService, countrySelectionDialogState) {
        return countrySelectionDialogState ??
            CountrySelectionDialogState(
              countriesService: countriesService,
            );
      },
      child: Material(
        type: MaterialType.transparency,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 52),
              Expanded(
                child: ClipRRect(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.black2,
                      border: Border.all(color: AppColors.darkGrey2),
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _DialogContent(
                        selectedCountry: selectedCountry,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              PrimaryButton(
                borderRadius: 80,
                backgroundColor: AppColors.black2,
                label: Text(
                  'CANCEL',
                  style: MontserratTextStyles.label13ExtraBold.copyWith(
                    color: AppColors.grey,
                  ),
                ),
                onTap: Navigator.of(context).maybePop,
              ),
              const SizedBox(height: 42),
              SizedBox(height: MediaQuery.viewInsetsOf(context).bottom),
            ],
          ),
        ),
      ),
    );
  }
}

class _DialogContent extends StatelessWidget {
  const _DialogContent({
    required this.selectedCountry,
  });

  final Country? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Consumer<CountrySelectionDialogState>(
      builder: (context, state, _) {
        return HookBuilder(
          builder: (context) {
            final searchController = useTextEditingController();

            useDebounceSearch(
              controller: searchController,
              onDebounce: state.setSearchValue,
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 26),
                Center(
                  child: Text(
                    'Country',
                    style: MontserratTextStyles.label20Black.copyWith(
                      color: AppColors.blue,
                    ),
                  ),
                ),
                const SizedBox(height: 26),
                AppTextField(
                  controller: searchController,
                  label: 'Search',
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 16,
                    color: AppColors.grey,
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  'Countries',
                  style: MontserratTextStyles.label13ExtraBold.copyWith(
                    color: AppColors.grey2,
                  ),
                ),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (state.isLoading) {
                        return const Center(
                          child: AppLoadingIndicator(),
                        );
                      }

                      if (state.hasError) {
                        Center(
                          child: Text(
                            'Something went wrong! Try again later!',
                            textAlign: TextAlign.center,
                            style: MontserratTextStyles.label13Regular.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        );
                      }

                      if (state.countries.isEmpty) {
                        return Center(
                          child: Text(
                            'No countries found',
                            textAlign: TextAlign.center,
                            style: MontserratTextStyles.label13Regular.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        );
                      }

                      return ListView.separated(
                        itemCount: state.countries.length,
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        separatorBuilder: (context, _) =>
                            const SizedBox(height: 30),
                        itemBuilder: (context, index) {
                          final country = state.countries[index];
                          return _CountryTile(
                            isSelected: selectedCountry?.name.common ==
                                country.name.common,
                            name: country.name.common,
                            onTap: () =>
                                Navigator.of(context).maybePop(country),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 5),
              ],
            );
          },
        );
      },
    );
  }
}

class _CountryTile extends StatelessWidget {
  const _CountryTile({
    required this.isSelected,
    required this.name,
    required this.onTap,
  });

  final bool isSelected;
  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: RobotoTextStyles.label13Regular
                  .copyWith(color: AppColors.grey),
            ),
          ),
          if (isSelected) ...[
            const SizedBox(width: 16),
            const DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
              child: Padding(
                padding: EdgeInsets.all(1),
                child: Icon(
                  Icons.flag,
                  size: 16,
                  color: AppColors.black2,
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ],
      ),
    );
  }
}
