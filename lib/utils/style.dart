import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

const fxPrimaryColor = Color(0xFF6C56F9);

InputDecoration inputDecoretionForm(
    {IconData? prefixIcon,
    String? hint,
    Color? bgColor,
    Color? borderColor,
    double? radius,
    EdgeInsets? padding}) {
  return InputDecoration(
    contentPadding:
        padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    counter: const Offstage(),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: borderColor ?? fxPrimaryColor)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 16)),
      borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
    ),
    fillColor: bgColor ?? fxPrimaryColor.withOpacity(0.04),
    hintText: hint,
    prefixIcon:
        prefixIcon != null ? Icon(prefixIcon, color: fxPrimaryColor) : null,
    hintStyle: secondaryTextStyle(),
    filled: true,
  );
}


Widget textFormAuth({
  required String labelText,
  required String hintText,
  required IconData icon,
  required TextEditingController controller,
  bool obscureText = false,
}) {
  return Container(
    margin: EdgeInsets.only(left: 8, right: 8),
    padding: EdgeInsets.all(5),
    child: TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: inputDecoretionForm(
        hint: hintText,
        prefixIcon: icon,
        radius: 8,
      ),
    ),
  );
}

Widget passwordFormAuth({
  required String labelText,
  required String hintText,
  required bool isPasswordVisible,
  required TextEditingController controller,
  required VoidCallback onVisibilityToggle,
}) {
  return Container(
    margin: EdgeInsets.only(left: 8, right: 8),
    padding: EdgeInsets.all(5),
    child: TextField(
      controller: controller,
      obscureText: !isPasswordVisible,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        hintText: hintText,
        prefixIcon: const Icon(Icons.lock, color: fxPrimaryColor),
        suffixIcon: IconButton(
          icon: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: fxPrimaryColor,
          ),
          onPressed: onVisibilityToggle,
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: fxPrimaryColor)),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
        ),
        fillColor: fxPrimaryColor.withOpacity(0.04),
        hintStyle: secondaryTextStyle(),
        filled: true,
      ),
    ),
  );
}