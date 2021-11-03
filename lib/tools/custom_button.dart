import 'package:auto_size_text/auto_size_text.dart';
import 'package:ceo_transport/utilities/utilities.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({required this.onTap, required this.text, Key? key})
      : super(key: key);
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: Utilities.padding / 2),
        padding: EdgeInsets.symmetric(
          vertical: Utilities.padding / 2,
          horizontal: Utilities.padding * 3,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(Utilities.borderRadius),
        ),
        child: AutoSizeText(
          text,
          maxFontSize: 20,
          style: const TextStyle(
            color: Colors.black,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
