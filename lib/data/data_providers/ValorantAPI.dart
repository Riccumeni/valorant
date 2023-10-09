import 'package:http/http.dart' as http;

class ValorantAPI{
  Future<String> getChampions() async{
    var raw = await http.get(Uri.parse("https://valorant-api.com/v1/agents"));
    return raw.body.toString();
  }
}