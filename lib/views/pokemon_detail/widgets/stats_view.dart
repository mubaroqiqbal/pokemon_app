part of '../pokemon_detail_page.dart';

class StatsView extends StatelessWidget {
  const StatsView({super.key, required this.pokemon});
  final PokemonDetailResponses pokemon;

  int highestValueStat() {
    final data = (pokemon.stats ?? []);

    data.sort((a, b) {
      return (b.baseStat ?? 0).compareTo(a.baseStat ?? 0);
    });

    return data.first.baseStat?.toInt() ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: (pokemon.stats ?? []).map((e) {
            final value = e.baseStat ?? 0;

            double progressBarColor() {
              final data = (pokemon.stats ?? []);

              data.sort((a, b) {
                return (b.baseStat ?? 0).compareTo(a.baseStat ?? 0);
              });

              final highestValueStat = data.first.baseStat?.toInt() ?? 0;
              if (highestValueStat >= 200) {
                return value / 250;
              } else if (highestValueStat >= 150) {
                return value / 200;
              } else if (highestValueStat >= 100) {
                return value / 150;
              } else if (highestValueStat >= 50) {
                return value / 100;
              }

              return value / 100;
            }

            return Container(
              margin: EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      e.stat?.type.label ?? '',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      e.baseStat?.toString() ?? '',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: LinearProgressIndicator(
                      value: progressBarColor(),
                      color: progressBarColor() <= 0.55
                          ? Colors.red
                          : Colors.green,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
