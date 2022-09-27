import 'package:flutter/material.dart';
import 'package:movies/provider/movies_provider.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class MovieSearch extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      hintColor: Colors.white,
      inputDecorationTheme:
          const InputDecorationTheme(border: InputBorder.none),
      textTheme: const TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = ''; //query es una propiedad que viene de ShowSearch
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context,
              null); //close es un metodo que viene de ShowSearch, cierra y retorna un resultado
        },
        icon: const Icon(Icons.arrow_back_sharp));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Cada que query cambia se manda a llamar BuildSugestion, eso incluye mover el cursor.
    //en el input;
    if (query.isEmpty) {
      return const Center(
        child: Icon(
          Icons.movie_creation_outlined,
          size: 200,
          color: Colors.black54,
        ),
      );
    }
    //
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionsByQuery(query);

    // version con Futures
    //para trabajar futres se usa el future builder
    // el future builder solo se activa cuando hay un cambio de valor en la propiedad future
    // return FutureBuilder(
    //     future: moviesProvider.searchMovies(query),

    //     builder: (context, AsyncSnapshot<List<Movies>> snapshot) {
    //       if (!snapshot.hasData) {
    //         return const Center(
    //           child: Icon(
    //             Icons.movie_creation_outlined,
    //             size: 200,
    //             color: Colors.black54,
    //           ),
    //         );
    //       }
    //       final movies =
    //           snapshot.data; // aqui esta guardado el resultado del future
    //       return ListView.builder(
    //         itemCount: movies!.length,
    //         itemBuilder: (context, index) => _MovieItem(movies[index]),
    //       );
    //     });
    /* Version Streams y con debouncer para evitar que haga la solicitud http con cada cambio
    de letra en el serach bar */
    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Movies>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Icon(
              Icons.movie_creation_outlined,
              size: 200,
              color: Colors.black54,
            ),
          );
        }
        /* fin version debouncer */

        final movies = snapshot.data!;

        return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (_, int index) => _MovieItem(movies[index]));
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movies movie;

  const _MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage(
        placeholder: const AssetImage('assets/no-image.jpg'),
        image: NetworkImage(movie.fullImagePoster),
        width: 50,
        fit: BoxFit.contain,
      ),
      title: Text(
        movie.title,
        style: const TextStyle(color: Colors.black),
      ),
      subtitle: Text(
        movie.originalTitle,
        style: const TextStyle(color: Color.fromARGB(143, 0, 0, 0)),
      ),
      onTap: () {
        Navigator.pushNamed(context, 'detail', arguments: movie);
      },
    );
  }
}
