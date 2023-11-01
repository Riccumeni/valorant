class MapsResponse {
  int? status;
  List<Maps>? data;

  MapsResponse({required this.status, required this.data});

  factory MapsResponse.fromJson(Map<String, dynamic> json) {
    final status = json['status'];
    final data = <Maps>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(Maps.fromJson(v));
      });
    }
    return MapsResponse(status: status, data: data);
  }
}


class Maps {
  final String uuid;
  final String displayName;
  final String narrativeDescription;
  final String tacticalDescription;
  final String coordinates;
  final String displayIcon;
  final String listViewIcon;
  final String splash;
  final String assetPath;
  final String mapUrl;


  Maps({
    required this.uuid,
    required this.displayName,
    required this.narrativeDescription,
    required this.tacticalDescription,
    required this.coordinates,
    required this.displayIcon,
    required this.listViewIcon,
    required this.splash,
    required this.assetPath,
    required this.mapUrl,
});

  factory Maps.fromJson(Map<String, dynamic> json) {
  final uuid = json['uuid'];
  final displayName = json['displayName'];
  final narrativeDescription = json['narrativeDescription'] ?? "";
  final tacticalDescription = json['tacticalDescription'] ?? "";
  final coordinates = json['coordinates'] ?? "unknown";
  final displayIcon = json['displayIcon'] ?? "";
  final listViewIcon = json['listViewIcon'];
  final splash = json['splash'];
  final assetPath = json['assetPath'];
  final mapUrl = json['mapUrl'];

  return Maps(
    uuid: uuid,
    displayName: displayName,
    narrativeDescription: narrativeDescription,
    tacticalDescription: tacticalDescription,
    coordinates: coordinates,
    displayIcon: displayIcon,
    listViewIcon: listViewIcon,
    splash: splash,
    assetPath: assetPath,
    mapUrl: mapUrl,
  );
  }
}


