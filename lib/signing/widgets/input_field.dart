import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  static const borderRadius = 20.0;
  static const widthPercent = 0.8;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final bool isPassword;
  final String labelText, helperText;

  const InputField({
    super.key,
    required this.controller,
    required this.validator,
    this.isPassword = false,
    this.helperText = '',
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return SizedBox(
      width: width * widthPercent,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: Theme.of(context).textTheme.labelSmall,
          helperText: helperText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              borderRadius,
            ),
          ),
        ),
        style: Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(fontSize: (width + height) / 80),
        controller: controller,
        maxLength: isPassword ? 8 : 100,
        buildCounter: (context,
                {currentLength = 0, isFocused = false, maxLength}) =>
            isPassword
                ? Text(
                    '$currentLength/$maxLength',
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                : const SizedBox.shrink(),
        validator: validator,
        obscureText: isPassword,
      ),
    );
  }
}
