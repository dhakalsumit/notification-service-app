import 'package:http/http.dart' as http;

Future<bool> pingIp() async {
  try {
    final response = await http.post(Uri.parse(""), body: {});

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } catch (error) {
    return false;
  }
}
