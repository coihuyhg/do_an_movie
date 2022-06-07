import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class MainState extends Equatable {
  int selectIndex;
  bool tab;

  MainState({this.selectIndex = 0, this.tab = false});

  MainState copyWith({
    int? selectIndex,
    bool? tab,
  }) {
    return MainState(
      selectIndex: selectIndex ?? this.selectIndex,
      tab: tab ?? this.tab,
    );
  }

  @override
  List<Object> get props => [selectIndex, tab];
}
