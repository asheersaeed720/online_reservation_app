import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:online_reservation_app/widgets/cache_img_widget.dart';

class UserReservationScreen extends StatelessWidget {
  static const String routeName = '/user-reservations';

  const UserReservationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('reservation'.tr),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(10.0),
        itemCount: 2,
        separatorBuilder: (context, _) => const SizedBox(height: 10.0),
        itemBuilder: (context, i) {
          return _buildReservationItemView(context);
        },
      ),
    );
  }

  Widget _buildReservationItemView(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: InkWell(
          onTap: () {},
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text('Reservation Timing: 10:00'),
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
