import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String userName;
  final GestureTapCallback backgroundImageEditTap, profileImageEditTap;
  final File? backgroundImageFile, profileImageFile;
  static const backgroundImageAsset = 'assets/images/logo_img.png',
      profileImageAsset = 'assets/images/dummy.jpg';
  static const textLeftPercent = 0.55, textTopPercent = 0.22;
  static const profileImgEditLeftPercent = 0.3, profileImgEditTopPercent = 0.23;
  static const profileImgLeftPercent = 0.1,
      profileImgTopPercent = 0.13,
      profileImageWidthPercent = 0.3,
      profileImageHeightPercent = 0.15;
  static const backgroundImgEditLeftPercent = 0.9,
      backgroundImgEditTopPercent = 0.01;
  static const backgroundImageHeightPercent = 0.2;
  static const headerHeightPercent = 0.3;
  const Header({
    super.key,
    this.userName = 'UserName',
    required this.backgroundImageEditTap,
    this.backgroundImageFile,
    required this.profileImageEditTap,
    this.profileImageFile,
  });

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return SizedBox(
      height: height * headerHeightPercent,
      child: Stack(
        children: [
          const SizedBox.expand(),
          Positioned(
            width: width,
            height: height * backgroundImageHeightPercent,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: (backgroundImageFile == null
                      ? const AssetImage(backgroundImageAsset)
                      : FileImage(backgroundImageFile!)) as ImageProvider,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            left: width * backgroundImgEditLeftPercent,
            top: height * backgroundImgEditTopPercent,
            child: GestureDetector(
              onTap: backgroundImageEditTap,
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.edit_sharp,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Positioned(
            left: width * profileImgLeftPercent,
            top: height * profileImgTopPercent,
            width: width * profileImageWidthPercent,
            height: height * profileImageHeightPercent,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(
                  3,
                ),
                child: CircleAvatar(
                  foregroundImage: (profileImageFile == null
                      ? const AssetImage(profileImageAsset)
                      : FileImage(profileImageFile!)) as ImageProvider,
                ),
              ),
            ),
          ),
          Positioned(
            left: width * profileImgEditLeftPercent,
            top: height * profileImgEditTopPercent,
            child: GestureDetector(
              onTap: profileImageEditTap,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.edit_sharp,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: width * textLeftPercent,
            top: height * textTopPercent,
            child: AnimatedTextKit(
              isRepeatingAnimation: true,
              repeatForever: true,
              animatedTexts: [
                TypewriterAnimatedText(
                  userName,
                  textStyle: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
