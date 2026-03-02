import 'package:pokemon_app/models/general_data_model.dart';

class PokemonMoves {
  PokemonMoves({this.move});

  PokemonMoves.fromJson(dynamic json) {
    move = json['move'] != null
        ? GeneralDataModel.fromJson(json['move'])
        : null;
    if (json['version_group_details'] != null) {
      versionGroupDetails = [];
      json['version_group_details'].forEach((v) {
        versionGroupDetails?.add(VersionGroupDetails.fromJson(v));
      });
    }
  }
  GeneralDataModel? move;
  List<VersionGroupDetails>? versionGroupDetails;
}

class VersionGroupDetails {
  VersionGroupDetails({this.levelLearnedAt, this.moveLearnMethod, this.order});

  VersionGroupDetails.fromJson(dynamic json) {
    levelLearnedAt = json['level_learned_at'];
    moveLearnMethod = json['move_learn_method'] != null
        ? GeneralDataModel.fromJson(json['move_learn_method'])
        : null;
    order = json['order'];
  }
  num? levelLearnedAt;
  GeneralDataModel? moveLearnMethod;
  int? order;
}
