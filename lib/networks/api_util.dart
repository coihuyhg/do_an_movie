import 'package:dio/dio.dart';
import 'package:do_an_movie/networks/api_client.dart';
import 'package:do_an_movie/networks/api_interceptors.dart';

class ApiUtil {
  late Dio dio;
  late ApiClient apiClient;

  ApiUtil._privateConstructor() {
    dio = Dio();
    dio.options.connectTimeout = 1500;
    dio.interceptors.add(ApiInterceptors());
    apiClient = ApiClient(dio, baseUrl: 'http://api.themoviedb.org/3');
  }

  static final ApiUtil instance = ApiUtil._privateConstructor();
}
