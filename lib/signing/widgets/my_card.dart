import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final Color backgroundColor;
  final String text;
  final GestureTapCallback onTap;
  static const borderRadius = 20.0;
  static const widthPercent = 0.9, heightPercent = 0.3;
  static const sizedBoxPercent = 0.4;
  const MyCard({
    super.key,
    this.text = '',
    this.backgroundColor = Colors.red,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return SizedBox(
      width: width,
      height: height * sizedBoxPercent,
      child: Center(
        child: InkWell(
          onTap: onTap,
          child: Material(
            child: Container(
              width: width * widthPercent,
              height: height * heightPercent,
              decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(borderRadius),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(5, 5),
                      color: Colors.grey,
                      blurRadius: 7,
                      spreadRadius: 5,
                    )
                  ]),
              child: Center(
                child: AnimatedTextKit(
                  repeatForever: true,
                  isRepeatingAnimation: true,
                  animatedTexts: [
                    WavyAnimatedText(
                      text,
                      textStyle:
                          Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.white,
                              ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
