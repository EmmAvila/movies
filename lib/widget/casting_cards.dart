import 'package:flutter/cupertino.dart';

import 'package:movies/provider/movies_provider.dart';
import 'package:provider/provider.dart';

import '../models/credits_response.dart';

class CastingCardScreen extends StatelessWidget {
  final int movieId;
  const CastingCardScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
        future: moviesProvider.getMovieCast(movieId),
        builder: (context, AsyncSnapshot<List<Cast>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              constraints: const BoxConstraints(maxWidth: 150),
              height: 180,
              child: const CupertinoActivityIndicator(),
            );
          }
          final List<Cast> cast = snapshot.data!;

          return Container(
              height: 190,
              margin: const EdgeInsets.only(bottom: 20),
              // color: Colors.black12,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return _CastCard(actor: cast[index]);
                },
                itemCount: cast.length,
                scrollDirection: Axis.horizontal,
              ));
        });
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;
  const _CastCard({
    Key? key,
    required this.actor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: 110,
      height: 180,
      // color: Colors.red,
      child: Column(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: FadeInImage(
            //REcuerda agragar el listado de imagenes a pubspec.yaml
            placeholder: const AssetImage('assets/no-image.jpg'),
            image: NetworkImage(actor.fullProfilePath),

            height: 140,
            width: 100,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          '${actor.name} ${actor.character}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }
}
