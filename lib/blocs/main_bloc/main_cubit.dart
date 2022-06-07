import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainState());
  
  void tap(int index) {
    emit(state.copyWith(selectIndex: index));
  }

  void click() {
    emit(state.copyWith(tab: true));
  }
}