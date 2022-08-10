import 'dart:developer';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:online_reservation_app/src/cart/cart.dart';
import 'package:online_reservation_app/src/reservation/reservation_controller.dart';
import 'package:online_reservation_app/utils/constants.dart';
import 'package:online_reservation_app/utils/display_toast_message.dart';
import 'package:online_reservation_app/widgets/cache_img_widget.dart';
import 'package:online_reservation_app/widgets/custom_async_btn.dart';
import 'package:online_reservation_app/widgets/custom_input_field.dart';

class CreateReservationScreen extends StatefulWidget {
  static const String routeName = '/create-reservation';

  const CreateReservationScreen({Key? key}) : super(key: key);

  @override
  State<CreateReservationScreen> createState() => _CreateReservationScreenState();
}

class _CreateReservationScreenState extends State<CreateReservationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _authUser = FirebaseAuth.instance.currentUser;

  final _reservationCtrl = Get.put(ReservationController());

  final TextEditingController _yourNameController = TextEditingController();
  final TextEditingController _numberOfPeopleController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  DateTime dateTime = DateTime.now();

  @override
  void initState() {
    _yourNameController.text = _authUser?.displayName ?? '';
    _phoneNoController.text = _authUser?.phoneNumber ?? '';
    _emailController.text = _authUser?.email ?? '';

    var formattedDate = DateFormat.Hm().format(dateTime);
    String parseCurrentTime = '${formattedDate[0]}${formattedDate[1]}:00';
    log('parseCurrentTime $parseCurrentTime');
    _timeController.text = parseCurrentTime;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final List<CartModel> cartItemList = args['cartItemList'];
    final double totalAmount = args['totalAmount'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Reservation'),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          children: [
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4.0),
              child: Text('Items ( ${cartItemList.length} )', style: kBodyStyle),
            ),
            const SizedBox(height: 4.0),
            ...cartItemList
                .map(
                  (e) => Card(
                    child: ListTile(
                      leading: CacheImgWidget(
                        e.img,
                        width: 50.0,
                        height: 50.0,
                      ),
                      title: Text(e.name),
                      subtitle: Text('\$${e.price.toStringAsFixed(2)}'),
                      trailing: Text('x ${e.qty}', style: kBodyStyle),
                    ),
                  ),
                )
                .toList(),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4.0),
              child: Text(
                'Total Amount: \$$totalAmount',
                style: kBodyStyle.copyWith(color: Colors.grey.shade800),
                textAlign: TextAlign.end,
              ),
            ),
            const SizedBox(height: 4.0),
            const Divider(),
            const SizedBox(height: 4.0),
            const Text('Your name'),
            const SizedBox(height: 6.0),
            CustomInputField(
              hintText: 'Your name',
              controller: _yourNameController,
              prefixIcon: const Icon(Icons.person),
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 18.0),
            const Text('Number of people'),
            const SizedBox(height: 6.0),
            CustomInputField(
              hintText: 'Number of people',
              controller: _numberOfPeopleController,
              prefixIcon: const Icon(Icons.people),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 18.0),
            const Text('Phone number'),
            const SizedBox(height: 6.0),
            CustomInputField(
              hintText: 'Phone number',
              controller: _phoneNoController,
              prefixIcon: const Icon(Icons.phone),
              keyboardType: TextInputType.phone,
            ),
            const Text('Your email'),
            const SizedBox(height: 6.0),
            CustomInputField(
              hintText: 'Your email',
              controller: _emailController,
              prefixIcon: const Icon(Icons.email),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 18.0),
            const Text('Select Date'),
            const SizedBox(height: 6.0),
            DateTimeField(
              format: DateFormat.yMMMEd(),
              controller: _dateController,
              validator: (value) {
                if (value == null) {
                  return 'Required';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Select Date',
                contentPadding: const EdgeInsets.only(left: 12.0, top: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kBorderRadius),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kBorderRadius),
                  borderSide: const BorderSide(width: 1.0, color: Colors.red),
                ),
                prefixIcon: const Icon(Icons.date_range),
              ),
              onShowPicker: (context, currentValue) async {
                final datePicker = showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  initialDate: currentValue ?? DateTime.now(),
                  lastDate: DateTime(2100),
                );

                final pickedDate = await datePicker;
                if (pickedDate != null) {
                  String currentDate = DateFormat('yyyy-MM-dd').format(dateTime);
                  String selectedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  DateTime parseCurrentDate = DateTime.parse(currentDate);
                  DateTime parseSelectedDate = DateTime.parse(selectedDate);
                  log('$parseCurrentDate == $parseSelectedDate');
                  if (parseSelectedDate.isBefore(parseCurrentDate)) {
                    displayToastMessage("Can not select past date");
                    return null;
                  }
                  return datePicker;
                }
                return null;
              },
            ),
            const SizedBox(height: 18.0),
            const Text('Select Time'),
            const SizedBox(height: 6.0),
            DropdownButton<String>(
              value: _timeController.text,
              onChanged: (String? value) {
                var formattedDate = DateFormat.Hm().format(dateTime);
                int parseCurrentTime = int.parse(
                  '${formattedDate[0]}${formattedDate[1]}${formattedDate[3]}${formattedDate[4]}',
                );
                int parseSelectedTime = int.parse(
                  '${value![0]}${value[1]}${value[3]}${value[4]}',
                );
                log('Selection $parseSelectedTime $parseCurrentTime');
                if (parseSelectedTime != 0000) {
                  if (parseSelectedTime < parseCurrentTime) {
                    displayToastMessage("Can't select past time");
                  } else {
                    setState(() {
                      _timeController.text = value;
                    });
                  }
                } else {
                  setState(() {
                    _timeController.text = value;
                  });
                }
              },
              items: <String>[
                '18:00',
                '19:00',
                '20:00',
                '21:00',
                '22:00',
                '23:00',
                '00:00',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            // DropdownSearch<String>(
            //   items: const [
            //     "18:00",
            //     "20:00",
            //     "22:00",
            //     "00:00",
            //   ],
            //   onChanged: (value) {
            //     var formattedDate = DateFormat.Hm().format(dateTime);
            //     int parseCurrentTime = int.parse(
            //       '${formattedDate[0]}${formattedDate[1]}${formattedDate[3]}${formattedDate[4]}',
            //     );
            //     int parseSelectedTime = int.parse(
            //       '${value![0]}${value[1]}${value[3]}${value[4]}',
            //     );
            //     log('Selection $parseSelectedTime $parseCurrentTime');
            //     if (parseSelectedTime != 00) {
            //       if (parseSelectedTime < parseCurrentTime) {
            //         displayToastMessage("Can't select past time");
            //       } else {
            //         _timeController.text = value;
            //       }
            //     }
            //   },
            //   selectedItem: _timeController.text,
            //   dropdownDecoratorProps: DropDownDecoratorProps(
            //     dropdownSearchDecoration: InputDecoration(
            //       hintText: 'Select Time',
            //       contentPadding: const EdgeInsets.only(left: 12.0, top: 10.0),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(kBorderRadius),
            //       ),
            //       focusedErrorBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(kBorderRadius),
            //         borderSide: const BorderSide(width: 1.0, color: Colors.red),
            //       ),
            //       prefixIcon: const Icon(Icons.access_time),
            //     ),
            //   ),
            // ),
            // DateTimeField(
            //   format: DateFormat("HH:mm"),
            //   controller: _timeController,
            //   validator: (value) {
            //     if (value == null) {
            //       return 'Required';
            //     }
            //     return null;
            //   },
            // decoration: InputDecoration(
            //   hintText: 'Select Time',
            //   contentPadding: const EdgeInsets.only(left: 12.0, top: 10.0),
            //   border: OutlineInputBorder(
            //     borderRadius: BorderRadius.circular(kBorderRadius),
            //   ),
            //   focusedErrorBorder: OutlineInputBorder(
            //     borderRadius: BorderRadius.circular(kBorderRadius),
            //     borderSide: const BorderSide(width: 1.0, color: Colors.red),
            //   ),
            //   prefixIcon: const Icon(Icons.access_time),
            // ),
            //   onShowPicker: (context, _) async {
            //     DateTime newTime = dateTime.add(const Duration(hours: 3));
            //     final time = await showTimePicker(
            //       context: context,
            //       initialTime: TimeOfDay.fromDateTime(newTime),
            //     );
            //     var formattedTime = DateFormat.Hms().format(newTime);
            //     log('formattedTime $formattedTime');
            //     log('asd ${formattedTime[0][1]}');
            //     // DateTime newFormattedTime = DateTime.parse(DateFormat("HH:mm").format(newTime));
            //     // DateTime currentFormattedTime =
            //     //     DateTime.parse(DateFormat("HH:mm").format(dateTime));

            //     // if (newFormattedTime.isBefore(currentFormattedTime)) {
            //     //   displayToastMessage('early');
            //     //   return null;
            //     // } else {
            //     //   return DateTimeField.convert(time);
            //     // }
            //     return null;
            //   },
            // ),
            const SizedBox(height: 18.0),
            CustomAsyncBtn(
              btnTxt: 'Confirm Reservation',
              onPress: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }

                  List<Map<String, dynamic>> list = [];
                  for (var element in cartItemList) {
                    list.add({
                      'menuId': element.menuId,
                      'qty': element.qty,
                    });
                  }

                  await _reservationCtrl.confirmReservation(
                    context,
                    customerName: _yourNameController.text,
                    numberOfPeople: _numberOfPeopleController.text,
                    phoneNumber: _phoneNoController.text,
                    email: _emailController.text,
                    date: _dateController.text,
                    time: _timeController.text,
                    menuList: list,
                    totalAmount: totalAmount,
                  );
                }
              },
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
