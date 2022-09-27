import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/theme/app_theme.dart';

class CardSwiperScreen extends StatelessWidget {
  final List<Movies> movies;

  const CardSwiperScreen({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // print('Entro swiper');
    if (movies.isEmpty) {
      return Container(
          width: double.infinity,
          height: size.height * .6,
          color: AppTheme.backgroundColor,
          child: const Center(
            child: CircularProgressIndicator(
              color: AppTheme.primaryLight,
            ),
          ));
    }

    //Cuando necesita el contexto lo
    //usamos dentro del builder
    return Container(
      width: double.infinity,
      height: size.height * .6,
      color: AppTheme.backgroundColor,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.8,
        itemHeight: size.height * 0.5,
        itemBuilder: (context, index) {
          final movie = movies[index];

          return GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'detail', arguments: movie),
            child: Hero(
              //hero se utiliza para crear animaciones de imagenes por ejemplo,
              tag: movie
                  .id, //el tag es cualquier cosa, pero debe ser unico, y nunca debe repetirse,
              //se puede usar el id o crear un id, y el otro widget que usara el hero
              //tambien debe tener el mismo tag (dtail)
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  //REcuerda agragar el listado de imagenes a pubspec.yaml
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullImagePoster), fit: BoxFit.fill,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
