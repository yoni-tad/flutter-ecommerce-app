// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterBoxCard extends StatelessWidget {
  final bool isSelected;
  final String title;

  const FilterBoxCard({Key? key, required this.isSelected, required this.title})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color:
            isSelected
                ? theme.primaryColor.withOpacity(0.7)
                : theme.textTheme.bodyLarge?.color!.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 25.w),
        child: Text(
          title,
          style: TextStyle(
            color:
                isSelected
                    ? theme.scaffoldBackgroundColor
                    : theme.textTheme.bodyLarge?.color,
          ),
        ),
      ),
    );
  }
}
