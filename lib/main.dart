import 'package:flutter/material.dart';
import 'package:movies/provider/movies_provider.dart';
import 'package:movies/screens/screens.dart';
import 'package:movies/theme/app_theme.dart';
import 'package:provider/provider.dart';

// void main() => runApp(const MyApp());
void main() => runApp(const DataMovies());
//Data movies debe ser el primer widget en crearse

class DataMovies extends StatelessWidget {
  const DataMovies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MoviesProvider(),
          lazy:
              false, //En true siginifica que el MoviesProvider solo se ejecuta,
          // hasta que un widget lo requiera,
        )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      initialRoute: 'home',
      routes: {
        'home': (context) => const HomeScreen(),
        'detail': (context) => const DetailScreen(),
      },
      theme: AppTheme.lightTheme,
    );
  }
}
