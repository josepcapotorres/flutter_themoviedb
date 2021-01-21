class Cast {
  List<CharacterModel> characters = List();

  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((item) {
      final character = CharacterModel.fromJsonMap(item);

      characters.add(character);
    });
  }
}

class CharacterModel {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

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

  getPhoto() {
    if (profilePath == null) {
      return "https://www.animeomega.es/foro/styles/canvas/theme/images/no_avatar.jpg";
    } else {
      return "https://image.tmdb.org/t/p/w500/$profilePath";
    }
  }
}
