import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:notification_demo/models/product_info_model.dart';
import 'package:notification_demo/pages/home/home_page.dart';

class MyNotificationPage extends StatelessWidget {
  final ReceivedAction? receivedAction;
  final ProductInfoModel? productInfoModel;
  const MyNotificationPage(
      {super.key, this.receivedAction, this.productInfoModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Product Details'),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: double.maxFinite,
                      child: Image.network(
                        productInfoModel == null
                            ? "${receivedAction?.payload?["productImage"]}"
                            : productInfoModel!.productImage!,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.network(
                          "https://via.placeholder.com/150",
                          fit: BoxFit.cover,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              productInfoModel == null
                                  ? "${receivedAction?.summary}"
                                  : productInfoModel!.shopName!,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            productInfoModel == null
                                ? "${receivedAction?.title}"
                                : productInfoModel!.productName!,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            productInfoModel == null
                                ? "${receivedAction?.body}"
                                : productInfoModel!.productDescription!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.grey[700]),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Text(
                                "Offer Price:",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              const Spacer(),
                              Text(
                                productInfoModel == null
                                    ? "${receivedAction?.payload?["offerPrice"]}"
                                    : productInfoModel!.offerPrice!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Text(
                                "Original Price:",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              const Spacer(),
                              Text(
                                productInfoModel == null
                                    ? "${receivedAction?.payload?["originalPrice"]}"
                                    : productInfoModel!.originalPrice!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.grey[300]!, blurRadius: 1, spreadRadius: 1)
                ]),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    MaterialButton(
                        minWidth: (MediaQuery.of(context).size.width - 64) / 2,
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                              (route) => false);
                        },
                        color: Colors.red,
                        textColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: const Text("Cancel")),
                    const Spacer(),
                    MaterialButton(
                        minWidth: (MediaQuery.of(context).size.width - 64) / 2,
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                              (route) => false);
                        },
                        color: Colors.deepPurple,
                        textColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: const Text("Goto Home")),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
