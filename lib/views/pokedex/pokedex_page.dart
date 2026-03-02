import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokemon_app/models/general_data_model.dart';
import 'package:pokemon_app/providers/pokedex/pokedex_notifier.dart';
import 'package:pokemon_app/providers/pokedex/pokedex_state.dart';
import 'package:pokemon_app/shared/enum/list_view_type.dart';
import 'package:pokemon_app/shared/widgets/list_scroll_wrapper.dart';
import 'package:pokemon_app/views/pokedex/widgets/pokedex_card.dart';
import 'package:pokemon_app/views/pokemon_detail/pokemon_detail_page.dart';

part './widgets/pokedex_contents.dart';

class PokedexPage extends ConsumerStatefulWidget {
  const PokedexPage({super.key});

  @override
  ConsumerState<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends ConsumerState<PokedexPage> {
  var _viewType = ListViewType.grid;

  @override
  Widget build(BuildContext context) {
    final pokedexState = ref.watch(pokedexProvider);
    final pokedexNotifier = ref.read(pokedexProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      body: OrientationBuilder(
        builder: (context, orientation) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: switch (pokedexState) {
                PokedexLoading() => Center(child: CircularProgressIndicator()),
                PokedexLoaded() => _PokedexContents(
                  data: pokedexState.data,
                  hasMorePage: pokedexState.hasMorePage,
                  loadMore: pokedexNotifier.loadMore,
                  viewType: _viewType,
                  orientation: orientation,
                  onTapViewType: () {
                    setState(() {
                      if (_viewType == ListViewType.list) {
                        _viewType = ListViewType.grid;
                      } else {
                        _viewType = ListViewType.list;
                      }
                    });
                  },
                ),
                PokedexError() => Center(child: Text(pokedexState.message)),
                PokedexState() => SizedBox.shrink(),
              },
            ),
          );
        },
      ),
    );
  }
}
