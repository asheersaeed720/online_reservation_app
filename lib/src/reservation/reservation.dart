import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_reservation_app/utils/reservation_status.dart';

class ReservationModel {
  final String customerName;
  final String numberOfPeople;
  final String phoneNumber;
  final String email;
  final String date;
  final String time;
  final String status;
  final List<dynamic> menuList; //? {menu_id:asdsd, qty:2}
  final double totalAmount;
  final Timestamp createdAt;

  ReservationModel({
    required this.customerName,
    required this.numberOfPeople,
    required this.phoneNumber,
    required this.email,
    required this.date,
    required this.time,
    this.status = ReservationStatus.pending,
    required this.menuList,
    required this.totalAmount,
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
      status: json['status'],
      menuList: json['menu_list'],
      totalAmount: json['total_amount'],
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
      'status': status,
      'menu_list': menuList,
      'total_amount': totalAmount,
      'created_at': createdAt,
    };
  }
}
