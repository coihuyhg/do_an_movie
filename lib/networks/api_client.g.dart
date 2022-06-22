// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiClient implements ApiClient {
  _ApiClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://api.themoviedb.org/3';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<NowPlayingResponse> getNowPlaying() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<NowPlayingResponse>(Options(
                method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options,
                '/movie/now_playing?api_key=26763d7bf2e94098192e629eb975dab0',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = NowPlayingResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UpComingResponse> getUpComingMovie() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UpComingResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options,
                    '/movie/upcoming?api_key=26763d7bf2e94098192e629eb975dab0',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UpComingResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DetailResponse> getDetail(movieId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DetailResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options,
                    '/movie/$movieId?api_key=26763d7bf2e94098192e629eb975dab0',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DetailResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CastResponse> getCast(movieID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        CastResponse>(Options(
            method: 'GET', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/movie/$movieID/credits?api_key=26763d7bf2e94098192e629eb975dab0',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CastResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
