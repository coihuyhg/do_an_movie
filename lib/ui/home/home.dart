import 'package:cached_network_image/cached_network_image.dart';
import 'package:do_an_movie/blocs/detail_bloc/detail_cubit.dart';
import 'package:do_an_movie/blocs/home_bloc/home_cubit.dart';
import 'package:do_an_movie/blocs/home_bloc/home_state.dart';
import 'package:do_an_movie/models/now_play_response.dart';
import 'package:do_an_movie/repositories/movie_repository.dart';
import 'package:do_an_movie/ui/home/widgets/movie_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'detail_movie.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late List<Result> movies;
  late HomeCubit _cubit;
  late PageController _pageController;
  int activePageIndex = 0;

  @override
  void initState() {
    _cubit = BlocProvider.of<HomeCubit>(context);
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
      appBar: AppBar(
        title: const Text(
          'Start Movie',
          style: TextStyle(fontSize: 26, color: Color(0xFF0F1B2B)),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: Image.asset('assets/icons/ic_zoom.png'))
        ],
        backgroundColor: const Color(0xFFFFFFFF),
      ),
      body: SingleChildScrollView(
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
                  padding: const EdgeInsets.only(top: 20.0),
                  child: _menuBar(context, width * 0.9, height * 0.056),
                ),
                SizedBox(height: height * 0.01),
                Expanded(
                  flex: 2,
                  child: PageView(
                    controller: _pageController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    onPageChanged: (int index) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        activePageIndex = index;
                      });
                    },
                    children: <Widget>[
                      _buildListFirst(),
                      BlocBuilder<HomeCubit, HomeState>(
                        bloc: _cubit,
                        buildWhen: (pre, cur) =>
                            pre.loadStatus != cur.loadStatus,
                        builder: (context, state) {
                          return GridView.builder(
                            padding: const EdgeInsets.all(18),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 360,
                              crossAxisCount: 2,
                            ),
                            itemCount: state.upComing?.results?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return BlocProvider<DetailMovieCubit>(
                                          create: (context) {
                                            final repository =
                                                RepositoryProvider.of<
                                                    MovieRepository>(context);
                                            return DetailMovieCubit(
                                                repository,
                                                state.upComing?.results?[index]
                                                        .id
                                                        .toString() ??
                                                    '');
                                          },
                                          child: const DetailMovie(),
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        child: Image(
                                          image: CachedNetworkImageProvider(
                                              'https://image.tmdb.org/t/p/original${state.upComing?.results?[index].posterPath}'),
                                          width: width * 0.5,
                                          height: height * 0.33,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      SizedBox(height: height * 0.01),
                                      Text(
                                        '${state.upComing?.results?[index].title}',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF0F1B2B)),
                                      ),
                                      SizedBox(height: height * 0.01),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            '⭐ ${state.upComing?.results?[index].voteAverage ?? ''}',
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(width: width * 0.06),
                                          Text(
                                            '${state.upComing?.results?[index].voteCount ?? ''}  👍',
                                            style:
                                                const TextStyle(fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListFirst() {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: _cubit,
      buildWhen: (pre, cur) => pre.loadStatus != cur.loadStatus,
      builder: (context, state) {
        List<Result> results = state.nowPlay?.results ?? [];
        List<MovieItemWidget> widgets = results
            .map((e) => MovieItemWidget(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return BlocProvider<DetailMovieCubit>(
                  //         create: (context) {
                  //           final repository =
                  //               RepositoryProvider.of<MovieRepository>(
                  //                   context);
                  //           return DetailMovieCubit(
                  //               repository,
                  //               state.upComing?.results?[e].id.toString() ??
                  //                   '');
                  //         },
                  //         child: const DetailMovie(),
                  //       );
                  //     },
                  //   ),
                  // );
                },
                resultEntity: e))
            .toList();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: (164 / 320),
            mainAxisSpacing: 27,
            crossAxisSpacing: 12,
            controller: ScrollController(keepScrollOffset: false),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: widgets,
          ),
        );
      },
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
          Expanded(child: _nowMovie(width * 0.166, height * 0.8)),
          Expanded(child: _comingMovie(width * 0.166, height * 0.8)),
        ],
      ),
    );
  }

  Widget _comingMovie(double width, double height) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(25.0)),
      onTap: _onComingPress,
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
        child: activePageIndex == 0
            ? Text(
                "Coming Soon",
                style: (activePageIndex == 1)
                    ? const TextStyle(color: Color(0xFFFFFFFF), fontSize: 16)
                    : const TextStyle(color: Color(0xFF0F1B2B), fontSize: 16),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/ic_play.png'),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    "Coming Soon",
                    style: (activePageIndex == 1)
                        ? const TextStyle(
                            color: Color(0xFFFFFFFF), fontSize: 16)
                        : const TextStyle(
                            color: Color(0xFF0F1B2B), fontSize: 16),
                  )
                ],
              ),
      ),
    );
  }

  Widget _nowMovie(double width, double height) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(25.0)),
      onTap: _onNowMoviePress,
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.only(left: 4, top: 4, bottom: 4),
        alignment: Alignment.center,
        decoration: (activePageIndex == 0)
            ? const BoxDecoration(
                color: Color(0xFFE51937),
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
              )
            : null,
        child: activePageIndex == 0
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/ic_play.png'),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    "Now Showing",
                    style: (activePageIndex == 0)
                        ? const TextStyle(
                            color: Color(0xFFFFFFFF), fontSize: 16)
                        : const TextStyle(
                            color: Color(0xFF0F1B2B), fontSize: 16),
                  ),
                ],
              )
            : Text(
                "Now Showing",
                style: (activePageIndex == 0)
                    ? const TextStyle(color: Color(0xFFFFFFFF), fontSize: 16)
                    : const TextStyle(color: Color(0xFF0F1B2B), fontSize: 16),
              ),
      ),
    );
  }

  void _onNowMoviePress() {
    _pageController.animateToPage(0,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onComingPress() {
    _pageController.animateToPage(1,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }
}
