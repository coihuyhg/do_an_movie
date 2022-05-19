import 'package:do_an_movie/models/load_status.dart';
import 'package:do_an_movie/models/now_play_response.dart';
import 'package:do_an_movie/models/up_coming_response.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class HomeState extends Equatable {
  LoadStatus? loadStatus;
  NowPlayingResponse? nowPlay;
  UpComingResponse? upComing;

  HomeState({this.loadStatus, this.nowPlay, this.upComing});

  HomeState copyWith({
    LoadStatus? loadStatus,
    NowPlayingResponse? nowPlay,
    UpComingResponse? upComing,
  }) {
    return HomeState(
      loadStatus: loadStatus ?? loadStatus,
      nowPlay: nowPlay ?? nowPlay,
      upComing: upComing ?? upComing,
    );
  }

  @override
  List<Object?> get props => [
        loadStatus,
        nowPlay,
        upComing,
      ];
}
