import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:notification_demo/models/data_model.dart';

class RetrieveDataFromServer {
  Future<ReceivedDataModel?> getServerData() async {
    try {
      double latitude;
      double longitude;
      Position currentPosition = await Geolocator.getCurrentPosition();
      latitude = currentPosition.latitude;
      longitude = currentPosition.longitude;
      print('latitude: $latitude longitude $longitude');

      // final response = await http
      //     .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      // print(response.body);

      // var data = response.body;
      // print("data ko suru is ${data[0]}");

      // List<dynamic> decodedData = json.decode(data);
      // print("decoded data is ${decodedData[0]}");
      return ReceivedDataModel(
          title: "you are in location $latitude and $longitude",
          body: "This is body received from api ",
          userId: 1);
    } catch (e) {
      print("error is $e");
      rethrow;
    }
  }
}
