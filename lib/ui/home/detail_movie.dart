import 'package:cached_network_image/cached_network_image.dart';
import 'package:do_an_movie/blocs/detail_bloc/detail_cubit.dart';
import 'package:do_an_movie/blocs/detail_bloc/detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailMovie extends StatefulWidget {
  const DetailMovie({Key? key}) : super(key: key);

  @override
  State<DetailMovie> createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie>
    with SingleTickerProviderStateMixin {
  late DetailMovieCubit _cubit;
  late PageController _pageController;
  int activePageIndex = 0;

  @override
  void initState() {
    _cubit = BlocProvider.of<DetailMovieCubit>(context);
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
    _cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<DetailMovieCubit, DetailMovieState>(
            bloc: _cubit,
            buildWhen: (previous, current) =>
                previous.loadStatus != current.loadStatus,
            builder: (context, state) {
              return state.detail?.posterPath == null
                  ? Container(color: Colors.red)
                  : Image(
                      image: CachedNetworkImageProvider(
                          'https://image.tmdb.org/t/p/original${state.detail?.backdropPath ?? ''}'),
                      width: width,
                      height: height * 0.36,
                      fit: BoxFit.fill,
                    );
            },
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30)),
            ),
            margin: EdgeInsets.only(top: height * 0.3),
            width: width,
            height: height,
            child: BlocBuilder<DetailMovieCubit, DetailMovieState>(
              bloc: _cubit,
              buildWhen: (previous, current) =>
                  previous.loadStatus != current.loadStatus,
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.02, left: width * 0.04),
                        child: Text(
                          state.detail?.title ?? '',
                          style: const TextStyle(
                              fontSize: 24,
                              color: Color(0xFF0F1B2B),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: 75,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.detail?.genres?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.all(6),
                              width: 100,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFE51937),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                child: Text(
                                  state.detail?.genres?[index].name ?? '',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          child: SizedBox(
                            width: width,
                            height: height,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: _menuBar(
                                      context, width * 0.9, height * 0.056),
                                ),
                                SizedBox(height: height * 0.01),
                                Expanded(
                                  flex: 2,
                                  child: PageView(
                                    controller: _pageController,
                                    physics: const ClampingScrollPhysics(),
                                    onPageChanged: (int index) {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      setState(() {
                                        activePageIndex = index;
                                      });
                                    },
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: height * 0.02,
                                          left: width * 0.04,
                                          right: width * 0.04,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Synopsis',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: height * 0.01),
                                            Text(
                                              state.detail?.overview ?? '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Color(0x800F1B2B),
                                              ),
                                            ),
                                            SizedBox(height: height * 0.02),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Cast & Crew',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextButton(
                                                  onPressed: () {},
                                                  child: const Text(
                                                    'View All',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFF47CFFF),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: height * 0.01),
                                            //Thêm diễn viên
                                            Row(
                                              children: [
                                                Image.asset('name'),
                                                const Text('Keanu Reeves')
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      CustomScrollView(
                                        primary: false,
                                        slivers: <Widget>[
                                          SliverPadding(
                                            padding: const EdgeInsets.all(20),
                                            sliver: SliverGrid.count(
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                              crossAxisCount: 2,
                                              children: <Widget>[
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  color: Colors.green[100],
                                                  child: const Text(
                                                      "He'd have you all unravel at the"),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  color: Colors.green[200],
                                                  child: const Text(
                                                      'Heed not the rabble'),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  color: Colors.green[300],
                                                  child: const Text(
                                                      'Sound of screams but the'),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  color: Colors.green[400],
                                                  child:
                                                      const Text('Who scream'),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  color: Colors.green[500],
                                                  child: const Text(
                                                      'Revolution is coming...'),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  color: Colors.green[600],
                                                  child: const Text(
                                                      'Revolution, they...'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      CustomScrollView(
                                        primary: false,
                                        slivers: <Widget>[
                                          SliverPadding(
                                            padding: const EdgeInsets.all(20),
                                            sliver: SliverGrid.count(
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                              crossAxisCount: 2,
                                              children: <Widget>[
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  color: Colors.green[100],
                                                  child: const Text(
                                                      "He'd have you all unravel at the"),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  color: Colors.green[200],
                                                  child: const Text(
                                                      'Heed not the rabble'),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  color: Colors.green[300],
                                                  child: const Text(
                                                      'Sound of screams but the'),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  color: Colors.green[400],
                                                  child:
                                                      const Text('Who scream'),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  color: Colors.green[500],
                                                  child: const Text(
                                                      'Revolution is coming...'),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  color: Colors.green[600],
                                                  child: const Text(
                                                      'Revolution, they...'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: width * 0.05,
            top: height * 0.01,
            child: SafeArea(
              bottom: false,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset('assets/icons/ic_arrow.png'),
              ),
            ),
          ),
          Positioned(
            right: width * 0.05,
            top: height * 0.01,
            child: SafeArea(
              bottom: false,
              child: IconButton(
                onPressed: () {},
                icon: Image.asset('assets/icons/ic_respond-arrow.png'),
              ),
            ),
          ),
          Positioned(
            left: width * 0.35,
            right: width * 0.35,
            top: height * 0.07,
            child: SafeArea(
              bottom: false,
              child: IconButton(
                onPressed: () {},
                icon: Image.asset(
                  'assets/icons/ic_playVideo.png',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuBar(BuildContext context, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: const Color(0xFF0F1B2B)),
        borderRadius: const BorderRadius.all(Radius.circular(25.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(child: _detail(width * 0.166, height * 0.8)),
          Expanded(child: _review(width * 0.166, height * 0.8)),
          Expanded(child: _showtime(width * 0.166, height * 0.8)),
        ],
      ),
    );
  }

  Widget _showtime(double width, double height) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(25.0)),
      onTap: _onShowTimePress,
      child: Container(
          width: width,
          height: height,
          margin: const EdgeInsets.only(top: 4, bottom: 4, right: 4),
          alignment: Alignment.center,
          decoration: (activePageIndex == 2)
              ? const BoxDecoration(
                  color: Color(0xFFE51937),
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                )
              : null,
          child: Text(
            "Showtime",
            style: (activePageIndex == 2)
                ? const TextStyle(color: Color(0xFFFFFFFF), fontSize: 16)
                : const TextStyle(color: Color(0xFF0F1B2B), fontSize: 16),
          )),
    );
  }

  Widget _review(double width, double height) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(25.0)),
      onTap: _onReviewsPress,
      child: Container(
          width: width,
          height: height,
          margin: const EdgeInsets.only(top: 4, bottom: 4, right: 4),
          alignment: Alignment.center,
          decoration: (activePageIndex == 1)
              ? const BoxDecoration(
                  color: Color(0xFFE51937),
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                )
              : null,
          child: Text(
            "Reviews",
            style: (activePageIndex == 1)
                ? const TextStyle(color: Color(0xFFFFFFFF), fontSize: 16)
                : const TextStyle(color: Color(0xFF0F1B2B), fontSize: 16),
          )),
    );
  }

  Widget _detail(double width, double height) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(25.0)),
      onTap: _onDetailPress,
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.only(left: 4, top: 4, bottom: 4),
        alignment: Alignment.center,
        decoration: (activePageIndex == 0)
            ? const BoxDecoration(
                color: Color(0xFFE51937),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              )
            : null,
        child: Text(
          "Detail",
          style: (activePageIndex == 0)
              ? const TextStyle(color: Color(0xFFFFFFFF), fontSize: 16)
              : const TextStyle(color: Color(0xFF0F1B2B), fontSize: 16),
        ),
      ),
    );
  }

  void _onDetailPress() {
    _pageController.animateToPage(0,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onReviewsPress() {
    _pageController.animateToPage(1,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onShowTimePress() {
    _pageController.animateToPage(2,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }
}
