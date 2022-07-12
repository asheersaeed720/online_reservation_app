import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

loadingOverlay(BuildContext context) {
  Loader.show(
    context,
    isAppbarOverlay: true,
    isBottomBarOverlay: true,
    progressIndicator: const CircularProgressIndicator(),
    overlayColor: const Color(0x99E8EAF6),
  );
}
