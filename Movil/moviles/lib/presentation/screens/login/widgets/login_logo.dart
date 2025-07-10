import 'package:flutter/material.dart';

class LoginLogo extends StatelessWidget {
  const LoginLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
  radius: 36,
  backgroundColor: Color(0xFFC59B2D),
  child: ClipOval(
    child: Image.asset(
      'assets/images/lo.jpg',
      width: 70,
      height: 70,
      fit: BoxFit.cover,
    ),
  ),
)
;
  }
}
