import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:online_reservation_app/utils/app_theme.dart';

const Color kPrimaryColor = Color(0xFF589442);

TextStyle kTitleStyle = const TextStyle(
  color: Colors.black87,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
  fontFamily: fontName,
);

TextStyle kBodyStyle = const TextStyle(
  color: Colors.black87,
  fontWeight: FontWeight.bold,
  fontSize: 15.0,
  fontFamily: fontName,
);

const double kBorderRadius = 6.0;

const kInitialPosition = LatLng(-24.8607, 67.0011);
