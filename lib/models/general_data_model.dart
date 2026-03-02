class GeneralDataModel {
  GeneralDataModel({this.name, this.url});

  GeneralDataModel.fromJson(dynamic json) {
    name = json['name'];
    url = json['url'];
  }
  String? name;
  String? url;
}
