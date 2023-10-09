class ChampionsResponse {
  int? status;
  List<Champion>? data;

  ChampionsResponse({required this.status, required this.data});

  factory ChampionsResponse.fromJson(Map<String, dynamic> json) {
    final status = json['status'];
    final data = <Champion>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data!.add(Champion.fromJson(v));
      });
    }
    return ChampionsResponse(status: status, data: data);
  }
}

class Champion {
  String? uuid;
  String? displayName;
  String background;
  String? displayIcon;
  String description;
  String? fullPortrait;
  String? bustPortrait;
  List<String>? backgroundGradientColors;
  bool? isPlayableCharacter;
  Role? role;
  List<Abilities>? abilities;

  Champion(
      {this.uuid,
        this.displayName,
        this.displayIcon,
        required this.background,
        this.fullPortrait,
        required this.description,
        this.bustPortrait,
        this.backgroundGradientColors,
        this.isPlayableCharacter,
        this.role,
        this.abilities,});

  factory Champion.fromJson(Map<String, dynamic> json) {
    final uuid = json['uuid'];
    final background = json["background"];
    final displayName = json['displayName'];
    final displayIcon = json['displayIcon'];
    final description = json['description'];
    final fullPortrait = json['fullPortrait'];
    final bustPortrait = json['bustPortrait'];
    final backgroundGradientColors = json['backgroundGradientColors'].cast<String>();
    final isPlayableCharacter = json['isPlayableCharacter'];
    var role;
    if(json['role'] != null){
      role = Role.fromJson(json['role']);
    }
    var abilities;
    if (json['abilities'] != null) {
      abilities = <Abilities>[];
      json['abilities'].forEach((v) {
        abilities!.add(new Abilities.fromJson(v));
      });
    }

    return Champion(
        uuid: uuid,
        displayName: displayName,
        displayIcon: displayIcon,
        description: description,
        background: background,
        bustPortrait: bustPortrait,
        fullPortrait: fullPortrait,
        backgroundGradientColors: backgroundGradientColors,
        isPlayableCharacter: isPlayableCharacter,
        role: role,
        abilities: abilities
    );
  }
}

class Role {
  String? uuid;
  String displayName;
  String displayIcon;
  String description;

  Role(
      {this.uuid,
        required this.displayName,
        required this.displayIcon, required this.description});

  factory Role.fromJson(Map<String, dynamic> json) {
    final uuid = json['uuid'];
    final displayName = json['displayName'];
    final displayIcon = json['displayIcon'];
    final description = json['description'];

    return Role(uuid: uuid, displayIcon: displayIcon, displayName: displayName, description: description);
  }

}

class Abilities {
  String slot;
  String displayName;
  String description;
  String? displayIcon;

  Abilities({required this.slot, required this.displayName, required this.description, this.displayIcon});

  factory Abilities.fromJson(Map<String, dynamic> json) {
    final slot = json['slot'];
    final displayName = json['displayName'];
    final description = json['description'];
    final displayIcon = json['displayIcon'];

    return Abilities(slot: slot, displayName: displayName, displayIcon: displayIcon, description: description);
  }
}
