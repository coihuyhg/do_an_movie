import 'package:dio/dio.dart';
import 'package:do_an_movie/models/detail_response.dart';
import 'package:do_an_movie/models/now_play_response.dart';
import 'package:do_an_movie/models/up_coming_response.dart';
import 'package:retrofit/http.dart';

part 'api_client.g.dart';

const bareUrl = 'http://api.themoviedb.org/3';
const key = '26763d7bf2e94098192e629eb975dab0';

@RestApi(baseUrl: bareUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('/movie/now_playing?api_key=$key')
  Future<NowPlayingResponse> getNowPlaying();

  @GET('/movie/upcoming?api_key=$key')
  Future<UpComingResponse> getUpComingMovie();

  @GET('/movie/{movie_id}?api_key=$key')
  Future<DetailResponse> getDetail(@Path("movie_id") String movieId);
}
