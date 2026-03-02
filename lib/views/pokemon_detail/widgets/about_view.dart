part of '../pokemon_detail_page.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key, required this.pokemon});
  final DetailPokemonData pokemon;

  PokemonDetailResponses get pokemonData => pokemon.pokemonData;
  PokemonSpeciesResponses get species => pokemon.species;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          InfoRow(title: "Species", value: pokemonData.species?.name ?? '-'),
          InfoRow(
            title: "Height",
            value: ('${pokemonData.height?.toString() ?? '0'} ft'),
          ),
          InfoRow(
            title: "Weight",
            value: ('${pokemonData.weight?.toString() ?? '0'} lbs'),
          ),
          InfoRow(
            title: "Abilities",
            value: (pokemonData.abilities?.map((e) => e.ability?.name) ?? [])
                .join(", "),
          ),
          InfoRow(title: "Habitat", value: species.habitat?.name ?? '-'),
          const SizedBox(height: 20),
          const Text("Breeding", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          if (species.isMythical ?? false)
            InfoRow(title: "Mythical Pokemon", value: 'Yes'),
          InfoRow(title: "Color", value: species.color?.name ?? '-'),
          InfoRow(
            title: "Egg Groups",
            value: (species.eggGroups?.map((e) => e.name) ?? []).join(", "),
          ),
          InfoRow(title: "Growth-Rate", value: species.growthRate?.name ?? '-'),
        ],
      ),
    );
  }
}
