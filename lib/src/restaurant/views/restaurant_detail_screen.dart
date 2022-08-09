import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:online_reservation_app/src/menu_screen/views/menu_screen.dart';
import 'package:online_reservation_app/src/restaurant/restaurant.dart';
import 'package:online_reservation_app/utils/constants.dart';
import 'package:online_reservation_app/widgets/cache_img_widget.dart';
import 'package:online_reservation_app/widgets/custom_async_btn.dart';
import 'package:timeago/timeago.dart' as timeago;

class RestaurantDetailScreen extends StatelessWidget {
  static const String routeName = '/restaurant-detail';

  const RestaurantDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;

    final restaurantId = args['restaurantId'];
    final restaurantItem = args['restaurantItem'];

    return Scaffold(
      appBar: AppBar(
        title: Text(restaurantItem.restaurantName),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: ListView(
        children: [
          buildImageView(context, restaurantItem),
          const SizedBox(height: 12.0),
          _buildContentView(restaurantId, restaurantItem),
          const SizedBox(height: 18.0),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomAsyncBtn(
          btnTxt: 'Revervation',
          onPress: () {
            Get.toNamed(
              MenuScreen.routeName,
              arguments: {
                'restaurantId': restaurantId,
              },
            );
          },
        ),
      ),
    );
  }

  Widget buildImageView(BuildContext context, RestaurantModel restaurantItem) {
    return CacheImgWidget(
      restaurantItem.imageUrls.first,
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 4.0,
      borderRadius: 0.0,
    );
  }

  Widget _buildContentView(String restaurantId, RestaurantModel restaurantItem) {
    final postedDate = timeago.format(restaurantItem.createdAt.toDate());

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            restaurantItem.restaurantName,
            style: kBodyStyle.copyWith(fontSize: 18.0),
          ),
          Text(postedDate),
          const SizedBox(height: 10.0),
          Row(
            children: [
              RatingBar.builder(
                initialRating: 4.0,
                itemSize: 18.0,
                minRating: 1,
                direction: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
              ),
              const SizedBox(width: 8.0),
              const Text('(4)')
            ],
          ),
          const SizedBox(height: 10.0),
          Image.asset('assets/images/divider.jpg', width: 100.0),
          ListTile(
            onTap: () {
              Get.toNamed(
                MenuScreen.routeName,
                arguments: {
                  'restaurantId': restaurantId,
                  'restaurantItem': restaurantItem,
                },
              );
            },
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.restaurant_menu),
            title: Text(
              'Menus',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward),
          ),
          const Divider(thickness: 1.0),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.location_on),
            title: Text(
              restaurantItem.address,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
            // trailing: Text(restaurantItem.address),
          ),
          const Divider(thickness: 1.0),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.work),
            title: Text(
              'Working hours',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Text(restaurantItem.workingHours),
          ),
        ],
      ),
    );
  }
}
