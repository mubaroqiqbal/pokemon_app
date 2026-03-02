part of '../pokemon_detail_page.dart';

class EvolutionView extends ConsumerWidget {
  const EvolutionView({super.key, required this.id});
  final int id;

  List<Widget> evolutionChainWidgets(GetPokemonEvolutionChainResponses data) {
    final evolutionWidget = <Widget>[];

    data.chain?.evolvesTo?.forEach((e) {
      evolutionWidget.add(
        _EvolutionChainCard(title: 'First Evolution', order: 2, data: e),
      );

      e.evolvesTo?.forEach((e) {
        evolutionWidget.add(
          _EvolutionChainCard(title: 'Second Evolution', order: 3, data: e),
        );
      });
    });

    return evolutionWidget;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(getPokemonEvolutions(id));

    return data.maybeWhen(
      data: (evolutionChain) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _EvolutionChainCard(
                title: 'Unevolved Form',
                order: 1,
                data: evolutionChain.chain,
              ),
              ...evolutionChainWidgets(evolutionChain),
            ],
          ),
        );
      },
      error: (_, __) {
        return Center(
          child: Text('Something unexpected happened, please try again later'),
        );
      },
      loading: () {
        return Center(child: CircularProgressIndicator());
      },
      orElse: () {
        return SizedBox.shrink();
      },
    );
  }
}

class _EvolutionChainCard extends StatelessWidget {
  const _EvolutionChainCard({
    required this.title,
    required this.data,
    required this.order,
  });

  final String title;
  final PokemonEvolutions? data;
  final int order;

  String get minimumLevel =>
      data?.evolutionDetails?.firstOrNull?.minLevel?.toString() ?? '';

  String get minimumHappiness =>
      data?.evolutionDetails?.firstOrNull?.minHappiness?.toString() ?? '';

  String get item =>
      data?.evolutionDetails?.firstOrNull?.item?.name.toString().replaceAll(
        '-',
        ' ',
      ) ??
      '';

  String get timeOfDay =>
      data?.evolutionDetails?.firstOrNull?.timeOfDay?.toString() ?? '';

  String get location =>
      data?.evolutionDetails?.firstOrNull?.location?.name?.toString() ?? '';

  String get knownMoveType =>
      data?.evolutionDetails?.firstOrNull?.knownMoveType?.name?.toString() ??
      '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          InfoRow(title: "Name", value: data?.species?.name ?? '-'),
          if (order > 1) ...[
            InfoRow(
              title: "Evolution Trigger",
              value:
                  data?.evolutionDetails?.firstOrNull?.trigger?.name
                      ?.replaceAll('-', ' ') ??
                  '-',
            ),
            if (minimumLevel.isNotEmpty)
              InfoRow(title: "Minimum Level", value: minimumLevel),
            if (minimumHappiness.isNotEmpty)
              InfoRow(title: "Minimum Happiness", value: minimumHappiness),
            if (item.isNotEmpty) InfoRow(title: "Item", value: item),
            if (timeOfDay.isNotEmpty)
              InfoRow(title: "Time of Day", value: timeOfDay),
            if (location.isNotEmpty)
              InfoRow(title: "Location", value: location),
            if (knownMoveType.isNotEmpty)
              InfoRow(title: "Known Move Type", value: knownMoveType),
          ],
        ],
      ),
    );
  }
}
