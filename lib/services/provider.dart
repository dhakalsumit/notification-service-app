import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notification_demo/models/product_info_model.dart';
import 'package:notification_demo/services/retrive_data.services.dart';

final productListProvider = FutureProvider<List<ProductInfoModel>?>((ref) {
  return ref.watch(dataProvider).getServerData();
});
