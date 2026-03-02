part of '../pokemon_detail_page.dart';

class _Header extends StatelessWidget {
  final PokemonDetailResponses pokemon;
  final Orientation orientation;

  const _Header({required this.pokemon, required this.orientation});

  bool get isLandscape => orientation == Orientation.landscape;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final imageUrl =
        pokemon.sprites?.other?.officialartwork?.frontDefault ?? '';
    final pokemonType =
        pokemon.types?.firstOrNull?.type?.pokemonType ?? PokemonType.unknown;

    double imageHeight() {
      if (isLandscape) {
        return width * 0.25;
      }
      return width * 0.5;
    }

    return Container(
      color: isLandscape ? pokemonType.color : Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            right: -32,
            bottom: -32,
            child: Icon(
              Icons.catching_pokemon_rounded,
              size: isLandscape ? width * 0.35 : width * 0.75,
              color: Colors.white.withValues(alpha: 0.2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (pokemon.name ?? '').toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: (pokemon.types ?? [])
                                .map(
                                  (type) => TypeChip(
                                    color: type.type?.pokemonType.color,
                                    label: type.type?.pokemonType.type ?? '-',
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        pokemon.pokemonNumber,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                if (imageUrl.isNotEmpty) ...[
                  if (isLandscape)
                    const SizedBox(height: 16)
                  else
                    Expanded(child: SizedBox.shrink()),
                  Image.network(
                    imageUrl,
                    height: imageHeight(),
                    fit: BoxFit.contain,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
