import 'package:pokemon_app/models/general_data_model.dart';
import 'package:pokemon_app/models/moves/pokemon_moves.dart';
import 'package:pokemon_app/models/pokemon/pokemon_types.dart';
import 'package:pokemon_app/shared/enum/pokemon_stats_enum.dart';

class PokemonDetailResponses {
  PokemonDetailResponses({
    this.id,
    this.name,
    this.weight,
    this.height,
    this.isDefault,
    this.order,
    this.baseExperience,
    this.locationAreaEncounters,
    this.heldItems,
    this.abilities,
    this.cries,
    this.species,
    this.sprites,
    this.stats,
    this.types,
  });

  PokemonDetailResponses.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    weight = json['weight'];
    height = json['height'];
    isDefault = json['is_default'];
    order = json['order'];
    baseExperience = json['base_experience'];
    locationAreaEncounters = json['location_area_encounters'];
    if (json['held_items'] != null) {
      heldItems = json['held_items'] as List? ?? [];
    }
    if (json['abilities'] != null) {
      abilities = [];
      json['abilities'].forEach((v) {
        abilities?.add(Abilities.fromJson(v));
      });
    }
    cries = json['cries'] != null ? Cries.fromJson(json['cries']) : null;
    species = json['species'] != null
        ? GeneralDataModel.fromJson(json['species'])
        : null;
    sprites = json['sprites'] != null
        ? Sprites.fromJson(json['sprites'])
        : null;
    if (json['stats'] != null) {
      stats = [];
      json['stats'].forEach((v) {
        stats?.add(Stats.fromJson(v));
      });
    }
    if (json['types'] != null) {
      types = [];
      json['types'].forEach((v) {
        types?.add(PokemonTypes.fromJson(v));
      });
    }
    if (json['moves'] != null) {
      moves = [];
      json['moves'].forEach((v) {
        moves?.add(PokemonMoves.fromJson(v));
      });
    }
  }
  num? id;
  String? name;
  num? weight;
  num? height;
  bool? isDefault;
  num? order;
  num? baseExperience;
  String? locationAreaEncounters;
  List<dynamic>? heldItems;
  List<Abilities>? abilities;
  Cries? cries;
  GeneralDataModel? species;
  Sprites? sprites;
  List<Stats>? stats;
  List<PokemonTypes>? types;
  List<PokemonMoves>? moves;

  String get pokemonNumber {
    final number = id?.toString() ?? '???';

    if (number.length == 3) {
      return '#$number';
    } else if (number.length == 2) {
      return '#0$number';
    } else {
      return '#00$number';
    }
  }
}

class Stats {
  Stats({this.baseStat, this.effort, this.stat});

  Stats.fromJson(dynamic json) {
    baseStat = json['base_stat'];
    effort = json['effort'];
    stat = json['stat'] != null ? Stat.fromJson(json['stat']) : null;
  }
  num? baseStat;
  num? effort;
  Stat? stat;
}

class Stat extends GeneralDataModel {
  Stat({super.name, super.url, this.type = PokemonStatsEnum.unknown});

  factory Stat.fromJson(dynamic json) {
    return Stat(
      name: json['name'],
      url: json['url'],
      type: PokemonStatsEnum.fromJson(json['name']),
    );
  }

  final PokemonStatsEnum type;
}

class Sprites {
  Sprites({this.other});

  Sprites.fromJson(dynamic json) {
    other = json['other'] != null ? Other.fromJson(json['other']) : null;
  }
  Other? other;
}

class Other {
  Other({this.officialartwork});

  Other.fromJson(dynamic json) {
    officialartwork = json['official-artwork'] != null
        ? OfficialArtwork.fromJson(json['official-artwork'])
        : null;
  }
  OfficialArtwork? officialartwork;
}

class OfficialArtwork {
  OfficialArtwork({this.frontDefault, this.frontShiny});

  OfficialArtwork.fromJson(dynamic json) {
    frontDefault = json['front_default'];
    frontShiny = json['front_shiny'];
  }
  String? frontDefault;
  String? frontShiny;
}

class Cries {
  Cries({this.latest, this.legacy});

  Cries.fromJson(dynamic json) {
    latest = json['latest'];
    legacy = json['legacy'];
  }
  String? latest;
  String? legacy;
}

class Abilities {
  Abilities({this.ability, this.isHidden, this.slot});

  Abilities.fromJson(dynamic json) {
    ability = json['ability'] != null
        ? GeneralDataModel.fromJson(json['ability'])
        : null;
    isHidden = json['is_hidden'];
    slot = json['slot'];
  }
  GeneralDataModel? ability;
  bool? isHidden;
  num? slot;
}
