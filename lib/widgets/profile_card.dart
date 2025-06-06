import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileCard extends StatelessWidget {
  final IconData prefIcon;
  final String title;

  const ProfileCard({super.key, required this.prefIcon, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: theme.primaryColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(prefIcon, color: theme.primaryColor, size: 30.h),
                  SizedBox(width: 10.w),
                  Text(title),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: theme.primaryColor,
                size: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
