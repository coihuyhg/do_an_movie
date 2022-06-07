import 'package:cached_network_image/cached_network_image.dart';
import 'package:do_an_movie/blocs/detail_bloc/detail_cubit.dart';
import 'package:do_an_movie/blocs/detail_bloc/detail_state.dart';
import 'package:flutter/cupertino.dart';
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
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
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
                                      detailTap(state.detail?.overview ?? ''),
                                      reviewsTap(
                                          '${state.detail?.voteAverage ?? ''}/10 ⭐'),
                                      showTimeTap(),
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

  Widget showTimeTap() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Chosse Date',
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF0F1B2B),
                    fontWeight: FontWeight.bold),
              ),
              Image.asset('assets/icons/ic_calendar.png')
            ],
          ),
          const Text(
            'Chosse Cinema',
            style: TextStyle(
                fontSize: 20,
                color: Color(0xFF0F1B2B),
                fontWeight: FontWeight.bold),
          ),
          const Text(
            '2D',
            style: TextStyle(fontSize: 20, color: Color(0x800F1B2B)),
          ),
          const Text(
            'Imax',
            style: TextStyle(fontSize: 20, color: Color(0x800F1B2B)),
          )
        ],
      ),
    );
  }

  Widget reviewsTap(String rate) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            rate,
            style: const TextStyle(
                fontSize: 32,
                color: Color(0xFF0F1B2B),
                fontWeight: FontWeight.bold),
          ),
          const Text(
            '38 Reviews',
            style: TextStyle(fontSize: 18, color: Color(0x800F1B2B)),
          ),
        ],
      ),
    );
  }

  Widget detailTap(String text) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Synopsis',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            text,
            // state.detail?.overview ?? '',
            style: const TextStyle(
              fontSize: 16,
              color: Color(0x800F1B2B),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Cast & Crew',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF47CFFF),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          //Thêm diễn viên
          Row(
            children: [
              Image.asset('assets/icons/ic_calendar.png'),
              const Text('Keanu Reeves')
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Photos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF47CFFF),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                    margin: const EdgeInsets.only(right: 10),
                    color: Colors.redAccent,
                    width: 104,
                    height: 72),
                Container(
                    margin: const EdgeInsets.only(right: 10),
                    color: Colors.amber,
                    width: 104,
                    height: 72),
                Container(
                    margin: const EdgeInsets.only(right: 10),
                    color: Colors.greenAccent,
                    width: 104,
                    height: 72),
                Container(
                    margin: const EdgeInsets.only(right: 10),
                    color: Colors.blueAccent,
                    width: 104,
                    height: 72),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Videos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF47CFFF),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                    margin: const EdgeInsets.only(right: 10),
                    color: Colors.redAccent,
                    width: 104,
                    height: 72),
                Container(
                    margin: const EdgeInsets.only(right: 10),
                    color: Colors.amber,
                    width: 104,
                    height: 72),
                Container(
                    margin: const EdgeInsets.only(right: 10),
                    color: Colors.greenAccent,
                    width: 104,
                    height: 72),
                Container(
                    margin: const EdgeInsets.only(right: 10),
                    color: Colors.blueAccent,
                    width: 104,
                    height: 72),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Blogs About This Film',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF47CFFF),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(right: 10),
                        color: Colors.redAccent,
                        width: 104,
                        height: 72),
                    const Text(
                      '3 hours ago',
                      style: TextStyle(fontSize: 14, color: Color(0x800F1B2B)),
                    ),
                    const Text(
                      'Female Action Starts We Can\'t Wait',
                      style: TextStyle(fontSize: 16, color: Color(0xFF0F1B2B)),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(right: 10),
                        color: Colors.redAccent,
                        width: 104,
                        height: 72),
                    const Text(
                      '3 hours ago',
                      style: TextStyle(fontSize: 14, color: Color(0x800F1B2B)),
                    ),
                    const Text(
                      'Female Action Starts We Can\'t Wait',
                      style: TextStyle(fontSize: 16, color: Color(0xFF0F1B2B)),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(right: 10),
                        color: Colors.redAccent,
                        width: 104,
                        height: 72),
                    const Text(
                      '3 hours ago',
                      style: TextStyle(fontSize: 14, color: Color(0x800F1B2B)),
                    ),
                    const Text(
                      'Female Action Starts We Can\'t Wait',
                      style: TextStyle(fontSize: 16, color: Color(0xFF0F1B2B)),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(right: 10),
                        color: Colors.redAccent,
                        width: 104,
                        height: 72),
                    const Text(
                      '3 hours ago',
                      style: TextStyle(fontSize: 14, color: Color(0x800F1B2B)),
                    ),
                    const Text(
                      'Female Action Starts We Can\'t Wait',
                      style: TextStyle(fontSize: 16, color: Color(0xFF0F1B2B)),
                    ),
                  ],
                ),
              ],
            ),
          )
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
