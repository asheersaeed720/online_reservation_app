import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_reservation_app/utils/reservation_status.dart';

class ReservationModel {
  final String uid;
  final String customerName;
  final String numberOfPeople;
  final String phoneNumber;
  final String email;
  final String date;
  final String time;
  final String status;
  final String restaurantId;
  final List<dynamic> menuList; //? {menu_id, menuName, qty}
  final double totalAmount;
  final Timestamp createdAt;

  ReservationModel({
    required this.uid,
    required this.customerName,
    required this.numberOfPeople,
    required this.phoneNumber,
    required this.email,
    required this.date,
    required this.time,
    this.status = ReservationStatus.pending,
    required this.restaurantId,
    required this.menuList,
    required this.totalAmount,
    required this.createdAt,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      uid: json['uid'],
      customerName: json['customer_name'],
      numberOfPeople: json['number_of_people'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      date: json['date'],
      time: json['time'],
      status: json['status'],
      restaurantId: json['restaurant_id'],
      menuList: json['menu_list'],
      totalAmount: json['total_amount'],
      createdAt: json['created_at'],
    );
  }

  Map<String, Object?> toJson() {
    return {
      'uid': uid,
      'customer_name': customerName,
      'number_of_people': numberOfPeople,
      'phone_number': phoneNumber,
      'email': email,
      'date': date,
      'time': time,
      'status': status,
      'restaurant_id': restaurantId,
      'menu_list': menuList,
      'total_amount': totalAmount,
      'created_at': createdAt,
    };
  }
}
