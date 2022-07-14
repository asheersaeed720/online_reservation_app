import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_reservation_app/src/search/filter_bottom_sheet.dart';
import 'package:online_reservation_app/utils/constants.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = '/search';

  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, right: 16.0),
          child: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => Get.back(),
                child: const Icon(Icons.arrow_back, size: 22.0),
              ),
            ),
            titleSpacing: 0.0,
            iconTheme: const IconThemeData(color: Colors.black),
            elevation: 0.0,
            title: _buildSearchBarTextField(context),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBarTextField(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 22.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(style: BorderStyle.none, width: 0),
              ),
              isDense: true,
              hintText: 'Search',
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Icon(Icons.search, size: 22.0),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () => filterBottomSheet(context),
          child: Image.asset('assets/icons/filter.png', color: kPrimaryColor, width: 30.0),
        ),
      ],
    );
  }
}

// class SearchScreen extends StatelessWidget {
//   static const String routeName = '/search';

//   const SearchScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(100.0),
//         child: Padding(
//           padding: const EdgeInsets.only(top: 20.0, right: 16.0),
//           child: AppBar(
//             leading: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: InkWell(
//                 onTap: () => Get.back(),
//                 child: const Icon(Icons.arrow_back, size: 22.0),
//               ),
//             ),
//             titleSpacing: 0.0,
//             iconTheme: const IconThemeData(color: Colors.black),
//             elevation: 0.0,
//             title: _buildSearchBarTextField(context),
//           ),
//         ),
//       ),
//       // body: Column(
//       //   children: [
//       //     ...(_searchController.carPostedAdList).map((e) {
//       //       log(e.title);
//       //       log(e.enterMake);
//       //       if (_searchController.carTextController.text
//       //           .toLowerCase()
//       //           .contains(e.enterMake.toLowerCase())) {
//       //         return _buildCarItemList(context, e);
//       //       }
//       //       return const SizedBox.shrink();
//       //     }).toList()
//       //   ],
//       // ),
//     );
//   }

//   Widget _buildSearchBarTextField(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         // SizedBox(
//         //   width: MediaQuery.of(context).size.width * 0.7,
//         //   child: TypeAheadField(
//         //     textFieldConfiguration: TextFieldConfiguration(
//         //       decoration: InputDecoration(
//         //         contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 22.0),
//         //         border: OutlineInputBorder(
//         //           borderRadius: BorderRadius.circular(8.0),
//         //           borderSide: const BorderSide(style: BorderStyle.none, width: 0),
//         //         ),
//         //         isDense: true,
//         //         hintText: 'Search',
//         //         prefixIcon: const Padding(
//         //           padding: EdgeInsets.symmetric(horizontal: 10.0),
//         //           child: Icon(Icons.search, size: 22.0),
//         //         ),
//         //       ),
//         //     ),
//         //     suggestionsCallback: (pattern) async {
//         //       return _searchController.getCarSuggestions(pattern);
//         //     },
//         //     itemBuilder: (context, String suggestion) {
//         //       return ListTile(
//         //         title: Text(suggestion),
//         //       );
//         //     },
//         //     transitionBuilder: (context, suggestionsBox, controller) {
//         //       return suggestionsBox;
//         //     },
//         //     onSuggestionSelected: (String suggestion) {
//         //       // _searchController.carTextController.text = suggestion;
//         //       // _searchController.search();
//         //     },
//         //   ),
//         // ),
//         InkWell(
//           onTap: () => filterBottomSheet(context),
//           child: Image.asset('assets/icons/filter.png', color: kPrimaryColor, width: 30.0),
//         ),
//       ],
//     );
//   }

//   Widget _buildCarItemList(BuildContext context) {
//     return Card(
//       child: InkWell(
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(8.0),
//                   child: CacheImgWidget(
//                     'e',
//                     width: double.infinity,
//                     height: MediaQuery.of(context).size.height / 4.2,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 14),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'carPostItem.title',
//                         style: kTitleStyle,
//                       ),
//                     ],
//                   ),
//                   ElevatedButton(
//                     onPressed: () {},
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
//                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(6.0),
//                         ),
//                       ),
//                     ),
//                     child: const Text(
//                       'View Details',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16.0),
//           ],
//         ),
//       ),
//     );
//   }
// }
