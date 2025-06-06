import 'package:ecommerce/screens/signin_screen.dart';
import 'package:ecommerce/service/auth_service.dart';
import 'package:ecommerce/widgets/drawer_widget.dart';
import 'package:ecommerce/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profile',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => logout(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.textTheme.bodyLarge?.color!.withOpacity(
                            0.05,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Icon(Icons.logout, color: theme.primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),

                CircleAvatar(
                  backgroundImage: AssetImage('assets/yoni.png'),
                  radius: 60.r,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.h),
                  child: Column(
                    children: [
                      ProfileCard(
                        prefIcon: Icons.account_circle_rounded,
                        title: 'Your Profile',
                      ),
                      ProfileCard(
                        prefIcon: Icons.account_circle_rounded,
                        title: 'Manage Address',
                      ),
                      ProfileCard(
                        prefIcon: Icons.wallet,
                        title: 'Payment Methods',
                      ),
                      ProfileCard(
                        prefIcon: Icons.delivery_dining,
                        title: 'My Orders',
                      ),
                      ProfileCard(prefIcon: Icons.settings, title: 'Settings'),
                      ProfileCard(
                        prefIcon: Icons.phone_callback_outlined,
                        title: 'Help Center',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
