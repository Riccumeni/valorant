class WeaponsResponse {
  int? status;
  List<Weapon>? data;

  WeaponsResponse({this.status, this.data});

  WeaponsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Weapon>[];
      json['data'].forEach((v) {
        data!.add(new Weapon.fromJson(v));
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

class Weapon {
  String? uuid;
  String displayName;
  String? category;
  String? defaultSkinUuid;
  String displayIcon;
  String? killStreamIcon;
  String? assetPath;
  WeaponStats? weaponStats;
  ShopData? shopData;
  List<Skins>? skins;

  Weapon(
      {this.uuid,
        required this.displayName,
        this.category,
        this.defaultSkinUuid,
        required this.displayIcon,
        this.weaponStats,
        this.shopData,
        required this.skins});

  factory Weapon.fromJson(Map<String, dynamic> json) {
    final uuid = json['uuid'];
    final displayName = json['displayName'];
    final category = json['category'];
    final defaultSkinUuid = json['defaultSkinUuid'];
    final displayIcon = json['displayIcon'];
    final weaponStats = json['weaponStats'] != null
        ? new WeaponStats.fromJson(json['weaponStats'])
        : null;
    final shopData = json['shopData'] != null
        ? new ShopData.fromJson(json['shopData'])
        : null;
    var skins;
    if (json['skins'] != null) {
      skins = <Skins>[];
      json['skins'].forEach((v) {
        skins!.add(new Skins.fromJson(v));
      });
    }
    return Weapon(uuid: uuid, displayName: displayName, category: category, defaultSkinUuid: defaultSkinUuid, displayIcon: displayIcon, weaponStats: weaponStats, shopData: shopData, skins: skins);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['displayName'] = this.displayName;
    data['category'] = this.category;
    data['defaultSkinUuid'] = this.defaultSkinUuid;
    data['displayIcon'] = this.displayIcon;
    data['killStreamIcon'] = this.killStreamIcon;
    data['assetPath'] = this.assetPath;
    if (this.weaponStats != null) {
      data['weaponStats'] = this.weaponStats!.toJson();
    }
    if (this.shopData != null) {
      data['shopData'] = this.shopData!.toJson();
    }
    if (this.skins != null) {
      data['skins'] = this.skins!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WeaponStats {
  dynamic? fireRate;
  int? magazineSize;
  double? runSpeedMultiplier;
  dynamic? equipTimeSeconds;
  dynamic? reloadTimeSeconds;
  dynamic? firstBulletAccuracy;
  int? shotgunPelletCount;
  String? wallPenetration;
  String? feature;
  String? fireMode;
  String? altFireType;
  AdsStats? adsStats;
  List<DamageRanges>? damageRanges;

  WeaponStats(
      {this.fireRate,
        this.magazineSize,
        this.runSpeedMultiplier,
        this.equipTimeSeconds,
        this.reloadTimeSeconds,
        this.firstBulletAccuracy,
        this.shotgunPelletCount,
        this.wallPenetration,
        this.feature,
        this.fireMode,
        this.altFireType,
        this.adsStats,
        this.damageRanges});

  WeaponStats.fromJson(Map<String, dynamic> json) {
    fireRate = json['fireRate'];
    magazineSize = json['magazineSize'];
    runSpeedMultiplier = json['runSpeedMultiplier'];
    equipTimeSeconds = json['equipTimeSeconds'];
    reloadTimeSeconds = json['reloadTimeSeconds'];
    firstBulletAccuracy = json['firstBulletAccuracy'];
    shotgunPelletCount = json['shotgunPelletCount'];
    wallPenetration = json['wallPenetration'];
    feature = json['feature'];
    fireMode = json['fireMode'];
    altFireType = json['altFireType'];
    adsStats = json['adsStats'] != null
        ? new AdsStats.fromJson(json['adsStats'])
        : null;
    if (json['damageRanges'] != null) {
      damageRanges = <DamageRanges>[];
      json['damageRanges'].forEach((v) {
        damageRanges!.add(new DamageRanges.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fireRate'] = this.fireRate;
    data['magazineSize'] = this.magazineSize;
    data['runSpeedMultiplier'] = this.runSpeedMultiplier;
    data['equipTimeSeconds'] = this.equipTimeSeconds;
    data['reloadTimeSeconds'] = this.reloadTimeSeconds;
    data['firstBulletAccuracy'] = this.firstBulletAccuracy;
    data['shotgunPelletCount'] = this.shotgunPelletCount;
    data['wallPenetration'] = this.wallPenetration;
    data['feature'] = this.feature;
    data['fireMode'] = this.fireMode;
    data['altFireType'] = this.altFireType;
    if (this.adsStats != null) {
      data['adsStats'] = this.adsStats!.toJson();
    }
    if (this.damageRanges != null) {
      data['damageRanges'] = this.damageRanges!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdsStats {
  double? zoomMultiplier;
  dynamic? fireRate;
  double? runSpeedMultiplier;
  int? burstCount;
  dynamic? firstBulletAccuracy;

  AdsStats(
      {this.zoomMultiplier,
        this.fireRate,
        this.runSpeedMultiplier,
        this.burstCount,
        this.firstBulletAccuracy});

  AdsStats.fromJson(Map<String, dynamic> json) {
    zoomMultiplier = json['zoomMultiplier'];
    fireRate = json['fireRate'];
    runSpeedMultiplier = json['runSpeedMultiplier'];
    burstCount = json['burstCount'];
    firstBulletAccuracy = json['firstBulletAccuracy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['zoomMultiplier'] = this.zoomMultiplier;
    data['fireRate'] = this.fireRate;
    data['runSpeedMultiplier'] = this.runSpeedMultiplier;
    data['burstCount'] = this.burstCount;
    data['firstBulletAccuracy'] = this.firstBulletAccuracy;
    return data;
  }
}

class DamageRanges {
  int? rangeStartMeters;
  int? rangeEndMeters;
  dynamic? headDamage;
  dynamic? bodyDamage;
  dynamic? legDamage;

  DamageRanges(
      {this.rangeStartMeters,
        this.rangeEndMeters,
        this.headDamage,
        this.bodyDamage,
        this.legDamage});

  DamageRanges.fromJson(Map<String, dynamic> json) {
    rangeStartMeters = json['rangeStartMeters'];
    rangeEndMeters = json['rangeEndMeters'];
    headDamage = json['headDamage'];
    bodyDamage = json['bodyDamage'];
    legDamage = json['legDamage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rangeStartMeters'] = this.rangeStartMeters;
    data['rangeEndMeters'] = this.rangeEndMeters;
    data['headDamage'] = this.headDamage;
    data['bodyDamage'] = this.bodyDamage;
    data['legDamage'] = this.legDamage;
    return data;
  }
}

class ShopData {
  int? cost;
  String? category;

  ShopData(
      {this.cost,
        this.category,});

  ShopData.fromJson(Map<String, dynamic> json) {
    cost = json['cost'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cost'] = this.cost;
    data['category'] = this.category;
    return data;
  }
}


class Skins {
  String? uuid;
  String? displayName;
  String? themeUuid;
  String? contentTierUuid;
  String? displayIcon;
  String? wallpaper;
  String? assetPath;
  bool isFavourite = false;


  Skins(
      {this.uuid,
        this.displayName,
        this.themeUuid,
        this.contentTierUuid,
        this.displayIcon,
        this.wallpaper,
        this.assetPath,
});

  Skins.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    displayName = json['displayName'];
    themeUuid = json['themeUuid'];
    contentTierUuid = json['contentTierUuid'];
    displayIcon = json['displayIcon'];
    wallpaper = json['wallpaper'];
    assetPath = json['assetPath'];
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
    return data;
  }
}
