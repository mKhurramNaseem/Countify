import 'dart:io';

import 'package:countify/signing/model/user.dart';
import 'package:countify/signing/widgets/bottom_sheet.dart';
import 'package:countify/signing/widgets/card_list.dart';
import 'package:countify/signing/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  static const name = '/';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  User currentUser = User(userName: '', email: '', password: '', userId: '');
  File? backgroundImageFile, profileImageFile;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentUser =
        (ModalRoute.of(context)?.settings.arguments ?? currentUser) as User;
  }

  // Image Picking and setting controls for background (cover) image

  void _onBackgroundImageEditButtonTap() {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      showDragHandle: true,
      builder: (context) => CustomBottomSheet(
        onCameraTap: _onBackgroundImageCameraTap,
        onGalleryTap: _onBackgroundImageGalleryTap,
      ),
    );
  }

  void _onBackgroundImageCameraTap() async {
    final file = await ImagePicker().pickImage(source: ImageSource.camera);
    _vanishBottomSheet();
    if (file == null) {
      return;
    }
    backgroundImageFile = File(file.path);
    _updateScreen();
  }

  void _onBackgroundImageGalleryTap() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    _vanishBottomSheet();
    if (file == null) {
      return;
    }
    backgroundImageFile = File(file.path);
    _updateScreen();
  }

  // Image Picking and setting controls for profile image

  void _onProfileImageEditButtonTap() {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      showDragHandle: true,
      builder: (context) => CustomBottomSheet(
        onCameraTap: _onProfileImageCameraTap,
        onGalleryTap: _onProfileImageGalleryTap,
      ),
    );
  }

  void _onProfileImageGalleryTap() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    _vanishBottomSheet();
    if (file == null) {
      return;
    }
    profileImageFile = File(file.path);
    _updateScreen();
  }

  void _onProfileImageCameraTap() async {
    final file = await ImagePicker().pickImage(source: ImageSource.camera);
    _vanishBottomSheet();
    if (file == null) {
      return;
    }
    profileImageFile = File(file.path);
    _updateScreen();
  }

  // Boiler plate codes for screen setting after picking image

  void _updateScreen() {
    if (mounted) {
      setState(() {});
    }
  }

  void _vanishBottomSheet() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                flex: 30,
                child: Header(
                  userName: currentUser.userName,
                  backgroundImageEditTap: _onBackgroundImageEditButtonTap,
                  profileImageEditTap: _onProfileImageEditButtonTap,
                  backgroundImageFile: backgroundImageFile,
                  profileImageFile: profileImageFile,
                ),
              ),
              const Expanded(
                flex: 70,
                child: CardsList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
