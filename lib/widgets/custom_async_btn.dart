import 'package:async_button_builder/async_button_builder.dart';
import 'package:flutter/material.dart';
import 'package:online_reservation_app/utils/constants.dart';

class CustomAsyncBtn extends StatelessWidget {
  const CustomAsyncBtn({
    Key? key,
    required this.btnTxt,
    this.width = double.infinity,
    this.height = 48.0,
    this.btnColor = kPrimaryColor,
    this.borderRadius = 6.0,
    this.isLoading = false,
    required this.onPress,
  }) : super(key: key);

  final String btnTxt;
  final double width;
  final double height;
  final Color btnColor;
  final double borderRadius;
  final bool isLoading;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return AsyncButtonBuilder(
      onPressed: () async {
        await onPress();
      },
      buttonState: isLoading ? const ButtonState.loading() : const ButtonState.idle(),
      showSuccess: false,
      loadingWidget: const SizedBox(
        height: 16.0,
        width: 16.0,
        child: CircularProgressIndicator(color: Colors.white),
      ),
      errorWidget: const Text('Error'),
      builder: (context, child, callback, _) {
        return SizedBox(
          width: width,
          height: height,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(btnColor),
              elevation: MaterialStateProperty.all(0.0),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
            ),
            onPressed: callback,
            child: child,
          ),
        );
      },
      child: Text(
        btnTxt,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
          color: btnColor == Colors.white ? Colors.black87 : Colors.white,
        ),
      ),
    );
  }
}

// class CustomButton extends StatelessWidget {
//   final dynamic onTap;
//   final String? btnTxt;
//   final bool isWhiteBackground;
//   final double? btnHeight;
//   final bool isProduct;

//   // ignore: use_key_in_widget_constructors
//   const CustomButton({
//     this.onTap,
//     this.btnTxt,
//     this.isWhiteBackground = false,
//     this.btnHeight,
//     this.isProduct = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: btnHeight ?? 45,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 1,
//             blurRadius: 10,
//             offset: const Offset(0, 3),
//           ),
//         ],
//         gradient: LinearGradient(colors: [
//           AppTheme.gradientEnd,
//           AppTheme.gradientStart,
//         ], begin: Alignment.topLeft, end: Alignment.bottomRight),
//         // borderRadius: BorderRadius.all(Radius.circular(50)),
//       ),
//       child: FlatButton(
//         onPressed: onTap,
//         padding: const EdgeInsets.all(0),
//         disabledColor: Colors.grey[400],
//         disabledTextColor: Theme.of(context).primaryColor,
//         child: Text(
//           btnTxt ?? '',
//           style: !isProduct
//               ? poppinsRegular.copyWith(
//                   color:
//                       isWhiteBackground ? ColorResources.COLOR_PRIMARY : ColorResources.COLOR_WHITE)
//               : poppinsRegular.copyWith(
//                   color:
//                       isWhiteBackground ? ColorResources.COLOR_PRIMARY : ColorResources.COLOR_WHITE,
//                   fontSize: 8),
//         ),
//       ),
//     );
//   }
// }
