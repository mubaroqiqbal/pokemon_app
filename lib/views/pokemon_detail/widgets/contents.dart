part of '../pokemon_detail_page.dart';

class _Content extends ConsumerStatefulWidget {
  final DetailPokemonData pokemon;
  final Orientation orientation;

  const _Content({required this.pokemon, required this.orientation});

  @override
  ConsumerState<_Content> createState() => __ContentState();
}

class __ContentState extends ConsumerState<_Content>
    with SingleTickerProviderStateMixin {
  late final controller = TabController(length: 4, vsync: this);

  int get evolutionChainId {
    final url = widget.pokemon.species.evolutionChain?.url ?? '';

    final uri = Uri.parse(url);
    return int.parse(uri.pathSegments[uri.pathSegments.length - 2]);
  }

  Widget tab({required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Text(title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabBar(
            controller: controller,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: [
              tab(title: 'About', onTap: () => controller.animateTo(0)),
              tab(title: 'Base Stats', onTap: () => controller.animateTo(1)),
              tab(title: 'Evolution', onTap: () => controller.animateTo(2)),
              tab(title: 'Moves', onTap: () => controller.animateTo(3)),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: controller,
              children: [
                AboutView(pokemon: widget.pokemon),
                StatsView(pokemon: widget.pokemon.pokemonData),
                EvolutionView(id: evolutionChainId),
                MovesView(pokemon: widget.pokemon.pokemonData),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
