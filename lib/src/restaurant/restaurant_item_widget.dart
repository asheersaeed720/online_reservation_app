import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:online_reservation_app/src/restaurant/restaurant.dart';
import 'package:online_reservation_app/src/restaurant/views/restaurant_detail_screen.dart';
import 'package:online_reservation_app/widgets/cache_img_widget.dart';

class RetaurantItemWidget extends StatelessWidget {
  const RetaurantItemWidget(this.restaurantId, this.restaurantItem, {Key? key}) : super(key: key);

  final String restaurantId;
  final RestaurantModel restaurantItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: InkWell(
          onTap: () {
            Get.toNamed(
              RestaurantDetailScreen.routeName,
              arguments: {
                'restaurantId': restaurantId,
                'restaurantItem': restaurantItem,
              },
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CacheImgWidget(
                restaurantItem.imageUrls.first,
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 4.0,
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    AutoSizeText(
                      restaurantItem.restaurantName.capitalizeFirst ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          'View Details',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        const SizedBox(width: 6.0),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18.0,
                          color: Colors.grey.shade700,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              _buildRatingView(),
              const SizedBox(height: 10.0),
              _buildExtraDetailsView(),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRatingView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: RatingBar.builder(
        initialRating: 4.0,
        itemSize: 18.0,
        minRating: 1,
        direction: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          log('$rating');
        },
      ),
    );
  }

  Widget _buildExtraDetailsView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            spacing: 10.0,
            children: [
              Icon(Icons.location_on, color: Colors.grey.shade700),
              Text(restaurantItem.address),
            ],
          ),
          Wrap(
            spacing: 10.0,
            children: [
              Icon(Icons.access_time, color: Colors.grey.shade700),
              Text(restaurantItem.workingHours),
            ],
          ),
        ],
      ),
    );
  }
}
