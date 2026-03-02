enum PokemonStatsEnum {
  hp(label: 'HP'),
  speed(label: 'Speed'),
  spAtk(label: 'Sp. Atk'),
  spDef(label: 'Sp. Def'),
  atk(label: 'Attack'),
  def(label: 'Defense'),
  unknown(label: 'Unknown');

  const PokemonStatsEnum({required this.label});

  final String label;

  factory PokemonStatsEnum.fromJson(name) {
    switch (name) {
      case 'hp':
        return PokemonStatsEnum.hp;
      case 'attack':
        return PokemonStatsEnum.atk;
      case 'defense':
        return PokemonStatsEnum.def;
      case 'special-attack':
        return PokemonStatsEnum.spAtk;
      case 'special-defense':
        return PokemonStatsEnum.spDef;
      case 'speed':
        return PokemonStatsEnum.speed;
      default:
        return PokemonStatsEnum.unknown;
    }
  }
}
