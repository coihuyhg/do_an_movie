import 'package:cached_network_image/cached_network_image.dart';
import 'package:do_an_movie/blocs/detail_bloc/detail_cubit.dart';
import 'package:do_an_movie/blocs/detail_bloc/detail_state.dart';
import 'package:do_an_movie/models/cast_response.dart';
import 'package:do_an_movie/ui/home/cast.dart';
import 'package:do_an_movie/ui/home/widgets/item_cast_widget.dart';
import 'package:do_an_movie/ui/home/widgets/star_item.dart';
import 'package:do_an_movie/ui/user/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';

class DetailMovie extends StatefulWidget {
  const DetailMovie({Key? key}) : super(key: key);

  @override
  State<DetailMovie> createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie>
    with SingleTickerProviderStateMixin {
  String dropdownValue = 'Paragon Cinema';
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
                      StarItem(rate: state.detail?.voteAverage ?? 0),
                      const SizedBox(height: 40),
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
                                          state.detail?.voteAverage ?? 0),
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
          const SizedBox(height: 16),
          SizedBox(
              height: 72,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE51937),
                      borderRadius: BorderRadius.circular(4.0),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey.withOpacity(0.6),
                      //     spreadRadius: 2,
                      //     blurRadius: 7,
                      //     offset: Offset(0, 0), // changes position of shadow
                      //   ),
                      // ],
                    ),
                    width: 88,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Today',
                            style: TextStyle(
                                fontSize: 18, color: Color(0xFFFFFFFF))),
                        SizedBox(height: 4),
                        Text('WED',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xFFFFFFFF))),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(2.0),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey.withOpacity(0.2),
                      //     spreadRadius: 5,
                      //     blurRadius: 7,
                      //     offset: Offset(0, 0), // changes position of shadow
                      //   ),
                      // ],
                    ),
                    width: 88,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('23 May',
                            style: TextStyle(
                                fontSize: 18, color: Color(0xFF0F1B2B))),
                        SizedBox(height: 4),
                        Text('THU',
                            style: TextStyle(
                                fontSize: 16, color: Color(0x800F1B2B))),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 88,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(2.0),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey.withOpacity(0.2),
                      //     spreadRadius: 5,
                      //     blurRadius: 7,
                      //     offset: Offset(0, 0), // changes position of shadow
                      //   ),
                      // ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('24 May',
                            style: TextStyle(
                                fontSize: 18, color: Color(0xFF0F1B2B))),
                        SizedBox(height: 4),
                        Text('FRI',
                            style: TextStyle(
                                fontSize: 16, color: Color(0x800F1B2B))),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 88,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(2.0),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey.withOpacity(0.2),
                      //     spreadRadius: 5,
                      //     blurRadius: 7,
                      //     offset: Offset(0, 0), // changes position of shadow
                      //   ),
                      // ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('25 May',
                            style: TextStyle(
                                fontSize: 18, color: Color(0xFF0F1B2B))),
                        SizedBox(height: 4),
                        Text('SAT',
                            style: TextStyle(
                                fontSize: 16, color: Color(0x800F1B2B))),
                      ],
                    ),
                  ),
                ],
              )),
          const SizedBox(height: 35),
          const Text(
            'Chosse Cinema',
            style: TextStyle(
                fontSize: 20,
                color: Color(0xFF0F1B2B),
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide:
                    const BorderSide(color: Color(0xFFE51937), width: 2),
              ),
              border: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xFFE51937), width: 2),
                borderRadius: BorderRadius.circular(4),
              ),
              filled: true,
              fillColor: const Color(0xFFFFFFFF),
            ),
            value: dropdownValue,
            icon: Image.asset('assets/icons/ic_triangle-down.png'),
            style: const TextStyle(fontSize: 18, color: Color(0xFF0F1B2B)),
            items: <String>[
              'Paragon Cinema',
              'Paragon Cinema1',
              'Paragon Cinema2',
              'Paragon Cinema3',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
          ),
          const SizedBox(height: 24),
          const Text(
            '2D',
            style: TextStyle(fontSize: 20, color: Color(0x800F1B2B)),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.count(
                primary: false,
                padding: const EdgeInsets.only(left: 10),
                crossAxisCount: 3,
                children: [
                  Container(
                    height: 48,
                    width: 102,
                    color: Colors.teal[100],
                    child: const Center(child: Text('8:30 AM')),
                  ),
                  Container(
                    height: 48,
                    width: 102,
                    color: Colors.teal[200],
                    child: const Center(child: Text('9:30 AM')),
                  ),
                  Container(
                    height: 48,
                    width: 102,
                    color: Colors.teal[300],
                    child: const Center(child: Text('10:00 AM')),
                  ),
                  Container(
                    height: 48,
                    width: 102,
                    color: Colors.teal[400],
                    child: const Center(child: Text('12:30 PM')),
                  ),
                  Container(
                    height: 48,
                    width: 102,
                    color: Colors.teal[500],
                    child: const Center(child: Text('13:45 PM')),
                  ),
                  Container(
                    height: 48,
                    width: 102,
                    color: Colors.teal[500],
                    child: const Center(child: Text('15:00 PM')),
                  ),
                ]),
          ),
          const SizedBox(height: 24),
          const Text(
            'Imax',
            style: TextStyle(fontSize: 20, color: Color(0x800F1B2B)),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.count(
                primary: false,
                padding: const EdgeInsets.only(left: 10, top: 16),
                crossAxisCount: 3,
                children: [
                  Container(
                    height: 48,
                    width: 102,
                    color: Colors.teal[100],
                    child: const Center(child: Text('8:30 AM')),
                  ),
                  Container(
                    height: 48,
                    width: 102,
                    color: Colors.teal[200],
                    child: const Center(child: Text('9:30 AM')),
                  ),
                  Container(
                    height: 48,
                    width: 102,
                    color: Colors.teal[300],
                    child: const Center(child: Text('10:00 AM')),
                  ),
                  Container(
                    height: 48,
                    width: 102,
                    color: Colors.teal[400],
                    child: const Center(child: Text('12:30 PM')),
                  ),
                  Container(
                    height: 48,
                    width: 102,
                    color: Colors.teal[500],
                    child: const Center(child: Text('13:45 PM')),
                  ),
                  Container(
                    height: 48,
                    width: 102,
                    color: Colors.teal[500],
                    child: const Center(child: Text('15:00 PM')),
                  ),
                ]),
          ),
          const SizedBox(height: 38),
          UserElevatedButton(
            onPressed: () {},
            text: 'Get Ticket',
          )
        ],
      ),
    );
  }

  Widget reviewsTap(double rate) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          StarItem(rate: rate),
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
          ReadMoreText(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0x800F1B2B),
            ),
            trimLength: 150,
            trimLines: 2,
            moreStyle: const TextStyle(
              fontSize: 16,
              color: Color(0xFF47CFFF),
            ),
            trimCollapsedText: 'Show more',
            trimExpandedText: 'Show less',
            lessStyle: const TextStyle(
              fontSize: 16,
              color: Color(0xFF47CFFF),
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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CastCrew()));
                },
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
          // _castAndCrew(),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(flex: 1, child: Container()),
                    const Expanded(flex: 3, child: Text('nameCast')),
                    const Expanded(flex: 1, child: Text('...')),
                    const Expanded(flex: 2, child: Text('Name')),
                  ],
                );
              },
            ),
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
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(right: 10),
                          color: Colors.redAccent,
                          width: 164,
                          height: 120),
                      const SizedBox(height: 12),
                      const Text(
                        '3 hours ago',
                        style:
                            TextStyle(fontSize: 14, color: Color(0x800F1B2B)),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Female Action',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF0F1B2B)),
                      ),
                    ],
                  ),
                );
              },
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

  // Widget _castAndCrew() {
  //   return BlocBuilder<DetailMovieCubit,DetailMovieState>(builder: (context, state) {
  //     List<Cast> castEntity = state.castResponse?.cast ?? [];
  //     List<CastItemWidget> itemCast = castEntity.map((e) => CastItemWidget(castEntity: e)).toList();
  //     return Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: ListView(
  //         children: itemCast,
  //       ),
  //     );
  //   },);
  // }

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
