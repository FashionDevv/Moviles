// LoginInput.dart
import 'package:flutter/material.dart';

class LoginInput extends StatelessWidget {
  final String label;
  final String hintText;
  final bool obscure;
  final TextEditingController? controller;

  const LoginInput({
    super.key,
    required this.label,
    required this.hintText,
    this.obscure = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF18181B),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFC59B2D),
            offset: Offset(0, 2),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color.fromARGB(199, 255, 255, 255),
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 26,
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFFC59B2D),
                  offset: Offset(0, 2),
                  blurRadius: 3,
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              obscureText: obscure,
              style: const TextStyle(color: Colors.white, fontSize: 13),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(color: Color(0xFFC59B2D), fontSize: 12.5),
                contentPadding: const EdgeInsets.only(left: 10, bottom: 17),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
