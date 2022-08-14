import 'package:flutter/material.dart';
import 'package:online_reservation_app/utils/constants.dart';

void customAlertDialog(context, String title, String message, onPressed, {Function? onCancel}) {
  AlertDialog alertDialog = AlertDialog(
    title: Text(title, style: kTitleStyle),
    content: Text(
      message,
      style: const TextStyle(fontSize: 18.0),
    ),
    actions: [
      SizedBox(
        width: 88.0,
        child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: const BorderSide(color: Colors.black87),
              ),
            ),
          ),
          onPressed: () async {
            if (onCancel != null) {
              await onCancel();
            }
            Navigator.of(context).pop();
          },
          child: const Text(
            'No',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      SizedBox(
        width: 88.0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.red[900]),
          onPressed: () {
            Navigator.of(context).pop();
            onPressed();
          },
          child: const Text(
            'Yes',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ],
  );
  showDialog(context: context, builder: (_) => alertDialog);
}
