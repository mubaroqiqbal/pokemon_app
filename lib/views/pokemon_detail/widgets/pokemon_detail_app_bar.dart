part of '../pokemon_detail_page.dart';

class _PokemonDetailAppBar extends StatelessWidget {
  const _PokemonDetailAppBar({
    required this.type,
    required this.onTapFavorite,
    this.isLandscape = false,
  });

  final PokemonType type;
  final VoidCallback onTapFavorite;
  final bool isLandscape;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: isLandscape ? 2 : 2,
          child: Container(
            padding: EdgeInsets.only(left: 16),
            color: type.color,
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        Expanded(
          flex: isLandscape ? 3 : 2,
          child: Container(
            padding: EdgeInsets.only(right: 16),
            color: isLandscape ? Colors.white : type.color,
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: isLandscape ? Colors.grey : Colors.white,
              ),
              onPressed: onTapFavorite,
            ),
          ),
        ),
      ],
    );
  }
}
