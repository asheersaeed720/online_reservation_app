import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:online_reservation_app/src/restaurant/restaurant.dart';
import 'package:online_reservation_app/src/restaurant/restaurant_controller.dart';
import 'package:online_reservation_app/src/restaurant/restaurant_item_widget.dart';
import 'package:online_reservation_app/utils/constants.dart';
import 'package:online_reservation_app/widgets/loading_widget.dart';

class RestaurantScreen extends StatelessWidget {
  static const String routeName = '/restaurant';

  RestaurantScreen({Key? key}) : super(key: key);

  final _restaurantCtrl = Get.put(RestaurantController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<RestaurantModel>>(
      stream: _restaurantCtrl.getRestaurants(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<QueryDocumentSnapshot<RestaurantModel>> restaurantsList =
              snapshot.data!.docs as List<QueryDocumentSnapshot<RestaurantModel>>;
          return Scaffold(
            appBar: AppBar(
              title: Text('Restaurants ( ${restaurantsList.length} )'),
              iconTheme: const IconThemeData(color: Colors.black87),
            ),
            body: restaurantsList.isEmpty
                ? Center(
                    child: Text('No Restaurants added yet!', style: kTitleStyle),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: restaurantsList.length,
                    separatorBuilder: (context, _) => const SizedBox(height: 10.0),
                    itemBuilder: (context, i) {
                      return RetaurantItemWidget(restaurantsList[i].id, restaurantsList[i].data());
                    },
                  ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                "${snapshot.error}",
              ),
            ),
          );
        }
        return const Scaffold(body: LoadingWidget());
      },
    );
  }
}
