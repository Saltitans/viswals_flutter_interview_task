import 'package:dio/dio.dart';
import 'package:viswals_flutter_interview_task/models/country.dart';

class CountriesService {
  CountriesService() {
    _dio = Dio(
      BaseOptions(baseUrl: 'https://restcountries.com/v3.1/'),
    );
  }

  late final Dio _dio;

  Future<List<Country>> getAllCountries() async {
    final result = await _dio.get<List<dynamic>>(
      'all',
      queryParameters: <String, dynamic>{'fields': 'name'},
    );

    if (result.data == null) throw Exception('Failed to fetch countries');

    return result.data!
        .map((e) => Country.fromJson(e as Map<String, dynamic>))
        .take(40)
        .toList();
  }
}
