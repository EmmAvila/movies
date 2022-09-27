// To parse this JSON data, do
//
//     final popularResponse = popularResponseFromMap(jsonString);

import 'dart:convert';
import 'package:movies/models/models.dart';

class PopularResponse {
  PopularResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;
  final List<Movies> results;
  final int totalPages;
  final int totalResults;

  factory PopularResponse.fromJson(String str) =>
      PopularResponse.fromMap(json.decode(str));

  factory PopularResponse.fromMap(Map<String, dynamic> json) => PopularResponse(
        page: json["page"],
        results:
            List<Movies>.from(json["results"].map((x) => Movies.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
