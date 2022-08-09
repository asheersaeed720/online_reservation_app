import 'package:flutter/material.dart';
import 'package:online_reservation_app/src/menu_screen/menu.dart';
import 'package:online_reservation_app/utils/constants.dart';
import 'package:online_reservation_app/widgets/cache_img_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class MenuItemWidget extends StatelessWidget {
  const MenuItemWidget(this.menuId, this.menuItem, {Key? key}) : super(key: key);

  final String menuId;
  final MenuModel menuItem;

  @override
  Widget build(BuildContext context) {
    final postedDate = timeago.format(menuItem.createdAt.toDate());

    return Card(
      margin: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageView(context),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Price \$${menuItem.price}", style: kTitleStyle),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 4,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.add_shopping_cart_rounded,
                      // size: 28.0,
                      color: Colors.white,
                    ),
                  ),
                  // AutoSizeText(
                  //   menuItem.name,
                  //   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  //   overflow: TextOverflow.ellipsis,
                  //   maxLines: 1,
                  // ),
                  // Text("Price \$${menuItem.price}", style: kBodyStyle)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                postedDate,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12.0),
              ),
            ),
            const SizedBox(height: 10.0),
            _buildExtraDetailsView(),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  Widget _buildImageView(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CacheImgWidget(
          menuItem.img,
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 4.0,
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(kBorderRadius),
              ),
              child: Text(menuItem.name, style: kTitleStyle),
            ),
          ),
        ),
      ],
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
              Icon(Icons.people, color: Colors.grey.shade700, size: 22.0),
              Text(menuItem.serve),
            ],
          ),
          menuItem.menuStatus == 'Available'
              ? Wrap(
                  spacing: 10.0,
                  children: const [
                    Icon(Icons.check_circle, color: Colors.green, size: 22.0),
                    Text(
                      'Available',
                      style: TextStyle(color: Colors.green),
                    )
                  ],
                )
              : Wrap(
                  spacing: 10.0,
                  children: [
                    Icon(Icons.cancel, color: Colors.red.shade800, size: 22.0),
                    Text(
                      'Unavailable',
                      style: TextStyle(color: Colors.red.shade800),
                    )
                  ],
                ),
          Wrap(
            spacing: 10.0,
            children: [
              Icon(Icons.category, color: Colors.grey.shade700, size: 22.0),
              Text(menuItem.category),
            ],
          ),
        ],
      ),
    );
  }
}
