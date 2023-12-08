import 'package:countify/signing/model/user.dart';
import 'package:countify/signing/views/home_screen.dart';
import 'package:countify/signing/views/registration_screen.dart';
import 'package:countify/signing/views/splash_screen.dart';
import 'package:countify/signing/widgets/input_field.dart';
import 'package:countify/signing/widgets/logo.dart';
import 'package:countify/util/extensions/on_string.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  static const name = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController passwordController, emailController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late DatabaseReference usersReference;
  DataSnapshot? currentSnapShot;
  User user = User(userName: '', email: '', password: '', userId: '');
  bool isLoading = false;

  // Static constants to enhance performance and readibility

  static const passwordLabel = 'Password';
  static const emailLabel = 'Email';
  static const btnLogin = 'Login';
  static const btnCancel = 'Cancel';
  static const textNotAUser = 'Not a User';
  static const textRegister = 'Register';
  static const emailErrorMessage = 'Incorrect Email';
  static const emailEmptyMessage = 'Required';
  static const passwordErrorMessage = 'Invalid Password';
  static const passwordEmptyMessage = 'Required';
  static const userNotFoundText = 'User Not Found';
  static const incorrectPassword = 'Incorrect Password';

  // Necessary Overrides for initialization and memory leak preventions

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    usersReference =
        FirebaseDatabase.instance.ref().child(User.userReferenceKey);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Input Fields Validations

  String? _emailValidator(String? value) {
    if (value != null && value.isEmpty) {
      return emailEmptyMessage;
    }
    if (value.isEmail()) {
      return null;
    }
    return emailErrorMessage;
  }

  String? _passwordValidator(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return passwordEmptyMessage;
      }
      return null;
    }
    return passwordErrorMessage;
  }

  // Events Handling

  void _onBtnLoginPress() async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      _updateScreen();

      bool isAuth = await isAuthenticated();
      if (isAuth) {
        if (isCorrectPassword()) {
          User.getInstance(
            userName: user.userName,
            email: user.email,
            password: user.password,
            userId: user.userId,
          );
          isLoading = false;
          navigateForward();
        } else {
          showIncorrectPasswordSnackBar();
        }
      } else {
        showUserNotFoundSnackBar();
      }
    }
  }

  void _onBtnCancelPress() {
    SystemNavigator.pop();
  }

  void _onTextRegisterPress() {
    emailController.clear();
    passwordController.clear();
    Navigator.of(context).pushNamed(RegistrationScreen.name);
  }

  // Firebase authentication and User checks

  void navigateForward() {
    Navigator.of(context)
        .pushReplacementNamed(HomeScreen.name, arguments: user);
  }

  Future<bool> isAuthenticated() async {
    String email = emailController.text;
    String id = email.substring(0, email.indexOf('@'));
    currentSnapShot = await usersReference.child(id).get();
    return Future.value(currentSnapShot!.exists);
  }

  bool isCorrectPassword() {
    Map map = currentSnapShot!.value as Map;
    Map<String, dynamic> userMap = Map<String, dynamic>.from(map);
    user = User.fromMap(userMap);
    return user.password.compareTo(passwordController.text) == 0;
  }

  // Snack bars to infrom user correctly

  void showUserNotFoundSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          userNotFoundText,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }

  void showIncorrectPasswordSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          incorrectPassword,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }

  void _updateScreen(){
    setState(() {
      
    });
  }

  // Screen building

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    double fontSize = (width + height) / 60;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
        child: Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Spacer(
                      flex: 5,
                    ),
                    const Expanded(
                      flex: 25,
                      child: Hero(
                        tag: SplashScreen.heroTag,
                        child: Logo(),
                      ),
                    ),
                    const Spacer(
                      flex: 5,
                    ),
                    Expanded(
                      flex: 39,
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
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
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: _onBtnLoginPress,
                            child: const Text(btnLogin),
                          ),
                          ElevatedButton(
                            onPressed: _onBtnCancelPress,
                            child: const Text(btnCancel),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                    Expanded(
                      flex: 8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('$textNotAUser  ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontSize: fontSize)),
                          GestureDetector(
                            onTap: _onTextRegisterPress,
                            child: Text(
                              textRegister,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontSize: fontSize,
                                    decoration: TextDecoration.underline,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(
                      flex: 7,
                    ),
                  ],
                ),
              ),
              if (isLoading) const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
