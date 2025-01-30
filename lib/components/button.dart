import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  final bool isLoading;
  final Color backgroundColor;
  final double height;

  const Button({
    super.key,
    required this.onPress,
    required this.title,
    this.isLoading = false,
    required this.backgroundColor,
    this.height = 36.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: backgroundColor,
        ),
        onPressed: isLoading ? null : onPress,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                title,
                style: const TextStyle(fontSize: 24)
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }
}
