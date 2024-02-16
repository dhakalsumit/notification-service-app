// import 'dart:convert';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:notification_demo/models/product_info_model.dart';

class RetrieveDataFromServer {
  Future<List<ProductInfoModel>?> getServerData() async {
    try {
      double latitude;
      double longitude;
      Position currentPosition = await Geolocator.getCurrentPosition();
      latitude = currentPosition.latitude;
      longitude = currentPosition.longitude;

      final response = await http.get(
        Uri.parse(
          'http://192.168.1.67:8000/offers/by-location/?latitude=$latitude&longitude=$longitude',
        ),
      );
      print(response.body);
      if (response.statusCode != 200) {
        throw Exception("error in getting data from server");
      }
      var body = jsonDecode(response.body);
      List<ProductInfoModel> productInfo = [];
      for (var i = 0; i < body["offers"].length; i++) {
        productInfo.add(ProductInfoModel(
          id: body["offers"][i]["id"],
          productName: body["offers"][i]["offerTitle"],
          productDescription: body["offers"][i]["offerDescription"],
          offerPrice: body["offers"][i]["offerPrice"],
          originalPrice: body["offers"][i]["originalPrice"],
          productImage: body["offers"][i]["productImage"],
          shopName: body["offers"][i]["shopName"],
        ));
      }
      return productInfo;

      // print("body is $body");
      // print("specific data is ${body["offers"][0]["offerTitle"]}");
      // return ReceivedDataModel(
      //     title: "${body["offers"][0]["offerTitle"]}",
      //     body:
      //         "Massive Price Drop on ${body["offers"][0]["offerTitle"]} Hurry Up! now at ${body["offers"][0]["offerPrice"]}",
      //     userId: 1);
    } catch (e) {
      // print("error is $e");
      rethrow;
    }
  }
}

final dataProvider = Provider<RetrieveDataFromServer>((ref) {
  return RetrieveDataFromServer();
});
