import 'dart:async';

import 'package:countify/chats/widgets/chat_tile.dart';
import 'package:countify/chats/widgets/start_chat_dialog.dart';
import 'package:countify/signing/model/user.dart';
import 'package:countify/util/extensions/on_string.dart';
import 'package:countify/util/theme/color_theme.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChatsMasterScreen extends StatefulWidget {
  static const name = '/chatsmasterscreen';
  const ChatsMasterScreen({super.key});

  @override
  State<ChatsMasterScreen> createState() => _ChatsMasterScreenState();
}

class _ChatsMasterScreenState extends State<ChatsMasterScreen> {
  // Static constants to improve performance and readability
  static const chatReferenceKey = 'Chats';
  static const userNotFoundText = 'User Not Found';
  static const userAlreadyAddedText = 'User Already Added';
  static const emailErrorText = 'Invalid Email';
  static const emailEmptyText = 'Required';
  static const appBarTitle = 'Chats';
  bool isLoading = true;

  late TextEditingController emailController;
  late User currentUser;
  final List<User> usersList = [];
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late DatabaseReference chatsReference, usersReference;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    currentUser = User.getInstance();
    chatsReference = FirebaseDatabase.instance.ref().child(chatReferenceKey);
    usersReference =
        FirebaseDatabase.instance.ref().child(User.userReferenceKey);
    Timer(
        const Duration(
          seconds: 10,
        ), () {
      isLoading = false;
      _updateScreen();
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    // Listening every user add in the firebase and updating local one
    chatsReference.child(currentUser.userId).onChildAdded.listen((event) {
      isLoading = false;
      usersList.add(userFromSnapShot(event.snapshot));
      _updateScreen();
    });
  }

  // Event handling of Dialog start button

  void _onStartChatPress() async {
    if (globalKey.currentState?.validate() ?? false) {
      String id =
          emailController.text.substring(0, emailController.text.indexOf('@'));
      final snapshot = await usersReference.child(id).get();
      if (snapshot.exists) {
        User user = userFromSnapShot(snapshot);
        if (!usersList.contains(user)) {
          chatsReference.child(currentUser.userId).push().set(user.toMap());
          chatsReference.child(user.userId).push().set(currentUser.toMap());
        } else {
          showUserAlreadyAddedSnackBar();
        }
      } else {
        showUserNotFoundSnackBar();
      }
      removeDialog();
    }
  }

  // Screen Regulation and helper functions

  void _updateScreen() {
    setState(() {});
  }

  User userFromSnapShot(DataSnapshot snapshot) {
    Map<String, dynamic> userMap =
        Map<String, dynamic>.from(snapshot.value as Map);
    return User.fromMap(userMap);
  }

  void removeDialog() {
    emailController.clear();
    Navigator.of(context).pop();
  }

  // Appropriate SnackBar to inform user about query status

  void showUserNotFoundSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(userNotFoundText),
      ),
    );
  }

  void showUserAlreadyAddedSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(userAlreadyAddedText),
      ),
    );
  }

  // Dialog email field Validator

  String? _emailValidator(String? value) {
    if (value != null && value.isNotEmpty) {
      if (value.isEmail()) {
        return null;
      }
      return emailErrorText;
    }
    return emailEmptyText;
  }

  // Event Handling for new User in chats

  void _addBtnTap() async {
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: StartChatDialog(
            globalKey: globalKey,
            controller: emailController,
            validator: _emailValidator,
            onPressed: _onStartChatPress,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColorScheme.primary,
        foregroundColor: Colors.white,
        title: const Text(appBarTitle),
      ),
      body: SizedBox(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Builder(
                  builder: (context) {
                    if (usersList.isEmpty) {
                      Text(
                        'Start Chat Now',
                        style: Theme.of(context).textTheme.bodyLarge,
                      );
                    }
                    return ListView.builder(
                      itemCount: usersList.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ChatTile(
                          user: usersList[index],
                        );
                      },
                    );
                  },
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: _addBtnTap,
        backgroundColor: AppColorScheme.primary,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
