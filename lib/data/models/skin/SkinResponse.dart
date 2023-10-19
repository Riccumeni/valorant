class SkinResponse {
  int? status;
  List<Skin>? data;

  SkinResponse({this.status, this.data});

  SkinResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Skin>[];
      json['data'].forEach((v) {
        data!.add(new Skin.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Skin {
  String uuid;
  String? displayName;
  String? themeUuid;
  String? contentTierUuid;
  String? displayIcon;
  String? wallpaper;
  String? assetPath;
  List<Chromas>? chromas;
  List<Levels>? levels;

  Skin(
      { required this.uuid,
        this.displayName,
        this.themeUuid,
        this.contentTierUuid,
        this.displayIcon,
        this.wallpaper,
        this.assetPath,
        this.chromas,
        this.levels});

  factory Skin.fromJson(Map<String, dynamic> json) {
    final uuid = json['uuid'];
    final displayName = json['displayName'];
    final themeUuid = json['themeUuid'];
    final contentTierUuid = json['contentTierUuid'];
    final displayIcon = json['displayIcon'];
    final wallpaper = json['wallpaper'];
    final assetPath = json['assetPath'];
    var chromas;
    if (json['chromas'] != null) {
      chromas = <Chromas>[];
      json['chromas'].forEach((v) {
        chromas!.add(new Chromas.fromJson(v));
      });
    }
    var levels;
    if (json['levels'] != null) {
      levels = <Levels>[];
      json['levels'].forEach((v) {
        levels!.add(new Levels.fromJson(v));
      });
    }
    return Skin(uuid: uuid, displayName: displayName, displayIcon: displayIcon, themeUuid: themeUuid, contentTierUuid: contentTierUuid, wallpaper: wallpaper, assetPath: assetPath, chromas: chromas, levels: levels);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['displayName'] = this.displayName;
    data['themeUuid'] = this.themeUuid;
    data['contentTierUuid'] = this.contentTierUuid;
    data['displayIcon'] = this.displayIcon;
    data['wallpaper'] = this.wallpaper;
    data['assetPath'] = this.assetPath;
    if (this.chromas != null) {
      data['chromas'] = this.chromas!.map((v) => v.toJson()).toList();
    }
    if (this.levels != null) {
      data['levels'] = this.levels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chromas {
  String? uuid;
  String? displayName;
  String? displayIcon;
  String? fullRender;
  String? swatch;
  String? streamedVideo;
  String? assetPath;

  Chromas(
      {this.uuid,
        this.displayName,
        this.displayIcon,
        this.fullRender,
        this.swatch,
        this.streamedVideo,
        this.assetPath});

  Chromas.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    displayName = json['displayName'];
    displayIcon = json['displayIcon'];
    fullRender = json['fullRender'];
    swatch = json['swatch'];
    streamedVideo = json['streamedVideo'];
    assetPath = json['assetPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['displayName'] = this.displayName;
    data['displayIcon'] = this.displayIcon;
    data['fullRender'] = this.fullRender;
    data['swatch'] = this.swatch;
    data['streamedVideo'] = this.streamedVideo;
    data['assetPath'] = this.assetPath;
    return data;
  }
}

class Levels {
  String? uuid;
  String? displayName;
  String? levelItem;
  String? displayIcon;
  String? streamedVideo;
  String? assetPath;

  Levels(
      {this.uuid,
        this.displayName,
        this.levelItem,
        this.displayIcon,
        this.streamedVideo,
        this.assetPath});

  Levels.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    displayName = json['displayName'];
    levelItem = json['levelItem'];
    displayIcon = json['displayIcon'];
    streamedVideo = json['streamedVideo'];
    assetPath = json['assetPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['displayName'] = this.displayName;
    data['levelItem'] = this.levelItem;
    data['displayIcon'] = this.displayIcon;
    data['streamedVideo'] = this.streamedVideo;
    data['assetPath'] = this.assetPath;
    return data;
  }
}
