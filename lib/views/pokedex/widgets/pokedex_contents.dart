part of '../pokedex_page.dart';

class _PokedexContents extends StatelessWidget {
  const _PokedexContents({
    required this.data,
    required this.loadMore,
    required this.onTapViewType,
    required this.hasMorePage,
    this.orientation = Orientation.portrait,
    this.viewType = ListViewType.grid,
  });

  final List<GeneralDataModel> data;
  final Future<void> Function() loadMore;
  final VoidCallback onTapViewType;
  final bool hasMorePage;
  final Orientation orientation;
  final ListViewType viewType;

  @override
  Widget build(BuildContext context) {
    Widget pokedexCard(GeneralDataModel pokemon) {
      final pokemonName = pokemon.name ?? '';

      return Container(
        margin: EdgeInsets.only(bottom: 16),
        child: PokedexCard(
          name: pokemonName,
          viewType: viewType,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PokemonDetailPage(name: pokemonName),
              ),
            );
          },
        ),
      );
    }

    return ListScrollWrapper(
      isScrollMore: hasMorePage,
      onScrollCallback: loadMore,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Pokedex',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                onPressed: onTapViewType,
                icon: Icon(Icons.list, size: 24),
              ),
            ],
          ),
          SizedBox(height: 16),
          if (viewType == ListViewType.grid)
            GridView.builder(
              itemCount: data.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              itemBuilder: (context, index) {
                final pokemon = data[index];

                return pokedexCard(pokemon);
              },
            )
          else
            ListView.builder(
              itemCount: data.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,

              itemBuilder: (context, index) {
                final pokemon = data[index];
                return pokedexCard(pokemon);
              },
            ),
        ],
      ),
    );
  }
}
