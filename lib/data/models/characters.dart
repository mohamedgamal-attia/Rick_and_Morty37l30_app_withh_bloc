class Character {
  late int charId;
  late String name;
  late String image;
  late String gender;
  late String species;
  late String statusIfDeadOrAlive;

  Character.fromJson(Map<String, dynamic> json) {
    charId = json["id"];
    name = json["name"];
    image = json["image"];
    statusIfDeadOrAlive = json["status"];
    gender = json["gender"];
    species = json["species"];
  }
}
