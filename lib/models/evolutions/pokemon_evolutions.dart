import 'package:pokemon_app/models/general_data_model.dart';

class PokemonEvolutions {
  PokemonEvolutions({
    this.evolutionDetails,
    this.evolvesTo,
    this.isBaby,
    this.species,
  });

  PokemonEvolutions.fromJson(dynamic json) {
    if (json['evolution_details'] != null) {
      evolutionDetails = [];
      json['evolution_details'].forEach((v) {
        evolutionDetails?.add(EvolutionDetails.fromJson(v));
      });
    }
    if (json['evolves_to'] != null) {
      evolvesTo = [];
      json['evolves_to'].forEach((v) {
        evolvesTo?.add(PokemonEvolutions.fromJson(v));
      });
    }
    isBaby = json['is_baby'];
    species = json['species'] != null
        ? GeneralDataModel.fromJson(json['species'])
        : null;
  }
  List<EvolutionDetails>? evolutionDetails;
  List<PokemonEvolutions>? evolvesTo;
  bool? isBaby;
  GeneralDataModel? species;
}

class EvolutionDetails {
  EvolutionDetails({
    this.baseFormId,
    this.gender,
    this.heldItem,
    this.item,
    this.knownMove,
    this.knownMoveType,
    this.location,
    this.minAffection,
    this.minBeauty,
    this.minDamageTaken,
    this.minHappiness,
    this.minLevel,
    this.minMoveCount,
    this.minSteps,
    this.needsMultiplayer,
    this.needsOverworldRain,
    this.partySpecies,
    this.partyType,
    this.regionId,
    this.relativePhysicalStats,
    this.timeOfDay,
    this.tradeSpecies,
    this.trigger,
    this.turnUpsideDown,
    this.usedMove,
  });

  EvolutionDetails.fromJson(dynamic json) {
    baseFormId = json['base_form_id'];
    gender = json['gender'];
    heldItem = json['held_item'];
    item = json['item'] != null
        ? GeneralDataModel.fromJson(json['item'])
        : null;
    knownMove = json['known_move'];
    knownMoveType = json['known_move_type'] != null
        ? GeneralDataModel.fromJson(json['known_move_type'])
        : null;
    location = json['location'] != null
        ? GeneralDataModel.fromJson(json['location'])
        : null;
    minAffection = json['min_affection'];
    minBeauty = json['min_beauty'];
    minDamageTaken = json['min_damage_taken'];
    minHappiness = json['min_happiness'];
    minLevel = json['min_level'];
    minMoveCount = json['min_move_count'];
    minSteps = json['min_steps'];
    needsMultiplayer = json['needs_multiplayer'];
    needsOverworldRain = json['needs_overworld_rain'];
    partySpecies = json['party_species'];
    partyType = json['party_type'];
    regionId = json['region_id'];
    relativePhysicalStats = json['relative_physical_stats'];
    timeOfDay = json['time_of_day'];
    tradeSpecies = json['trade_species'];
    trigger = json['trigger'] != null
        ? GeneralDataModel.fromJson(json['trigger'])
        : null;
    turnUpsideDown = json['turn_upside_down'];
    usedMove = json['used_move'];
  }
  dynamic baseFormId;
  dynamic gender;
  dynamic heldItem;
  GeneralDataModel? item;
  dynamic knownMove;
  GeneralDataModel? knownMoveType;
  GeneralDataModel? location;
  dynamic minAffection;
  dynamic minBeauty;
  dynamic minDamageTaken;
  num? minHappiness;
  num? minLevel;
  dynamic minMoveCount;
  num? minSteps;
  bool? needsMultiplayer;
  bool? needsOverworldRain;
  dynamic partySpecies;
  dynamic partyType;
  dynamic regionId;
  dynamic relativePhysicalStats;
  String? timeOfDay;
  dynamic tradeSpecies;
  GeneralDataModel? trigger;
  bool? turnUpsideDown;
  dynamic usedMove;
}
