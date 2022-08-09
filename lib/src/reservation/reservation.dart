import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationModel {
  final String customerName;
  final String numberOfPeople;
  final String phoneNumber;
  final String email;
  final String date;
  final String time;
  final List<dynamic> menuList; //? {menu_id:asdsd, qty:2}
  final Timestamp createdAt;

  ReservationModel({
    required this.customerName,
    required this.numberOfPeople,
    required this.phoneNumber,
    required this.email,
    required this.date,
    required this.time,
    required this.menuList,
    required this.createdAt,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      customerName: json['customer_name'],
      numberOfPeople: json['number_of_people'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      date: json['date'],
      time: json['time'],
      menuList: json['menu_list'],
      createdAt: json['created_at'],
    );
  }

  Map<String, Object?> toJson() {
    return {
      'customer_name': customerName,
      'number_of_people': numberOfPeople,
      'phone_number': phoneNumber,
      'email': email,
      'date': date,
      'time': time,
      'menu_list': menuList,
      'created_at': createdAt,
    };
  }
}
