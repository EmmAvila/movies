import 'package:flutter/material.dart';
import 'package:movies/models/models.dart';
import 'package:movies/theme/app_theme.dart';

class MovieSliderScreen extends StatefulWidget {
  final List<Movies>
      movies; // cuando venga por argumentos, no debe inicializarse
  final String? title;
  final Function nextPage;

  const MovieSliderScreen(
      {Key? key, required this.movies, this.title, required this.nextPage})
      : super(key: key);

  @override
  State<MovieSliderScreen> createState() => _MovieSliderScreenState();
}

class _MovieSliderScreenState extends State<MovieSliderScreen> {
  final scrollController = ScrollController();
  @override
  void initState() {
    //ejecuta codigo la primera vez que se contruye el widget

    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels + 500 >=
          scrollController.position.maxScrollExtent) {
        //en statefull se requiere poner widget.(porpiedad) para poder
        //accedera a dicha propiedad;
        // widget.nextPage();
      }
    });
  }

  @override
  void dispose() {
    //ejecuta codigo al ser destruido el widget

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print('Entro slider');

    if (widget.movies.isEmpty) {
      return Expanded(
        child: Container(
            width: double.infinity,
            height: 6,
            color: AppTheme.backgroundColor,
            child: const Center(
              child: CircularProgressIndicator(
                color: AppTheme.primaryLight,
              ),
            )),
      );
    }

    return Expanded(
      child: Container(
        width: double.infinity,
        color: AppTheme.backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.title != null)
              Padding(
                padding:
                    const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 0),
                child: Text(
                  '${widget.title}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            /* Lisview Builder tiene scroll  y esta dentro de una columna que no tiene
            una altura finita, entonces tendriamos que encerrar a listview builder en un widget
            de altura finita como expanded para que tome lo que resta de la pantalla */
            Expanded(
              // expanded se expande dependiendo de la direccion del Axis de su hijo
              child: ListView.builder(
                controller: scrollController, //viene de una propiedad creada
                scrollDirection: Axis.horizontal,
                itemCount: widget.movies.length,
                itemBuilder: (context, index) =>
                    _MoviesPoster(movie: widget.movies[index]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _MoviesPoster extends StatelessWidget {
  /* asi separamos el widget de cada pelicula y lo hacemos privado con _
  para que solo se pueda usar dentro de este archivo */
  final Movies movie;
  const _MoviesPoster({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: 150,
        // color: Colors.red,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, 'detail', arguments: movie),
                child: FadeInImage(
                  //REcuerda agragar el listado de imagenes a pubspec.yaml
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullImagePoster),
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ));
  }
}
