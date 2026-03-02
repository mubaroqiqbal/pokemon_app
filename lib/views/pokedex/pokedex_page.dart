import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokemon_app/providers/pokedex/pokedex_notifier.dart';
import 'package:pokemon_app/providers/pokedex/pokedex_state.dart';
import 'package:pokemon_app/shared/widgets/list_scroll_wrapper.dart';
import 'package:pokemon_app/views/pokedex/pokedex_card.dart';
import 'package:pokemon_app/views/pokemon_detail/pokemon_detail_page.dart';

class PokedexPage extends ConsumerStatefulWidget {
  const PokedexPage({super.key});

  @override
  ConsumerState<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends ConsumerState<PokedexPage> {
  @override
  Widget build(BuildContext context) {
    final pokedexState = ref.watch(pokedexProvider);
    final pokedexNotifier = ref.read(pokedexProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        title: const Text("Pokedex"),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: switch (pokedexState) {
              PokedexLoading() => Center(child: CircularProgressIndicator()),
              PokedexLoaded() => ListScrollWrapper(
                isScrollMore: pokedexState.hasMorePage,
                onScrollCallback: pokedexNotifier.loadMore,
                child: GridView.builder(
                  itemCount: pokedexState.data.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (context, index) {
                    final pokemon = pokedexState.data[index];
                    final pokemonName = pokemon.name ?? '';

                    return PokedexCard(
                      name: pokemonName,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                PokemonDetailPage(name: pokemonName),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              PokedexState() => SizedBox.shrink(),
            },
          );
        },
      ),
    );
  }
}
