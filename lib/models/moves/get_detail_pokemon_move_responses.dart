import 'package:pokemon_app/models/general_data_model.dart';
import 'package:pokemon_app/shared/enum/pokemon_type.dart';

class GetDetailPokemonMoveResponses {
  GetDetailPokemonMoveResponses({
    this.id,
    this.name,
    this.accuracy,
    this.power,
    this.pp,
    this.target,
    this.type,
    this.statChanges,
    this.effectEntries,
  });

  GetDetailPokemonMoveResponses.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    accuracy = json['accuracy'];
    power = json['power'];
    pp = json['pp'];
    target = json['target'] != null
        ? GeneralDataModel.fromJson(json['target'])
        : null;
    type = json['type'] != null ? MoveType.fromJson(json['type']) : null;
    statChanges =
        (json['stat_changes'] as List?)
            ?.map((e) => StatChanges.fromJson(e))
            .toList() ??
        [];
    if ((json['effect_entries'] as List?) != null) {
      final data = <EffectEntry>[];

      (json['effect_entries'] as List?)?.forEach((e) {
        final effect = EffectEntry.fromJson(e);

        if (effect.language?.name == 'en') {
          data.add(effect);
        }
      });
      effectEntries = data;
    }
  }
  num? id;
  String? name;
  num? accuracy;
  num? power;
  num? pp;
  GeneralDataModel? target;
  MoveType? type;
  List<StatChanges>? statChanges;
  List<EffectEntry>? effectEntries;
}

class MoveType extends GeneralDataModel {
  MoveType({super.name, super.url, this.pokemonType});

  factory MoveType.fromJson(dynamic json) {
    return MoveType(
      name: json['name'],
      url: json['url'],
      pokemonType: PokemonType.fromJson(json['name']),
    );
  }
  PokemonType? pokemonType;
}

class StatChanges {
  StatChanges({this.change, this.stat});

  factory StatChanges.fromJson(dynamic json) {
    return StatChanges(
      change: json['change'],
      stat: json['stat'] != null
          ? GeneralDataModel.fromJson(json['stat'])
          : null,
    );
  }
  int? change;
  GeneralDataModel? stat;
}

class EffectEntry {
  EffectEntry({this.shortEffect, this.language});

  factory EffectEntry.fromJson(dynamic json) {
    return EffectEntry(
      shortEffect: json['short_effect'],
      language: json['language'] != null
          ? GeneralDataModel.fromJson(json['language'])
          : null,
    );
  }
  String? shortEffect;
  GeneralDataModel? language;
}
