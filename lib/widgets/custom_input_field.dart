import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:online_reservation_app/utils/constants.dart';
import 'package:online_reservation_app/utils/input_validation.dart';

class CustomInputField extends StatelessWidget with InputValidationMixin {
  const CustomInputField({
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    Key? key,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return keyboardType == TextInputType.phone
        ? IntlPhoneField(
            keyboardType: TextInputType.phone,
            initialCountryCode: 'PK',
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: const EdgeInsets.only(left: 12.0, top: 10.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kBorderRadius),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kBorderRadius),
                borderSide: const BorderSide(width: 1.0, color: Colors.red),
              ),
            ),
            onChanged: (phone) {
              controller.text = phone.completeNumber;
            },
          )
        : TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            validator: (value) {
              if (keyboardType == TextInputType.emailAddress) {
                return validateEmail(value ?? '');
              } else if (keyboardType == TextInputType.visiblePassword) {
                return validatePassword(value ?? '');
              } else {
                return validateName(value ?? '');
              }
            },
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: const EdgeInsets.only(left: 12.0, top: 10.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kBorderRadius),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kBorderRadius),
                borderSide: const BorderSide(width: 1.0, color: Colors.red),
              ),
              prefixIcon: prefixIcon ?? const SizedBox.shrink(),
              suffixIcon: suffixIcon ?? const SizedBox.shrink(),
            ),
          );
  }
}
