import 'package:countify/signing/widgets/sheet_item.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  final GestureTapCallback onCameraTap, onGalleryTap;
  static const textCamera = 'Camera';
  static const textGallery = 'Gallery';
  static const heightPercent = 0.2;
  const CustomBottomSheet({
    super.key,
    required this.onCameraTap,
    required this.onGalleryTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * heightPercent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: onCameraTap,
            child: const SheetItem(
              text: textCamera,
              iconData: Icons.camera,
            ),
          ),
          GestureDetector(
            onTap: onGalleryTap,
            child: const SheetItem(
              text: textGallery,
              iconData: Icons.image,
            ),
          ),
        ],
      ),
    );
  }
}
