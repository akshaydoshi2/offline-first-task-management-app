import 'package:flutter/material.dart';
import 'package:tushop_assesment/src/utilities/app_colors.dart';

class AppTextField extends StatelessWidget {
  final String? hint;
  final bool readOnly;
  final bool? enabled;
  final Widget? suffix;
  final VoidCallback? onTap;
  final String? initialValue;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  const AppTextField({super.key, this.controller, this.hint, this.suffix, this.enabled, this.onTap, this.initialValue, this.onChanged, this.validator, this.readOnly = false,});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      initialValue: initialValue,
      onChanged: onChanged,
      readOnly: readOnly,
      cursorColor: AppColors.primary,
      onTap: onTap,
      decoration: InputDecoration(
        suffixIcon: suffix,
        hintText: hint,
      )
    );
  }
}
