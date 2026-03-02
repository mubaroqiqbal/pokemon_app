import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokemon_app/providers/pokemon_providers.dart';
import 'package:pokemon_app/shared/enum/pokemon_type.dart';
import 'package:pokemon_app/views/pokemon_detail/pokemon_detail_page.dart';

class PokedexCard extends ConsumerWidget {
  final String name;
  final VoidCallback onTap;

  const PokedexCard({super.key, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemon = ref.watch(getDetailPokemonProvider(name));

    return pokemon.maybeWhen(
      data: (pokemon) {
        final data = pokemon.pokemonData;
        final types = data.types ?? [];
        final dataType = types.firstOrNull;
        final pokemonType = dataType?.type?.pokemonType ?? PokemonType.unknown;
        final imageUrl = data.sprites?.other?.officialartwork?.frontDefault;

        return GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: pokemonType.color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -28,
                  bottom: -28,
                  child: Icon(
                    Icons.catching_pokemon_rounded,
                    size: 148,
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                ),
                if (imageUrl != null)
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: SizedBox(
                      height: 110,
                      width: 110,
                      child: Image.network(imageUrl),
                    ),
                  ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (data.name ?? '-').toUpperCase(),
                        overflow: TextOverflow.clip,
                        maxLines: 2,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (types.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        ...types.map((e) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 4),
                            child: TypeChip(
                              fontSize: 12,
                              label:
                                  e.type?.pokemonType.type ??
                                  PokemonType.unknown.type,
                            ),
                          );
                        }),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      error: (exception, stacktrace) {
        return SizedBox.shrink();
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
