import 'package:pokemon_app/models/general_data_model.dart';

class GetPokedexResponses {
  GetPokedexResponses({
    this.count,
    this.next,
    this.previous,
    this.results = const [],
  });

  factory GetPokedexResponses.fromJson(Map<String, dynamic> json) {
    return GetPokedexResponses(
      count: json['total_images'],
      next: json['next'],
      previous: json['previous'],
      results: ((json['results'] as List?) ?? [])
          .map((e) => GeneralDataModel.fromJson(e))
          .toList(),
    );
  }

  num? count;
  String? next;
  String? previous;
  List<GeneralDataModel> results;
}
