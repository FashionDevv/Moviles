import 'package:flutter/material.dart';
import 'package:moviles/presentation/screens/refund/refund.dart';
import '../screens/login/login_screen.dart';
import '../screens/register/register_screen.dart';
import '../screens/forgot_password/forgot_password_screen.dart';
import '../screens/forgot_password_code/forgot_password_code_screen.dart';
import '../screens/reset_password/reset_password_screen.dart';
import '../screens/orders/orders_screen.dart';


class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String refund = '/ventas/devoluciones';
  static const String forgotPassword = '/forgot-password';
  static const String forgotPasswordCode = '/forgot-password-code';
  static const String resetPassword = '/reset-password';
  static const String orders = '/ventas/pedidos';
  static const String profile = '/perfil';
  static const String editProfile = '/perfil/editar';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const LoginScreen(),
      register: (context) => const RegisterScreen(),
      refund: (context) => const RefundsScreen(),
      forgotPassword: (context) => const ForgotPasswordScreen(),
      forgotPasswordCode: (context) => const ForgotPasswordCodeScreen(),
      resetPassword: (context) => const ResetPasswordScreen(),
      orders: (context) => const OrdersScreen(),
    };
  }
}
