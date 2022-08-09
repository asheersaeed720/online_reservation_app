import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_reservation_app/src/menu_screen/menu.dart';
import 'package:online_reservation_app/src/menu_screen/menu_controller.dart';
import 'package:online_reservation_app/src/menu_screen/widgets/menu_item_widget.dart';
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
