import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notification_demo/dummy/dummy_data.dart';
import 'package:notification_demo/pages/error/error_screen.dart';
import 'package:notification_demo/pages/notification/my_notification_page.dart';
import 'package:notification_demo/services/provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late final TextEditingController _controller;
  final box = Hive.box("ipBox");
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  openSettings() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.white,
            insetPadding: const EdgeInsets.symmetric(horizontal: 8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: SizedBox(
                width: double.maxFinite,
                height: 240,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Enter your IP address to connect ",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        labelText: "Enter IP to connect",
                        helperText: "IP is valid",
                        hintText: "https://example.com",
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple[400],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              )),
                          onPressed: () async {
                            await Hive.box("ipBox").put("ip", _controller.text);
                            print(Hive.box("ipBox").get("ip"));

                            ref
                                .read(ipNameProvider.notifier)
                                .update((state) => _controller.text);
                            if (!mounted) {
                              return;
                            }
                            Navigator.pop(context);
                          },
                          child: const Text("Save",
                              style: TextStyle(color: Colors.white))),
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                        onPressed: () {
                          print(Hive.box("ipBox").get("ip"));
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final name = ref.watch(ipNameProvider);
    final listOfProduct = ref.watch(productListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Geo Field Notification"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => MyNotificationPage(
                    productInfoModel: dummyModel[0],
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.settings,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            FittedBox(
              child: Row(
                children: [
                  Text(
                    name == null
                        ? "Currently You are not connected to any IP"
                        : "connected at : ",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.grey[700]),
                  ),
                  Text(
                    name ?? "",
                    style: const TextStyle(color: Colors.green),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  MaterialButton(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: Colors.purple,
                    onPressed: openSettings,
                    child: Text(
                      name == null ? "Add IP" : "change IP",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: listOfProduct.when(
                data: (data) {
                  return ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 12,
                    ),
                    itemCount: data?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, bottom: 8.0, left: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    child: Text(
                                      "${data?[index].productName}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "Original Price: \$ ${data?[index].originalPrice}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    "Discount price: \$ ${data?[index].offerPrice}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    color: Colors.deepPurple,
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => MyNotificationPage(
                                            productInfoModel: dummyModel[0],
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "More Details ",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: SizedBox(
                                height: 120,
                                width: 150,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    "http://192.168.1.67:8000${data?[index].productImage}",
                                    // "http://192.168.1.67:8000/media/productImages/Apple-MacBook-Air-M1-13-1.png",
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                                height: 120,
                                                width: 150,
                                                color: Colors.grey[400],
                                                child: const Icon(Icons.error)),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stack) => const Center(child: ErrorScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final ipNameProvider = StateProvider<String?>((ref) {
  return Hive.box("ipBox").get("ip");
});
