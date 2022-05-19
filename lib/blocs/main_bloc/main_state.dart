import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class MainState extends Equatable {
  int selectIndex;

  MainState({this.selectIndex = 0});

  MainState copyWith({
  int? selectIndex,
}) {
    return MainState(selectIndex: selectIndex ?? this.selectIndex);
  }

  @override
  List<Object> get props => [
    selectIndex,
  ];
}