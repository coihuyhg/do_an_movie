import 'package:do_an_movie/blocs/main_bloc/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/main_bloc/main_state.dart';
import '../home/home.dart';
import '../notification/notification.dart';
import '../ticket/ticket.dart';
import '../user/login.dart';
import 'main_tab.dart';

class MainUi extends StatefulWidget {
  const MainUi({Key? key}) : super(key: key);

  @override
  State<MainUi> createState() => _MainUiState();
}

class _MainUiState extends State<MainUi> {
  late List<Widget> pageList;
  late PageController pageController;

  final tabs = [
    MainTab.home,
    MainTab.ticket,
    MainTab.notification,
    MainTab.user,
  ];

  late MainCubit _cubit;

  @override
  void initState() {
    _cubit = MainCubit();
    // TODO: implement initState
    super.initState();
    pageController = PageController();
    pageList = const [
      Home(),
      Ticket(),
      Notifi(),
      User(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _body() {
    return PageView(
      controller: pageController,
      children: pageList,
      onPageChanged: (index) {
        _cubit.tap(index);
      },
    );
  }

  Widget _bottomNavigationBar() {
    return BlocConsumer<MainCubit, MainState>(
      bloc: _cubit,
      listenWhen: (prev, current) {
        return prev.selectIndex != current.selectIndex;
      },
      listener: (context, state) {
        pageController.jumpToPage(state.selectIndex);
      },
      buildWhen: (prev, current) {
        return prev.selectIndex != current.selectIndex;
      },
      builder: (context, state) {
        return BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: const Color(0xFFFFFFFF),
          currentIndex: state.selectIndex,
          // unselectedItemColor: Colors.red,
          // selectedItemColor: Colors.green,
          type: BottomNavigationBarType.fixed,
          items: tabs.map((e) => e.tab).toList(),
          onTap: (index) {
            _cubit.tap(index);
          },
        );
      },
    );
  }
}
