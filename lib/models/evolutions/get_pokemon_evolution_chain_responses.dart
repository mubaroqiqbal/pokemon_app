import 'package:pokemon_app/models/evolutions/pokemon_evolutions.dart';

class GetPokemonEvolutionChainResponses {
  GetPokemonEvolutionChainResponses({this.chain, this.id});

  final PokemonEvolutions? chain;
  final int? id;

  factory GetPokemonEvolutionChainResponses.fromJson(
    Map<String, dynamic> json,
  ) {
    return GetPokemonEvolutionChainResponses(
      id: json['id'],
      chain: json['chain'] != null
          ? PokemonEvolutions.fromJson(json['chain'])
          : null,
    );
  }
}
