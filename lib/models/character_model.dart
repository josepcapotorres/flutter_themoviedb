class Cast {
  List<CharacterModel> characters = [];

  Cast.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) return;

    characters = jsonList.map((e) => CharacterModel.fromJsonMap(e)).toList();
  }
}

class CharacterModel {
  late int castId;
  late String character;
  late String creditId;
  late int gender;
  late int id;
  late String name;
  late int order;
  String? profilePath;

  CharacterModel.fromJsonMap(Map<String, dynamic> json) {
    castId = json["cast_id"];
    character = json["character"];
    creditId = json["credit_id"];
    gender = json["gender"];
    id = json["id"];
    name = json["name"];
    order = json["order"];
    profilePath = json["profile_path"];
  }

  String getPhoto() {
    if (profilePath == null) {
      return "https://www.animeomega.es/foro/styles/canvas/theme/images/no_avatar.jpg";
    } else {
      return "https://image.tmdb.org/t/p/w500/$profilePath";
    }
  }
}
