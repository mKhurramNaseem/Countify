import 'package:countify/signing/widgets/input_field.dart';
import 'package:flutter/material.dart';

class StartChatDialog extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String?> validator;
  final VoidCallback onPressed;
  final GlobalKey<FormState> globalKey;
  static const label = 'Email';
  static const widthPercent = 0.95;
  static const heightPercent = 0.3;
  static const inputFieldWidthPercent = 0.8;

  static const btnStartChatText = 'Start Chat';
  const StartChatDialog({
    super.key,
    required this.controller,
    required this.validator,
    required this.onPressed,
    required this.globalKey,
  });

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return SizedBox(
      width: width * widthPercent,
      height: height * heightPercent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Form(
            key: globalKey,
            child: SizedBox(
              width: width * inputFieldWidthPercent,
              child: InputField(
                controller: controller,
                validator: validator,
                labelText: label,
                helperText: '',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: onPressed,
            child: const Text(btnStartChatText),
          ),
        ],
      ),
    );
  }
}
