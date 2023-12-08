import 'package:countify/signing/model/user.dart';
import 'package:countify/signing/widgets/input_field.dart';
import 'package:countify/util/extensions/on_string.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RegistrationScreen extends StatefulWidget {
  static const name = '/registration';
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late TextEditingController userNameController,
      emailController,
      passwordController,
      confirmPasswordController;
  late DatabaseReference baseReference, usersReference;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

// Static constants of class to enhance performance and readability

  static const userNameLabel = 'Username',
      emailLabel = 'Email',
      passwordLabel = 'Password',
      confirmPasswordLabel = 'Confirm Password';
  static const btnRegisterText = 'Register', btnCancelText = 'Cancel';
  static const lottiePath = 'assets/animations/lottie.json';
  static const userExistsText = 'User Already Exists';
  static const userNameEmptyMessage = 'Required Field';
  static const emailErrorMessage = 'Invalid Email';
  static const emailEmptyMessage = 'Required Field';
  static const passwordUnequalMessage = 'Passwords don\'t match';
  static const passwordEmptyMessage = 'Required Field';
  static const registrationDone = 'Registration Done';
  static const dialogTitle = 'Confirm Registration';
  static const dialogContent = 'Information cannot be changed';
  static const dialogBtnRegister = 'Register';
  static const dialogBtnCancel = 'Cancel';

  // Necessary Overrides for initializtions and memory leak preventions

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    baseReference = FirebaseDatabase.instance.ref();
    usersReference = baseReference.child(User.userReferenceKey);
  }

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // Input Fields Validations

  String? _userNameValidator(String? value) {
    if (value != null && value.isNotEmpty) {
      return null;
    }
    return userNameEmptyMessage;
  }

  String? _emailValidator(String? value) {
    if (value != null && value.isNotEmpty) {
      if (value.isEmail()) {
        return null;
      }
      return emailErrorMessage;
    }
    return emailEmptyMessage;
  }

  String? _passwordValidator(String? value) {
    if (value != null && value.isNotEmpty) {
      if (value.compareTo(confirmPasswordController.text) == 0) {
        return null;
      }
      return passwordUnequalMessage;
    }
    return passwordEmptyMessage;
  }

  String? _confirmPasswordValidator(String? value) {
    if (value != null && value.isNotEmpty) {
      if (value.compareTo(passwordController.text) == 0) {
        return null;
      }
      return passwordUnequalMessage;
    }
    return passwordEmptyMessage;
  }

  // Event Handling

  void _onBtnRegisterPress() async {
    if (formKey.currentState?.validate() ?? false) {
      showConfrimationDialog();
    }
  }

  void _onBtnCancelPress() {
    Navigator.of(context).pop();
  }

  // ConfirmationDialog

  void showConfrimationDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(dialogTitle),
        content: const Text(dialogContent),
        actions: [
          OutlinedButton(
            onPressed: _onPositiveButtonPress,
            child: const Text(dialogBtnRegister),
          ),
          OutlinedButton(
            onPressed: _onNegativeButtonPress,
            child: const Text(dialogBtnCancel),
          ),
        ],
      ),
    );
  }

  // Dialog Events Handling

  void _onPositiveButtonPress() async {
    Navigator.of(context).pop();
    String email = emailController.text;
    String userId = email.substring(0, email.indexOf('@'));
    bool isAuth = await isAuthenticated(userId);
    if (isAuth) {
      showUserExistsSnackBar();
    } else {
      insertData(userId);
    }
  }

  void _onNegativeButtonPress() {
    Navigator.of(context).pop();
  }

  // Firebase User Entry and Authentication Handling

  Future<bool> isAuthenticated(String userId) async {
    DatabaseReference usersReference =
        baseReference.child(User.userReferenceKey);
    DataSnapshot dataSnapshot = await usersReference.child(userId).get();
    return Future.value(dataSnapshot.exists);
  }

  void insertData(String userId) async {
    await usersReference.child(userId).set(User(
            userName: userNameController.text,
            email: emailController.text,
            password: passwordController.text,
            userId: userId)
        .toMap());
    showRegistrationOkSnackBar();
    _onBtnCancelPress();
  }

  // Snack Bars to Inform User Correctly

  void showUserExistsSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          userExistsText,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }

  void showRegistrationOkSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          registrationDone,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }

// Screen Building
  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: width,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Spacer(
                  flex: 5,
                ),
                Expanded(
                  flex: 25,
                  child: Lottie.asset(
                    lottiePath,
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
                Expanded(
                  flex: 50,
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InputField(
                          controller: userNameController,
                          validator: _userNameValidator,
                          labelText: userNameLabel,
                        ),
                        InputField(
                          controller: emailController,
                          validator: _emailValidator,
                          labelText: emailLabel,
                        ),
                        InputField(
                          controller: passwordController,
                          validator: _passwordValidator,
                          labelText: passwordLabel,
                          isPassword: true,
                        ),
                        InputField(
                          controller: confirmPasswordController,
                          validator: _confirmPasswordValidator,
                          labelText: confirmPasswordLabel,
                          isPassword: true,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _onBtnRegisterPress,
                        child: const Text(
                          btnRegisterText,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _onBtnCancelPress,
                        child: const Text(
                          btnCancelText,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(
                  flex: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
