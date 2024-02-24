import 'package:http/http.dart' as http;

//TODO : add the required function to check if the ip is correct or not. rest of the functionality has been implemented in the home page on "save button click."
Future<bool> pingIp(String ip) async {
  try {
    // TODO : use ip instead of the hardcoded ip address.
    final response = await http.get(
      Uri.parse("http://192.168.1.67:8000/ping/"),
    );
    //TODO : check the response and return true or false accordingly. if it is true then ip will be stored in local storage. else not.
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } catch (error) {
    return false;
  }
}
