import 'package:flutter/cupertino.dart';

enum MainTab {
  home,
  ticket,
  notification,
  user,
}

extension MainTabExtension on MainTab {
  Widget get page {
    switch (this) {
      case MainTab.home:
      case MainTab.ticket:
      case MainTab.notification:
      case MainTab.user:
    }
    return Container();
  }

  BottomNavigationBarItem get tab {
    switch (this) {
      case MainTab.home:
        return BottomNavigationBarItem(
            icon: Image.asset('assets/icons/ic_movie-reel@2x.png'),
            label: 'Home');
      case MainTab.ticket:
        return BottomNavigationBarItem(
            icon: Image.asset('assets/icons/ic_event-ticket@2x.png'),
            label: 'Ticket');
      case MainTab.notification:
        return BottomNavigationBarItem(
            icon: Image.asset('assets/icons/ic_alarm@2x.png'),
            label: 'Notification');
      case MainTab.user:
        return BottomNavigationBarItem(
            icon: Image.asset('assets/icons/ic_single-03@2x.png'),
            label: 'User');
    }
  }

  String get title {
    switch (this) {
      case MainTab.home:
        return 'Home';
      case MainTab.ticket:
        return 'Ticket';
      case MainTab.notification:
        return 'Notification';
      case MainTab.user:
        return 'User';
    }
  }
}
