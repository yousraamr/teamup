import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.isTransparent = false,
    required this.text,
    this.onPressed,
    required this.isLarge,
  });

  final bool isTransparent;
  final bool isLarge;
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: isLarge ? double.infinity : 160,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isTransparent ? Colors.transparent : primary,
          shadowColor: Colors.transparent,
          foregroundColor: primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: isTransparent
                ? BorderSide(color: primary, width: 2) // border only for transparent
                : BorderSide.none,
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: h2.copyWith(
            color: isTransparent ? primary : Colors.white, // 👈 key change
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}