import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:online_reservation_app/src/cart/cart.dart';
import 'package:online_reservation_app/src/reservation/reservation_controller.dart';
import 'package:online_reservation_app/utils/constants.dart';
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

  @override
  void initState() {
    _yourNameController.text = _authUser?.displayName ?? '';
    _phoneNoController.text = _authUser?.phoneNumber ?? '';
    _emailController.text = _authUser?.email ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final menuList = Get.arguments as Iterable<CartModel>;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservation'),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          children: [
            const SizedBox(height: 12.0),
            CustomInputField(
              hintText: 'Your name',
              controller: _yourNameController,
              prefixIcon: const Icon(Icons.person),
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 16.0),
            CustomInputField(
              hintText: 'Number of people',
              controller: _numberOfPeopleController,
              prefixIcon: const Icon(Icons.people),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            CustomInputField(
              hintText: 'Phone number',
              controller: _phoneNoController,
              prefixIcon: const Icon(Icons.phone),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16.0),
            CustomInputField(
              hintText: 'Your email',
              controller: _emailController,
              prefixIcon: const Icon(Icons.email),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DateTimeField(
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
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DateTimeField(
                format: DateFormat("HH:mm"),
                controller: _timeController,
                validator: (value) {
                  if (value == null) {
                    return 'Required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Select Time',
                  contentPadding: const EdgeInsets.only(left: 12.0, top: 10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(kBorderRadius),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(kBorderRadius),
                    borderSide: const BorderSide(width: 1.0, color: Colors.red),
                  ),
                  prefixIcon: const Icon(Icons.access_time),
                ),
                onShowPicker: (context, currentValue) async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                  );
                  return DateTimeField.convert(time);
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomAsyncBtn(
                btnTxt: 'Confirm Reservation',
                onPress: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }

                    List<Map<String, dynamic>> list = [];
                    for (var element in menuList) {
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
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
