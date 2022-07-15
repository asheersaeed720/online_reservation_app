import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:online_reservation_app/utils/constants.dart';
import 'package:online_reservation_app/widgets/cache_img_widget.dart';
import 'package:online_reservation_app/widgets/custom_async_btn.dart';
import 'package:timeago/timeago.dart' as timeago;

class StoreDetailScreen extends StatefulWidget {
  static const String routeName = '/detail';

  const StoreDetailScreen({Key? key}) : super(key: key);

  @override
  State<StoreDetailScreen> createState() => _StoreDetailScreenState();
}

class _StoreDetailScreenState extends State<StoreDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: ListView(
        children: [
          buildSliderView(),
          const SizedBox(height: 12.0),
          _buildDescriptionView(),
          const SizedBox(height: 18.0),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomAsyncBtn(
          btnTxt: 'Book Now',
          onPress: () {},
        ),
      ),
    );
  }

  Widget buildSliderView() {
    return CacheImgWidget(
      'https://images.unsplash.com/photo-1578916171728-46686eac8d58?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fHN0b3JlfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 4.0,
      borderRadius: 0.0,
    );
  }

  Widget _buildDescriptionView() {
    final postedDate = timeago.format(DateTime.now());

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Title Here',
            style: kBodyStyle.copyWith(fontSize: 18.0),
          ),
          const SizedBox(height: 6.0),
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
              const Text('(3)')
            ],
          ),
          const SizedBox(height: 10.0),
          Image.asset('assets/images/divider.jpg', width: 100.0),
          const SizedBox(height: 10.0),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.map),
            title: Text(
              'Location',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
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
            trailing: Wrap(
              spacing: 12.0,
              children: const [
                Text('00:00'),
                Icon(Icons.arrow_forward_ios_rounded),
              ],
            ),
          ),
          const Divider(thickness: 1.0),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.work),
            title: Text(
              'Minimum Order',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Wrap(
              spacing: 12.0,
              children: const [
                Text('00:00 SAR'),
                Icon(Icons.arrow_forward_ios_rounded),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
