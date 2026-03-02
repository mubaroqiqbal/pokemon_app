import 'package:dio/dio.dart';
import 'package:pokemon_app/models/pokemon/get_pokedex_responses.dart';
import 'package:pokemon_app/models/pokemon/pokemon_detail_responses.dart';
import 'package:pokemon_app/models/pokemon/pokemon_species_responses.dart';

import '../models/evolutions/get_pokemon_evolution_chain_responses.dart';
import '../models/moves/get_detail_pokemon_move_responses.dart';

class PokemonService {
  final _limit = 10;

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://pokeapi.co/api/v2/',
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
    ),
  );

  Future<GetPokedexResponses?> getPokedex(int page) async {
    final path = 'pokemon';
    final offset = (page * _limit) - 10;

    final json = await _dio.get(
      path,
      queryParameters: {'limit': _limit, 'offset': offset},
    );

    final data = json.data as Map<String, dynamic>? ?? {};

    if (data.isNotEmpty) {
      final responses = GetPokedexResponses.fromJson(data);

      return responses;
    }

    return null;
  }

  Future<PokemonDetailResponses> getDetailPokemon(String name) async {
    final path = 'pokemon/$name';

    final responses = await _dio.get(path);

    final data = responses.data as Map<String, dynamic>? ?? {};

    if (data.isNotEmpty) {
      final responses = PokemonDetailResponses.fromJson(data);

      return responses;
    }

    throw Exception('Something unexpected happened, please try again later');
  }

  Future<GetPokemonEvolutionChainResponses> getEvolutionChain(int id) async {
    final path = 'evolution-chain/$id';

    final responses = await _dio.get(path);

    final data = responses.data as Map<String, dynamic>? ?? {};

    if (data.isNotEmpty) {
      final responses = GetPokemonEvolutionChainResponses.fromJson(data);

      return responses;
    }

    throw Exception('Something unexpected happened, please try again later');
  }

  Future<PokemonSpeciesResponses> getPokemonSpecies(int id) async {
    final path = 'pokemon-species/$id';

    final responses = await _dio.get(path);

    final data = responses.data as Map<String, dynamic>? ?? {};

    if (data.isNotEmpty) {
      final responses = PokemonSpeciesResponses.fromJson(data);

      return responses;
    }

    throw Exception('Something unexpected happened, please try again later');
  }

  Future<GetDetailPokemonMoveResponses> getDetailPokemonMove(
    String name,
  ) async {
    final path = 'move/$name';

    final responses = await _dio.get(path);

    final data = responses.data as Map<String, dynamic>? ?? {};

    if (data.isNotEmpty) {
      final responses = GetDetailPokemonMoveResponses.fromJson(data);

      return responses;
    }

    throw Exception('Something unexpected happened, please try again later');
  }
}
