import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:online_reservation_app/src/search/views/search_screen.dart';
import 'package:online_reservation_app/widgets/car_grid_item.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logo.png', height: 32),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black87),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: () => Get.toNamed(SearchScreen.routeName),
              child: Icon(Icons.search, color: Colors.grey.shade700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(Icons.map, color: Colors.grey.shade700),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(10.0),
        itemCount: 6,
        separatorBuilder: (context, _) => const SizedBox(height: 10.0),
        itemBuilder: (context, i) {
          return const CarGridItemView();
        },
      ),
    );
  }
}
