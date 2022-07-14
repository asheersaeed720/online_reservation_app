import 'package:flutter/material.dart';

class UserReservationScreen extends StatelessWidget {
  static const String routeName = '/user-reservations';

  const UserReservationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Reservations screen'),
      ),
    );
  }
}
