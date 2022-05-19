// ignore_for_file: avoid_print

import 'package:do_an_movie/models/load_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/movie_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  late MovieRepository movieRepository;

  HomeCubit(this.movieRepository) : super(HomeState());

  void init() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    try {
      final apiNowPlay = await movieRepository.getNowMovie();
      final apiUpComing = await movieRepository.getUpComingMovie();
      if (apiNowPlay != null || apiUpComing != null) {
        emit(
          state.copyWith(
            nowPlay: apiNowPlay,
            upComing: apiUpComing,
            loadStatus: LoadStatus.success,
          ),
        );
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
