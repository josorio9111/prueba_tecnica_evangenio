import 'package:flutter/material.dart';

class FieldText extends StatelessWidget {
  final bool obscureText;
  final IconData icon;
  final TextInputAction textInputAction;
  final Function(String)? onChanged;
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onSubmitted;
  final TextInputType? keyboardType;
  const FieldText({
    super.key,
    this.obscureText = false,
    required this.icon,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
    required this.hintText,
    this.controller,
    this.onSubmitted,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.white),
      child: TextField(
        controller: controller,
        autocorrect: false,
        onChanged: onChanged,
        onSubmitted: (_) => onSubmitted,
        keyboardType: keyboardType,
        obscureText: obscureText,
        textInputAction: textInputAction,
        style: TextStyle(color: Colors.grey[600]),
        decoration: InputDecoration(
          icon: Icon(icon),
          hintText: hintText,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
