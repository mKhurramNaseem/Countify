import 'package:countify/util/theme/color_theme.dart';
import 'package:flutter/material.dart';

class SheetItem extends StatelessWidget {
  final String text;
  final IconData iconData;
  const SheetItem({
    super.key,
    required this.text,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(
          flex: 36,
        ),
        Expanded(
          flex: 10,
          child: Icon(
            iconData,
            color: AppColorScheme.primary,
          ),
        ),
        const Spacer(
          flex: 2,
        ),
        Expanded(
          flex: 30,
          child: Text(text),
        ),
        const Spacer(
          flex: 26,
        ),
      ],
    );
  }
}
