import 'package:freezed_annotation/freezed_annotation.dart';

part 'country.freezed.dart';
part 'country.g.dart';

@freezed
class Country with _$Country {
  factory Country({
    required CountryName name,
  }) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
}

@freezed
class CountryName with _$CountryName {
  factory CountryName({
    required String common,
  }) = _CountryName;

  factory CountryName.fromJson(Map<String, dynamic> json) =>
      _$CountryNameFromJson(json);
}
