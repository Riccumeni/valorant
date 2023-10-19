import 'package:http/http.dart' as http;

class ValorantAPI{
  Future<String> getChampions() async{
    var raw = await http.get(Uri.parse("https://valorant-api.com/v1/agents"));
    print(raw);
    return raw.body.toString();
  }
  Future<String> getMaps() async{
    var maps = await http.get(Uri.parse("https://valorant-api.com/v1/maps"));
    print(maps);
    return maps.body.toString();

  }
  Future<String> getWeapons() async{
    var weapons = await http.get(Uri.parse("https://valorant-api.com/v1/weapons"));
    return weapons.body.toString();
  }
}