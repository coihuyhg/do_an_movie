import 'package:do_an_movie/models/detail_response.dart';
import 'package:do_an_movie/models/now_play_response.dart';
import 'package:do_an_movie/models/up_coming_response.dart';
import 'package:do_an_movie/networks/api_client.dart';

abstract class MovieRepository {
  Future<NowPlayingResponse>? getNowMovie();
  Future<UpComingResponse>? getUpComingMovie();
  Future<DetailResponse>? getDetailMovie(String movieId);
}

class MovieRepositoryImpl extends MovieRepository {
  late ApiClient _apiClient;

  MovieRepositoryImpl(ApiClient apiClient) {
    _apiClient = apiClient;
  }

  @override
  Future<NowPlayingResponse> getNowMovie() async {
    return await _apiClient.getNowPlaying();
  }

  @override
  Future<UpComingResponse>? getUpComingMovie() async {
    return await _apiClient.getUpComingMovie();
  }

  @override
  Future<DetailResponse>? getDetailMovie(String movieId) async {
    return await _apiClient.getDetail(movieId);
  }
}