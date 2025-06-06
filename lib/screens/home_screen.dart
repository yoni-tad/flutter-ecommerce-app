import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:ecommerce/provider/cart_provider.dart';
import 'package:ecommerce/provider/items_provider.dart';
import 'package:ecommerce/provider/theme_provider.dart';
import 'package:ecommerce/screens/cart_screen.dart';
import 'package:ecommerce/screens/filter_screen.dart';
import 'package:ecommerce/screens/product_screen.dart';
import 'package:ecommerce/widgets/item_card.dart';
import 'package:ecommerce/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final itemsProvider = Provider.of<ItemsProvider>(context);
    final items = itemsProvider.items;
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 160.h,
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.sp),
                    bottomRight: Radius.circular(10.sp),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    vertical: 25.h,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Location',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.place,
                                    color: theme.textTheme.bodyLarge?.color,
                                  ),
                                  SizedBox(width: 3.w),
                                  Text(
                                    'Addis Ababa, Ethiopia',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              themeProvider.toggleTheme();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: theme.scaffoldBackgroundColor
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.h),
                                child: Icon(
                                  themeProvider.isDark
                                      ? Icons.light_mode
                                      : Icons.dark_mode,
                                  color: theme.textTheme.bodyLarge?.color,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: theme.scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(5.sp),
                              ),
                              child: TextField(
                                controller: _search,
                                onChanged:
                                    (value) => {
                                      if (value.isNotEmpty)
                                        {itemsProvider.search(value)}
                                      else
                                        {itemsProvider.clearSearch()},
                                    },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.search),
                                  prefixIconColor: theme.primaryColor,
                                  hintText: 'Search',
                                  hintStyle: TextStyle(
                                    color: theme.textTheme.bodyLarge?.color,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15.w,
                                    vertical: 10.h,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          GestureDetector(
                            onTap: () {
                              if (!itemsProvider.isLoading) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FilterScreen(),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: theme.scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(5.sp),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10.h,
                                  horizontal: 10.w,
                                ),
                                child: Icon(
                                  Icons.tune,
                                  color: theme.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // products
              itemsProvider.isLoading
                  ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 10.h,
                    ),
                    child: LoadingWidget(),
                  )
                  : itemsProvider.error != null
                  ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 30.h),
                    child: Center(
                      child: Column(
                        children: [
                          Text('Fetch data failed, Please try again'),
                          GestureDetector(
                            onTap: () {
                              Provider.of<ItemsProvider>(
                                context,
                                listen: false,
                              ).loadItems();
                            },
                            child: Icon(Icons.refresh),
                          ),
                        ],
                      ),
                    ),
                  )
                  : items.length == 0
                  ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Center(
                      child: Text(
                        'No result found',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  )
                  : GridView.builder(
                    itemCount: items.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.w,
                      mainAxisSpacing: 5.h,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductScreen(id: item.id),
                            ),
                          );
                        },
                        child: ItemCard(item: item),
                      );
                    },
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
