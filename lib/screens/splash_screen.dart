import 'package:ecommerce/provider/cart_provider.dart';
import 'package:ecommerce/provider/items_provider.dart';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:ecommerce/screens/signin_screen.dart';
import 'package:ecommerce/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final status = Supabase.instance.client.auth.currentSession;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        Provider.of<ItemsProvider>(context, listen: false).loadItems();
        Provider.of<CartProvider>(context, listen: false).getItems();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => status != null ? DrawerWidget() : SigninScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: theme.primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15.h),
                  child: Icon(
                    Icons.shopping_cart_checkout,
                    size: 30.h,
                    color: theme.primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'eCommerce App',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: theme.scaffoldBackgroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
