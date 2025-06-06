import 'package:ecommerce/screens/signin_screen.dart';
import 'package:ecommerce/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = AuthService();

  void logout() {
    _auth.signout();
    toastification.show(
      context: context,
      style: ToastificationStyle.fillColored,
      title: Text('Good bye!'),
      autoCloseDuration: Duration(seconds: 5),
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SigninScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(onTap: () => logout(), child: Text('Logout')),
      ),
    );
  }
}
