import 'package:cached_network_image/cached_network_image.dart';
import 'package:do_an_movie/blocs/detail_bloc/detail_cubit.dart';
import 'package:do_an_movie/blocs/detail_bloc/detail_state.dart';
import 'package:do_an_movie/models/cast_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CastCrew extends StatefulWidget {
  const CastCrew({Key? key}) : super(key: key);

  @override
  State<CastCrew> createState() => _CastCrewState();
}

class _CastCrewState extends State<CastCrew> {
  late final Cast castEntity;
  late DetailMovieCubit _cubit;

  @override
  // void initState() {
  //   _cubit = BlocProvider.of<DetailMovieCubit>(context);
  //   // TODO: implement initState
  //   super.initState();
  //   _cubit.init();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: const Color(0xFF0F1B2B),
          backgroundColor: const Color(0xFFFFFFFF),
          centerTitle: true,
          title: const Text(
            'Cast & Crew',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF0F1B2B),
            ),
          ),
        ),
        body: Container(
          color: Colors.blue,
        )
    );
  }
}
