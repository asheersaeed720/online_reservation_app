import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_reservation_app/src/cart/cart_controller.dart';
import 'package:online_reservation_app/src/reservation/views/create_reservation_screen.dart';
import 'package:online_reservation_app/utils/constants.dart';
import 'package:online_reservation_app/widgets/cache_img_widget.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';

  CartScreen({Key? key}) : super(key: key);

  final _cartCtrl = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Your Cart',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            iconTheme: const IconThemeData(color: Colors.black87),
            elevation: 0,
          ),
          body: ListView.separated(
            itemCount: _cartCtrl.cartItemList.length,
            separatorBuilder: (context, _) => const SizedBox(height: 6.0),
            itemBuilder: (context, i) => Dismissible(
              key: Key(_cartCtrl.cartItemList.values.toList()[i].menuId),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) => _cartCtrl.removeMenu(
                _cartCtrl.cartItemList.values.toList()[i].menuId,
              ),
              background: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE6E6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Spacer(),
                    Icon(Icons.delete, color: Theme.of(context).errorColor),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 14.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12.0),
                        Row(
                          children: [
                            CacheImgWidget(
                              _cartCtrl.cartItemList.values.toList()[i].img,
                              width: 88.0,
                              height: 88.0,
                            ),
                            const SizedBox(width: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  child: AutoSizeText(
                                    _cartCtrl.cartItemList.values.toList()[i].name,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(height: 2.0),
                                Text(
                                    '\$${_cartCtrl.cartItemList.values.toList()[i].price.toStringAsFixed(2)}'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () async {
                            _cartCtrl.removeMenu(_cartCtrl.cartItemList.values.toList()[i].menuId);
                          },
                          child: Icon(
                            Icons.delete_outline,
                            color: Colors.red.shade700,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  _cartCtrl.decreaseItem(
                                    menuId: _cartCtrl.cartItemList.values.toList()[i].menuId,
                                    qty: _cartCtrl.cartItemList.values.toList()[i].qty,
                                  );
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(2),
                                  child: Center(
                                    child: Icon(
                                      Icons.remove,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'x ${_cartCtrl.cartItemList.values.toList()[i].qty}',
                              style: kBodyStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  _cartCtrl.addToCart(
                                    menuId: _cartCtrl.cartItemList.values.toList()[i].menuId,
                                    name: _cartCtrl.cartItemList.values.toList()[i].name,
                                    price: _cartCtrl.cartItemList.values.toList()[i].price,
                                    serve: _cartCtrl.cartItemList.values.toList()[i].serve,
                                    menuStatus:
                                        _cartCtrl.cartItemList.values.toList()[i].menuStatus,
                                    category: _cartCtrl.cartItemList.values.toList()[i].category,
                                    restaurantId:
                                        _cartCtrl.cartItemList.values.toList()[i].restaurantId,
                                    restaurantName:
                                        _cartCtrl.cartItemList.values.toList()[i].restaurantName,
                                    img: _cartCtrl.cartItemList.values.toList()[i].img,
                                  );
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(2),
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: _buildReservationBottomView(),
        );
      },
    );
  }

  Widget _buildReservationBottomView() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 30.0,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      TextSpan(
                        text: _cartCtrl.totalAmount.toStringAsFixed(2),
                        style: kBodyStyle.copyWith(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 190.0,
                  child: GetBuilder<CartController>(
                    builder: (_) => ElevatedButton(
                      onPressed: () {
                        Get.toNamed(
                          CreateReservationScreen.routeName,
                          arguments: _cartCtrl.cartItemList.values.toList(),
                        );
                      },
                      child: Text(
                        'Reservation',
                        style: kBodyStyle.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
