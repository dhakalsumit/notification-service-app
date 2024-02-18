import 'package:http/http.dart' as http;

//TODO : add the required function to check if the ip is correct or not. rest of the functionality has been implemented in the home page on "save button click."
Future<bool> pingIp(String ip) async {
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
