import 'package:do_an_movie/blocs/home_bloc/home_cubit.dart';
import 'package:do_an_movie/networks/api_client.dart';
import 'package:do_an_movie/networks/api_util.dart';
import 'package:do_an_movie/ui/home/home.dart';
import 'package:do_an_movie/ui/main/main_ui.dart';
import 'package:do_an_movie/ui/user/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'repositories/movie_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ApiClient _apiClient;

  @override
  void initState() {
    _apiClient = ApiUtil.instance.apiClient;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<MovieRepository>(
          create: (context) {
            return MovieRepositoryImpl(_apiClient);
          },
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HomeCubit>(
            create: (context) {
              final repository = RepositoryProvider.of<MovieRepository>(context);
              return HomeCubit(repository);
            },
          )
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Movie',
          home: MainUi(),
        ),
      ),
    );
  }
}
