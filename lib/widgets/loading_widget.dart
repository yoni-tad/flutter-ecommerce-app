import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Shimmer.fromColors(
      baseColor: theme.primaryColor.withOpacity(0.2),
      highlightColor: theme.primaryColor.withOpacity(0.1),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 8,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5.w,
          mainAxisSpacing: 5.h,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(8.w),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  height: 120.h,
                  width: double.infinity,
                ),
                SizedBox(height: 10.h),
                Container(
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  height: 15.h,
                  width: double.infinity,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
