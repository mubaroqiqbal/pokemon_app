import 'package:pokemon_app/models/general_data_model.dart';

class PokemonSpeciesResponses {
  PokemonSpeciesResponses({
    this.color,
    this.eggGroups,
    this.evolutionChain,
    this.growthRate,
    this.habitat,
    this.id,
    this.name,
    this.order,
    this.isMythical,
  });

  PokemonSpeciesResponses.fromJson(dynamic json) {
    color = json['color'] != null
        ? GeneralDataModel.fromJson(json['color'])
        : null;
    if (json['egg_groups'] != null) {
      eggGroups = [];
      json['egg_groups'].forEach((v) {
        eggGroups?.add(GeneralDataModel.fromJson(v));
      });
    }
    evolutionChain = json['evolution_chain'] != null
        ? EvolutionChain.fromJson(json['evolution_chain'])
        : null;
    growthRate = json['growth_rate'] != null
        ? GeneralDataModel.fromJson(json['growth_rate'])
        : null;
    habitat = json['habitat'] != null
        ? GeneralDataModel.fromJson(json['habitat'])
        : null;
    id = json['id'];
    name = json['name'];
    order = json['order'];
    isMythical = json['is_mythical'];
  }
  GeneralDataModel? color;
  List<GeneralDataModel>? eggGroups;
  EvolutionChain? evolutionChain;
  GeneralDataModel? growthRate;
  GeneralDataModel? habitat;
  num? id;
  String? name;
  bool? isMythical;
  num? order;
}

class EvolutionChain {
  EvolutionChain({this.url});

  EvolutionChain.fromJson(dynamic json) {
    url = json['url'];
  }
  String? url;
}
