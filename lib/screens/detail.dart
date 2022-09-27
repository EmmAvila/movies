import 'package:flutter/material.dart';
import 'package:movies/models/models.dart';
import 'package:movies/theme/app_theme.dart';
import 'package:movies/widget/widgets.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movies movie = ModalRoute.of(context)?.settings.arguments as Movies;

    return Scaffold(
      body: CustomScrollView(slivers: [
        /* solo se aceptan slivers dentro de un custom.. */
        _CustomAppBar(
          movie: movie,
        ),
        /* para poder usar widgets 'normales' dentro de un sliver es necesario un sliver especial
        el sliver list, que es sliver que acepta una lista de widgets */
        SliverList(
            delegate: SliverChildListDelegate([
          _PosterScreen(
            movie: movie,
          ),
          _OverView(overview: movie.overview),
          CastingCardScreen(movieId: movie.id)
        ]))
      ]),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movies movie;
  const _CustomAppBar({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppTheme.primaryLight,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          color: const Color.fromARGB(41, 0, 0, 0),
          alignment:
              Alignment.bottomCenter, // Aligment usa geaometry aligmen y esto
          //ayuda a que el hijo envualva al padre
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              movie.title,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        background: FadeInImage(
          //REcuerda agragar el listado de imagenes a pubspec.yaml
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullBackdropPath),
          width: double.infinity,
          height: 150,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterScreen extends StatelessWidget {
  final Movies movie;
  const _PosterScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: movie.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                //REcuerda agragar el listado de imagenes a pubspec.yaml
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullImagePoster),

                height: 150,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            //usar expanded para no sobrepasar los limites
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                Text(
                  movie.originalTitle,
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Color.fromRGBO(255, 193, 7, 1),
                      size: 25,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      '${movie.voteAverage}',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget {
  final String overview;
  const _OverView({Key? key, required this.overview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Text(
        overview.isEmpty ? 'Reseña no disponible' : overview,
        textAlign: TextAlign.justify,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}
