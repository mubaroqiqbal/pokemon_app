import 'package:pokemon_app/models/general_data_model.dart';
import 'package:pokemon_app/shared/enum/pokemon_type.dart';

class PokemonTypes {
  PokemonTypes({this.slot, this.type});

  PokemonTypes.fromJson(dynamic json) {
    slot = json['slot'];
    type = json['type'] != null ? PokemonTypeData.fromJson(json['type']) : null;
  }
  num? slot;
  PokemonTypeData? type;
}

class PokemonTypeData extends GeneralDataModel {
  PokemonTypeData({
    super.name,
    super.url,
    this.pokemonType = PokemonType.unknown,
  });

  factory PokemonTypeData.fromJson(dynamic json) {
    return PokemonTypeData(
      name: json['name'],
      url: json['url'],
      pokemonType: PokemonType.fromJson(json['name']),
    );
  }

  final PokemonType pokemonType;
}
