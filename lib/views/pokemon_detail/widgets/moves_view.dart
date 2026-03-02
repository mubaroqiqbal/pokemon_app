part of '../pokemon_detail_page.dart';

class MovesView extends ConsumerStatefulWidget {
  const MovesView({super.key, required this.pokemon});
  final PokemonDetailResponses pokemon;

  @override
  ConsumerState<MovesView> createState() => _MovesViewState();
}

class _MovesViewState extends ConsumerState<MovesView> {
  final _limit = 5;
  var _currentPage = 1;

  List<PokemonMoves> get _pokemonMoves => widget.pokemon.moves ?? [];

  bool get _hasMorePage => (_currentPage * _limit) < _pokemonMoves.length;

  List<PokemonMoves> get _currentPageData =>
      _pokemonMoves.getRange(0, _currentPage * _limit).toList();

  @override
  Widget build(BuildContext context) {
    return ListScrollWrapper(
      isScrollMore: _hasMorePage,
      onScrollCallback: () async => setState(() {
        _currentPage++;
      }),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _currentPageData.map((e) {
          return _PokemonMoveCard(name: e.move!.name!);
        }).toList(),
      ),
    );
  }
}

class _PokemonMoveCard extends ConsumerWidget {
  const _PokemonMoveCard({required this.name});

  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(getDetailPokemonMove(name));

    return data.maybeWhen(
      data: (moveData) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      (moveData.name ?? '-').toUpperCase(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TypeChip(
                    color: moveData.type?.pokemonType?.color,
                    label: (moveData.type?.pokemonType?.type ?? '-')
                        .toUpperCase(),
                  ),
                ],
              ),
              InfoRow(title: "Power", value: moveData.power?.toString() ?? '-'),
              InfoRow(
                title: "Accuracy",
                value: moveData.accuracy?.toString() ?? '-',
              ),
              InfoRow(title: "PP", value: moveData.pp?.toString() ?? '-'),
              InfoRow(
                title: "Target",
                value:
                    (moveData.target?.name?.toString().replaceAll('-', ' ')) ??
                    '-',
              ),
              if ((moveData.statChanges ?? []).isNotEmpty)
                InfoRow(
                  title: "Stats Effect",
                  value: moveData.statChanges!
                      .map((e) {
                        return '${e.change} ${e.stat?.name ?? ''}';
                      })
                      .join(", "),
                ),
              if ((moveData.effectEntries ?? []).isNotEmpty)
                InfoRow(
                  title: "Move Effects",
                  value:
                      moveData.effectEntries?.firstOrNull?.shortEffect ?? '-',
                ),
            ],
          ),
        );
      },
      error: (e, s) {
        return Center(
          child: Text('Something unexpected happened, please try again later'),
        );
      },
      loading: () {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Center(child: CircularProgressIndicator()),
        );
      },
      orElse: () {
        return SizedBox.shrink();
      },
    );
  }
}
