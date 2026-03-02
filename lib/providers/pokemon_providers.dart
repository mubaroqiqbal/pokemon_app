import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokemon_app/models/evolutions/get_pokemon_evolution_chain_responses.dart';
import 'package:pokemon_app/models/moves/get_detail_pokemon_move_responses.dart';
import 'package:pokemon_app/models/pokemon/pokemon_detail_responses.dart';
import 'package:pokemon_app/models/pokemon/pokemon_species_responses.dart';
import 'package:pokemon_app/services/pokemon_service.dart';

final pokemonServiceProvider = Provider<PokemonService>((ref) {
  return PokemonService();
});

typedef DetailPokemonData = ({
  PokemonDetailResponses pokemonData,
  PokemonSpeciesResponses species,
});

final getDetailPokemonProvider = FutureProvider.family
    .autoDispose<DetailPokemonData, String>((ref, name) async {
      try {
        final service = ref.watch(pokemonServiceProvider);

        final pokemon = await service.getDetailPokemon(name);

        final id = pokemon.id;

        final species = await service.getPokemonSpecies(id!.toInt());

        return (pokemonData: pokemon, species: species);
      } catch (e) {
        rethrow;
      }
    });

final getPokemonMoves = FutureProvider.family
    .autoDispose<PokemonDetailResponses, String>((ref, name) async {
      try {
        final service = ref.watch(pokemonServiceProvider);

        final pokemon = await service.getDetailPokemon(name);

        return pokemon;
      } catch (e) {
        rethrow;
      }
    });

final getPokemonEvolutions = FutureProvider.family
    .autoDispose<GetPokemonEvolutionChainResponses, int>((ref, id) async {
      try {
        final service = ref.watch(pokemonServiceProvider);

        final pokemon = await service.getEvolutionChain(id);

        return pokemon;
      } catch (e) {
        rethrow;
      }
    });

final getDetailPokemonMove = FutureProvider.family
    .autoDispose<GetDetailPokemonMoveResponses, String>((ref, name) async {
      try {
        final service = ref.watch(pokemonServiceProvider);

        final pokemon = await service.getDetailPokemonMove(name);

        return pokemon;
      } catch (e) {
        rethrow;
      }
    });
