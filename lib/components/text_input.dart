import 'package:flutter/material.dart';
import 'package:google_maps/colors.dart';

InputBorder _buildInputBorder(Color color, BorderRadius borderRadius) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: color),
    borderRadius: borderRadius,
  );
}

class TextInput<T> extends StatelessWidget {
  final Function(String) validator;
  final String? hintText;
  final TextEditingController controller;
  final int? size;

  const TextInput(
      {super.key,
      required this.controller,
      this.hintText,
      required this.validator,
      this.size});

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(8.0);
    return TextFormField(
      controller: controller,
      validator: (value) => validator(value!),
      maxLines: size ?? 2,
      style: Theme.of(context).textTheme.bodySmall,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodySmall,
          enabledBorder:
              _buildInputBorder(AppColors.backgroundSecondary, borderRadius),
          focusedBorder: _buildInputBorder(AppColors.textPrimary, borderRadius),
          errorBorder: _buildInputBorder(AppColors.red, borderRadius),
          focusedErrorBorder: _buildInputBorder(AppColors.red, borderRadius),
          errorStyle: const TextStyle(color: AppColors.red, fontSize: 12)),
    );
  }
}
