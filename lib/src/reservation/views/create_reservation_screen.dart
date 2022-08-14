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

  DateTime dateTimeNow = DateTime.now();

  @override
  void initState() {
    _yourNameController.text = _authUser?.displayName ?? '';
    _phoneNoController.text = _authUser?.phoneNumber ?? '';
    _emailController.text = _authUser?.email ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(_reservationCtrl.timePeriod);
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
                  String currentDate = DateFormat('yyyy-MM-dd').format(dateTimeNow);
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
            const Text('Time Slots'),
            const SizedBox(height: 6.0),
            GetBuilder<ReservationController>(
              builder: (_) => _reservationCtrl.timePeriod.contains('AM')
                  ? Text(
                      'Sorry, slots are not available at this time',
                      style: kBodyStyle.copyWith(color: Colors.red.shade800),
                    )
                  : _reservationCtrl.timeSlots.isEmpty
                      ? Text(
                          'Sorry, today there is no time slot available',
                          style: kBodyStyle.copyWith(color: Colors.red.shade800),
                        )
                      : SizedBox(
                          height: 50.0,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: _reservationCtrl.timeSlots.length,
                            separatorBuilder: (context, _) => const SizedBox(width: 16.0),
                            itemBuilder: (context, i) {
                              return ChoiceChip(
                                backgroundColor: Colors.grey.shade300,
                                selectedColor: Colors.grey,
                                label: Text(_reservationCtrl.timeSlots[i], style: kBodyStyle),
                                selected: _reservationCtrl.selectedTimeSlot ==
                                    _reservationCtrl.timeSlots[i],
                                onSelected: (bool selected) {
                                  _reservationCtrl.selectTimeSlot(
                                      selected, _reservationCtrl.timeSlots[i]);
                                },
                              );
                            },
                          ),
                        ),
            ),
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
                      'menuName': element.name,
                      'qty': element.qty,
                    });
                  }

                  if (_reservationCtrl.selectedTimeSlot.isEmpty) {
                    displayToastMessage('Please select time slot');
                  } else {
                    await _reservationCtrl.confirmReservation(
                      context,
                      customerName: _yourNameController.text,
                      numberOfPeople: _numberOfPeopleController.text,
                      phoneNumber: _phoneNoController.text,
                      email: _emailController.text,
                      date: _dateController.text,
                      restaurantId: cartItemList[0].restaurantId,
                      menuList: list,
                      totalAmount: totalAmount,
                    );
                  }
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
