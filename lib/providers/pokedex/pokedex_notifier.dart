import 'package:hooks_riverpod/legacy.dart';
import 'package:pokemon_app/providers/pokedex/pokedex_state.dart';
import 'package:pokemon_app/providers/pokemon_providers.dart';
import 'package:pokemon_app/services/pokemon_service.dart';

final pokedexProvider =
    StateNotifierProvider.autoDispose<PokedexNotifier, PokedexState>((ref) {
      final service = ref.watch(pokemonServiceProvider);
      return PokedexNotifier(pokemonService: service);
    });

class PokedexNotifier extends StateNotifier<PokedexState> {
  PokedexNotifier({required this.pokemonService}) : super(PokedexLoading()) {
    loadInitial();
  }

  final PokemonService pokemonService;

  Future<void> loadInitial() async {
    try {
      state = PokedexLoading();

      final pokedex = await pokemonService.getPokedex(1);

      if (pokedex != null) {
        if (pokedex.results.isEmpty) {
          state = PokedexEmpty();
          return;
        }

        state = PokedexLoaded(
          page: 1,
          data: pokedex.results,
          hasMorePage: pokedex.next != null,
        );

        return;
      }
      _setStateAsError();
    } catch (e) {
      _setStateAsError();
    }
  }

  Future<void> loadMore() async {
    if (state is! PokedexLoaded) return;

    try {
      final currentState = state as PokedexLoaded;

      final pokedex = await pokemonService.getPokedex(currentState.page + 1);

      if (pokedex != null) {
        state = PokedexLoaded(
          page: currentState.page + 1,
          data: [...currentState.data, ...pokedex.results],
          hasMorePage: pokedex.next != null,
        );

        return;
      }
      _setStateAsError();
    } catch (e) {
      _setStateAsError();
    }
  }

  void _setStateAsError() {
    state = PokedexError(
      'Something unexpected happened, please try again later',
    );
  }
}
