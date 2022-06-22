// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/load_status.dart';
import '../../repositories/movie_repository.dart';
import 'detail_state.dart';

class DetailMovieCubit extends Cubit<DetailMovieState> {
  MovieRepository detailRepository;
  String movieId;

  DetailMovieCubit(
    this.detailRepository,
    this.movieId,
  ) : super(DetailMovieState());

  void init() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    try {
      final result = await detailRepository.getDetailMovie(movieId);
      final apiCast = await detailRepository.getCast(movieId);
      if (result != null || apiCast != null) {
        emit(state.copyWith(
          detail: result,
          castResponse: apiCast,
          loadStatus: LoadStatus.success,
        ));
      } else {
        emit(state.copyWith(loadStatus: LoadStatus.failure));
      }
    } catch (e, s) {
      print('Huynq : $e');
      print('Huynq : $s');
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }
}
