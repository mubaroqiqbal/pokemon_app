import 'dart:ui';

enum PokemonType {
  electric(type: 'electric', color: Color(0xffe5c531)),
  fire(type: 'fire', color: Color(0xffea7a3c)),
  water(type: 'water', color: Color(0xff539ae2)),
  grass(type: 'grass', color: Color(0xff71c558)),
  normal(type: 'normal', color: Color(0xffaab09f)),
  fighting(type: 'fighting', color: Color(0xffcb5f48)),
  flying(type: 'flying', color: Color(0xff7da6de)),
  poison(type: 'poison', color: Color(0xffb468b7)),
  ground(type: 'ground', color: Color(0xffcc9f4f)),
  rock(type: 'rock', color: Color(0xffb2a061)),
  bug(type: 'bug', color: Color(0xff94bc4a)),
  ghost(type: 'ghost', color: Color(0xff846ab6)),
  steel(type: 'steel', color: Color(0xff89a1b0)),
  psychic(type: 'psychic', color: Color(0xffe5709b)),
  ice(type: 'ice', color: Color(0xff70cbd4)),
  dragon(type: 'dragon', color: Color(0xff6a7baf)),
  dark(type: 'dark', color: Color(0xff736c75)),
  fairy(type: 'fairy', color: Color(0xffe397d1)),
  stellar(type: 'stellar', color: Color(0xff81a596)),
  unknown(type: 'unknown', color: Color(0xff81a596));

  const PokemonType({required this.type, required this.color});

  final String type;
  final Color color;

  factory PokemonType.fromJson(name) {
    switch (name) {
      case 'electric':
        return PokemonType.electric;
      case 'fire':
        return PokemonType.fire;
      case 'water':
        return PokemonType.water;
      case 'grass':
        return PokemonType.grass;
      case 'bug':
        return PokemonType.bug;
      case 'dark':
        return PokemonType.dark;
      case 'dragon':
        return PokemonType.dragon;
      case 'ice':
        return PokemonType.ice;
      case 'fairy':
        return PokemonType.fairy;
      case 'fighting':
        return PokemonType.fighting;
      case 'normal':
        return PokemonType.normal;
      case 'flying':
        return PokemonType.flying;
      case 'ghost':
        return PokemonType.ghost;
      case 'ground':
        return PokemonType.ground;
      case 'rock':
        return PokemonType.rock;
      case 'steel':
        return PokemonType.steel;
      case 'stellar':
        return PokemonType.stellar;
      case 'poison':
        return PokemonType.poison;
      case 'psychic':
        return PokemonType.psychic;
      case 'unknown':
        return PokemonType.unknown;
      default:
        return PokemonType.unknown;
    }
  }
}
