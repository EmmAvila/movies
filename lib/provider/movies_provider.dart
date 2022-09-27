import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/helper/debouncer.dart';
import 'package:movies/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org'; // va SOLO, sin https://
  final String _apiKey = '00895efa655ad2c550201d8ad9cc401c';
  final String _language = 'es-ES';
  final String _region = 'MX';

  List<Movies> onDisplayMovies = [];
  List<Movies> popularMovies = [];

  Map<int, List<Cast>> movieCast = {};

  int _page = 0;

  final debouncer = Debouncer(duration: const Duration(milliseconds: 800));

  final StreamController<List<Movies>> _suggestionStreamContoller =
      StreamController.broadcast();
  Stream<List<Movies>> get suggestionStream =>
      _suggestionStreamContoller.stream;

  MoviesProvider() {
    // print('Provider inicializado');
    getOnDisplayMoovies();
    getPopularMovies();
  }

  _getJsonData(String baseUrl, String endPoint,
      [int page = 1, String query = '']) async {
    //optimizando codigo
    var url = Uri.https(_baseUrl, endPoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
      'region': _region,
      'query': query,
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    /* La respuesta llega en json, es necesario convertirlo para poder
    utilizarlo
      */

    return response.body;
  }

  getOnDisplayMoovies() async {
    final data = await _getJsonData(_baseUrl, '/3/movie/now_playing');
    //Aqui utilizamos los metodos de las clases que creamos con el convertidor online
    // final Map<String, dynamic> decodedData = json.decode(response.body);
    // esta linea de abajo es basicamente la misa que la de arriba
    final nowPlayingResponse = NowPlayingResponse.fromJson(data);

    onDisplayMovies = nowPlayingResponse.results;

    /*  notifyListeners le indica al provider que hubo cambios en los datos y 
    procede a redenderizar dichos cambios */
    notifyListeners();
  }

  getPopularMovies() async {
    _page++;
    final data = await _getJsonData(_baseUrl, '/3/movie/popular', _page);
    //Aqui utilizamos los metodos de las clases que creamos con el convertidor online
    // final Map<String, dynamic> decodedData = json.decode(response.body);
    // esta linea de abajo es basicamente la misa que la de arriba
    final popularResponse = PopularResponse.fromJson(data);

    popularMovies = [...popularMovies, ...popularResponse.results];
    /*  notifyListeners le indica al provider que hubo cambios en los datos y 
    procede a redenderizar dichos cambios */
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (movieCast.containsKey(movieId)) return movieCast[movieId]!;
    final data = await _getJsonData(_baseUrl, '/3/movie/$movieId/credits');
    final creditsResponse = CreditResponse.fromJson(data);

    movieCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movies>> searchMovies(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
      'region': _region,
      'query': query,
    });

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  }

  // Future List<Movies> searchMovies(query) async {
  //   final data = await _getJsonData(_baseUrl, '/3/search/movie', query);

  //   final searchResponse = SearchResponse.fromJson(data);

  //   return searchResponse;
  // }

  void getSuggestionsByQuery(String query) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      // print('Tenemos valor a buscar: $value');
      final results = await searchMovies(value);
      _suggestionStreamContoller.add(results);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = query;
    });

    Future.delayed(const Duration(milliseconds: 301))
        .then((_) => timer.cancel());
  }
}
