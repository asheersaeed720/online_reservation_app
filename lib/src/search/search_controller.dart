

// class SearchController extends NetworkManager {
//   TextEditingController carTextController = TextEditingController(text: '');

//   bool isPriceRangeFilter = true;

//   RangeValues currentRangeValues = const RangeValues(10000, 100000);

//   String yearFilter = '';

//   String conditionFilter = '';

//   List<PostAdModel> carPostedAdList = [];
//   List<String> brandNameList = [
//     'AUDI',
//     'BMW',
//     'BUICK',
//     'CHEVROLET',
//     'FORD',
//     'GREAT WALL',
//     'HONDA',
//     'HYANDAI',
//     'ISUZU',
//     'KIA',
//     'MAZDA',
//     'MERCEDES',
//     'MINI',
//     'MITSUBHI',
//     'NISSAN',
//     'RANGE ROVER',
//     'SUBARU',
//     'SUZUKI',
//     'TOYATA',
//   ];

//   final postRef = postAdCollection.withConverter<PostAdModel>(
//     fromFirestore: (snapshot, _) => PostAdModel.fromJson(snapshot.data()!, documentId: snapshot.id),
//     toFirestore: (postAd, _) => postAd.toJson(),
//   );

//   search() async {
//     Query<PostAdModel> query = postRef;

//     if (carTextController.text.toLowerCase().isNotEmpty) {
//       print("cond enter_make");
//       query = query.where(
//         'enter_make',
//         isEqualTo: carTextController.text.toLowerCase(),
//       );
//     }
//     if (yearFilter.isNotEmpty) {
//       print("cond year");
//       query = query.where(
//         'year',
//         isEqualTo: yearFilter, // Value from filter
//       );
//     }
//     if (conditionFilter.isNotEmpty) {
//       print("cond condition");

//       query = query.where(
//         'condition',
//         isEqualTo: conditionFilter, // Value from filter
//       );
//     }
//     if (isPriceRangeFilter) {
//       print("cond price");
//       // query = query.where(
//       //   'regular_price',
//       //   isGreaterThanOrEqualTo: currentRangeValues.start.round(),
//       // );
//       // query = query.where(
//       //   'regular_price',
//       //   isLessThanOrEqualTo: currentRangeValues.end.round(),
//       // );
//     }

//     carPostedAdList.clear();
//     update();
//     if (carPostedAdList.isEmpty) {
//       await query.get().then((value) {
//         for (var element in value.docs) {
//           carPostedAdList.add(element.data());
//         }
//         log('carPostedAdList $carPostedAdList');
//         update();
//       });
//     }
//   }

//   List<String> getCarSuggestions(String query) {
//     List<String> matches = <String>[];
//     matches.addAll(brandNameList);
//     matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
//     return matches;
//   }
// }
