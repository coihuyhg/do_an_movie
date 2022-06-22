import 'package:equatable/equatable.dart';

import '../../models/cast_response.dart';
import '../../models/detail_response.dart';
import '../../models/load_status.dart';

// ignore: must_be_immutable
class DetailMovieState extends Equatable {
  LoadStatus? loadStatus;
  DetailResponse? detail;
  CastResponse? castResponse;

  DetailMovieState({this.loadStatus, this.detail, this.castResponse});

  DetailMovieState copyWith({
    LoadStatus? loadStatus,
    DetailResponse? detail,
    CastResponse? castResponse,
  }) {
    return DetailMovieState(
      loadStatus: loadStatus ?? this.loadStatus,
      detail: detail ?? this.detail,
      castResponse: castResponse ?? this.castResponse,
    );
  }

  @override
  List<Object?> get props => [loadStatus, detail, castResponse];
}
