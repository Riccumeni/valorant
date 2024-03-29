import 'package:http/http.dart' as http;

class ValorantAPI {
  Future<String> getMaps() async {
    var maps = await http.get(Uri.parse("https://valorant-api.com/v1/maps"));
    return maps.body.toString();
  }
  Future<String> getChampions() async {
    var raw =
    await http.get(Uri.parse("https://valorant-api.com/v1/agents"));
    return raw.body.toString();
  }

  Future<String> getWeapons() async {
    var raw = await http.get(Uri.parse("https://valorant-api.com/v1/weapons"));
    return raw.body.toString();
  }

  Future<String> getSkins() async {
    var raw =
        await http.get(Uri.parse("https://valorant-api.com/v1/weapons/skins/"));
    return raw.body.toString();
  }
  Future<String> getSkin(String id) async {
    var raw =
    await http.get(Uri.parse("https://valorant-api.com/v1/weapons/skins/$id"));
    return raw.body.toString();
  }
}
