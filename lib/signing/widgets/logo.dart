import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double width, height;
  static const imagePath = 'assets/images/logo_img.png';
  const Logo({super.key , this.width = 200, this.height = 200,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            imagePath,
          ),
        ),
      ),
    );
  }
}
