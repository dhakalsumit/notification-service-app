import 'package:http/http.dart' as http;

//TODO : add the required function to check if the ip is correct or not. rest of the functionality has been implemented in the home page on "save button click."
Future<bool> pingIp(String ip) async {
  print("ip submitted is $ip");
  try {
    // http://192.168.1.67
    final response = await http.get(
      Uri.parse("http://192.168.1.67/ping/"),
    );
    print("response is ${response.body}");
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } catch (error) {
    print(error);
    return false;
  }
}
