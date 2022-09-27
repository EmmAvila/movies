import 'package:flutter/material.dart';
import 'package:movies/provider/movies_provider.dart';
import 'package:movies/search/search_delegate.dart';
import 'package:movies/theme/app_theme.dart';
import 'package:movies/widget/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    // print('home / moviesProvider: ${moviesProvider.onDisplayMovies}');
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 100,
        centerTitle: true,
        title: const Text(
          'What 2c',
          style: TextStyle(color: AppTheme.primaryLightText),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () =>
                //showSearch es una funcion que arroja un widget precreado y ahorra mucho trabajo
                showSearch(context: context, delegate: MovieSearch()),
          )
        ],
      ),
      body: Column(
        children: [
          CardSwiperScreen(movies: moviesProvider.onDisplayMovies),
          // Container(
          //   height: 1,
          //   color: Color.fromARGB(96, 40, 56, 233),
          // ),
          MovieSliderScreen(
            title: null,
            movies: moviesProvider.popularMovies,
            nextPage: () => moviesProvider.getPopularMovies(),
          )
        ],
      ),
    );
  }
}
