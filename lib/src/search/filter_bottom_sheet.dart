import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_reservation_app/utils/constants.dart';
import 'package:online_reservation_app/widgets/custom_async_btn.dart';

enum FilterOptions {
  all,
  lounge,
  cafe,
  sweetsAndJuices,
  enjoyment,
  restaurants,
}

void filterBottomSheet(BuildContext context) {
  final _formKey = GlobalKey<FormState>();

  FilterOptions? _filterOptions = FilterOptions.all;

  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(12),
        topLeft: Radius.circular(12),
      ),
    ),
    isScrollControlled: true,
    context: context,
    builder: (builder) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 14.0),
                Container(
                  width: 62.0,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 4.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0, top: 24, left: 16),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/icons/filter.png',
                        width: 34.0,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        "Filter",
                        style: kTitleStyle,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Image.asset(
                    'assets/images/divider.jpg',
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 6.0),
                RadioListTile<FilterOptions>(
                  title: const Text('All'),
                  value: FilterOptions.all,
                  groupValue: _filterOptions,
                  onChanged: (FilterOptions? value) {
                    setState(() {
                      _filterOptions = value;
                    });
                  },
                ),
                RadioListTile<FilterOptions>(
                  title: const Text('Lounge'),
                  value: FilterOptions.lounge,
                  groupValue: _filterOptions,
                  onChanged: (FilterOptions? value) {
                    setState(() {
                      _filterOptions = value;
                    });
                  },
                ),
                RadioListTile<FilterOptions>(
                  title: const Text('Cafe'),
                  value: FilterOptions.cafe,
                  groupValue: _filterOptions,
                  onChanged: (FilterOptions? value) {
                    setState(() {
                      _filterOptions = value;
                    });
                  },
                ),
                RadioListTile<FilterOptions>(
                  title: const Text('Sweets and Juices'),
                  value: FilterOptions.sweetsAndJuices,
                  groupValue: _filterOptions,
                  onChanged: (FilterOptions? value) {
                    setState(() {
                      _filterOptions = value;
                    });
                  },
                ),
                RadioListTile<FilterOptions>(
                  title: const Text('Enjoyment'),
                  value: FilterOptions.enjoyment,
                  groupValue: _filterOptions,
                  onChanged: (FilterOptions? value) {
                    setState(() {
                      _filterOptions = value;
                    });
                  },
                ),
                RadioListTile<FilterOptions>(
                  title: const Text('Restaurants'),
                  value: FilterOptions.restaurants,
                  groupValue: _filterOptions,
                  onChanged: (FilterOptions? value) {
                    setState(() {
                      _filterOptions = value;
                    });
                  },
                ),
                const SizedBox(height: 12.0),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomAsyncBtn(
                    btnTxt: 'Apply',
                    onPress: () {
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
