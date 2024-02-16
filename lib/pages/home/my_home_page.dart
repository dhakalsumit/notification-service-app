// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notification_demo/services/provider.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listOfProduct = ref.watch(productListProvider);
    return Scaffold(
      body: listOfProduct.when(
        data: (data) {
          return ListView.builder(
            itemCount: data?.length??0,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(data?[index].productName ?? ''),
                subtitle: Text(data?[index].shopName ?? ''),
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}
