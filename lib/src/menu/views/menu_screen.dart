import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_reservation_app/src/cart/cart_controller.dart';
import 'package:online_reservation_app/src/cart/cart_screen.dart';
import 'package:online_reservation_app/src/menu/menu.dart';
import 'package:online_reservation_app/src/menu/menu_controller.dart';
import 'package:online_reservation_app/src/menu/widgets/menu_item_widget.dart';
import 'package:online_reservation_app/utils/constants.dart';
import 'package:online_reservation_app/widgets/loading_widget.dart';

class MenuScreen extends StatelessWidget {
  static const String routeName = '/menu';

  MenuScreen({Key? key}) : super(key: key);

  final _menuCtrl = Get.put(MenuController());

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;

    final restaurantId = args['restaurantId'];
    return StreamBuilder<QuerySnapshot<MenuModel>>(
      stream: _menuCtrl.getMenus(restaurantId),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<QueryDocumentSnapshot<MenuModel>> menuList =
              snapshot.data!.docs as List<QueryDocumentSnapshot<MenuModel>>;
          return Scaffold(
            appBar: AppBar(
              title: Text('Menus ( ${menuList.length} )'),
              iconTheme: const IconThemeData(color: Colors.black87),
            ),
            body: menuList.isEmpty
                ? Center(
                    child: Text('No Menus Found', style: kTitleStyle),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: menuList.length,
                    separatorBuilder: (context, _) => const SizedBox(height: 10.0),
                    itemBuilder: (context, i) {
                      return MenuItemWidget(
                        menuList[i].id,
                        menuList[i].data(),
                      );
                    },
                  ),
            bottomNavigationBar: GetBuilder<CartController>(
              init: CartController(),
              builder: (cartCtrl) => cartCtrl.cartItemList.isEmpty
                  ? const SizedBox.shrink()
                  : _buildCartBtnView(cartCtrl.cartItemList.length),
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

  Widget _buildCartBtnView(int quantity) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        onPressed: () {
          Get.toNamed(CartScreen.routeName);
        },
        icon: Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(Icons.shopping_cart),
            Positioned(
              top: -3,
              right: -3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.red.shade700,
                ),
                constraints: const BoxConstraints(
                  minWidth: 15,
                  minHeight: 15,
                ),
                child: Text(
                  '$quantity',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
        label: const Text('View Cart'),
      ),
    );
  }
}
