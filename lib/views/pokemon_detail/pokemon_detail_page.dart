import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokemon_app/models/evolutions/get_pokemon_evolution_chain_responses.dart';
import 'package:pokemon_app/models/evolutions/pokemon_evolutions.dart';
import 'package:pokemon_app/models/moves/pokemon_moves.dart';
import 'package:pokemon_app/models/pokemon/pokemon_detail_responses.dart';
import 'package:pokemon_app/models/pokemon/pokemon_species_responses.dart';
import 'package:pokemon_app/providers/pokemon_providers.dart';
import 'package:pokemon_app/shared/enum/pokemon_type.dart';
import 'package:pokemon_app/shared/widgets/list_scroll_wrapper.dart';

part 'widgets/info_row.dart';
part 'widgets/type_chip.dart';
part 'widgets/header.dart';
part 'widgets/contents.dart';
part 'widgets/about_view.dart';
part 'widgets/stats_view.dart';
part 'widgets/moves_view.dart';
part 'widgets/evolution_view.dart';
part 'widgets/pokemon_detail_app_bar.dart';

class PokemonDetailPage extends ConsumerStatefulWidget {
  const PokemonDetailPage({super.key, required this.name});

  final String name;

  @override
  ConsumerState<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends ConsumerState<PokemonDetailPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final pokemon = ref.watch(getDetailPokemonProvider(widget.name));

    return pokemon.maybeWhen(
      data: (pokemon) {
        final data = pokemon.pokemonData;
        final pokemonType =
            data.types?.firstOrNull?.type?.pokemonType ?? PokemonType.unknown;

        return Scaffold(
          backgroundColor: Colors.white,
          body: OrientationBuilder(
            builder: (context, orientation) {
              final isLandscape = orientation == Orientation.landscape;

              final appBar = _PokemonDetailAppBar(
                type: pokemonType,
                onTapFavorite: () {},
                isLandscape: isLandscape,
              );

              final header = _Header(pokemon: data, orientation: orientation);

              final contents = _Content(
                pokemon: pokemon,
                orientation: orientation,
              );

              if (isLandscape) {
                return Column(
                  children: [
                    appBar,
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(flex: 2, child: header),
                          Expanded(flex: 3, child: contents),
                        ],
                      ),
                    ),
                  ],
                );
              }

              final type =
                  pokemon.pokemonData.types?.firstOrNull?.type?.pokemonType;

              return SafeArea(
                bottom: false,
                child: Stack(
                  children: [
                    Container(color: type?.color, height: height, width: width),
                    Positioned(
                      bottom: 0,
                      child: SizedBox(
                        height: height * 0.55,
                        width: width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [Expanded(child: contents)],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: SizedBox(
                        height: height * 0.44,
                        width: width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            appBar,
                            Expanded(child: header),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
      error: (exception, stacktrace) {
        return SizedBox.shrink();
      },
      loading: () {
        return CircularProgressIndicator();
      },
      orElse: () {
        return SizedBox.shrink();
      },
    );
  }
}
