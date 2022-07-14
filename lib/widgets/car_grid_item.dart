import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:online_reservation_app/src/store_detail_screen.dart';
import 'package:online_reservation_app/widgets/cache_img_widget.dart';

class CarGridItemView extends StatelessWidget {
  const CarGridItemView({Key? key}) : super(key: key);

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
            Get.toNamed(StoreDetailScreen.routeName);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CacheImgWidget(
                'https://images.unsplash.com/photo-1578916171728-46686eac8d58?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fHN0b3JlfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 6.0,
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Image.asset('assets/images/logo.png', width: 50.0),
                    const SizedBox(width: 10.0),
                    const AutoSizeText(
                      'Title here',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
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
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 22.0,
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
              _extraDetailsView(),
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

  Widget _extraDetailsView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            spacing: 10.0,
            children: [
              Icon(Icons.store, color: Colors.grey.shade700),
              const Text('Open'),
            ],
          ),
          Wrap(
            spacing: 10.0,
            children: [
              Icon(Icons.location_city, color: Colors.grey.shade700),
              const Text('District'),
            ],
          ),
          Wrap(
            spacing: 10.0,
            children: [
              Icon(Icons.route_rounded, color: Colors.grey.shade700),
              const Text('Distance'),
            ],
          ),
        ],
      ),
    );
  }
}
