import 'package:ecommerce/provider/items_provider.dart';
import 'package:ecommerce/widgets/filter_box_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String categoryFilter = '';
  int ratingFilter = -1;
  double priceStartFilter = 100.0;
  double priceEndFilter = 300.0;

  void filter() async {
    final itemsProvider = Provider.of<ItemsProvider>(context, listen: false);
    itemsProvider.clearSearch();
    if (categoryFilter.isNotEmpty) {
      await itemsProvider.categoryFilter(categoryFilter);
    }

    if (ratingFilter > 0) {
      await itemsProvider.ratingFilter(ratingFilter);
    }

    if (priceStartFilter >= 0 && priceEndFilter <= 1000) {
      await itemsProvider.priceFilter(
        priceStartFilter.toInt(),
        priceEndFilter.toInt(),
      );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final itemsProvider = Provider.of<ItemsProvider>(context);
    final items = itemsProvider.allItems;

    final Set<String> _categories = {};
    for (var item in items) {
      if (item.category.isNotEmpty) {
        _categories.add(item.category.toString());
      }
    }
    final categories = _categories.toList();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.textTheme.bodyLarge?.color!
                                .withOpacity(0.05),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.h),
                            child: Icon(
                              Icons.arrow_back,
                              color: theme.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Filter',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          itemsProvider.clearSearch();
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.textTheme.bodyLarge?.color!
                                .withOpacity(0.05),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.h),
                            child: Icon(Icons.clear, color: theme.primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 25.h),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Category',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          SizedBox(
                            height: 35.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                final category = categories[index];
                                return Padding(
                                  padding: EdgeInsets.only(right: 8.w),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        categoryFilter = category;
                                      });
                                    },
                                    child: FilterBoxCard(
                                      isSelected:
                                          categoryFilter == category
                                              ? true
                                              : false,
                                      title: category,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rating',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          SizedBox(
                            height: 35.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(right: 8.w),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        ratingFilter = index + 1;
                                      });
                                    },
                                    child: FilterBoxCard(
                                      isSelected:
                                          ratingFilter == index + 1
                                              ? true
                                              : false,
                                      title: '${index + 1}',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Price range',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          RangeSlider(
                            values: RangeValues(
                              priceStartFilter,
                              priceEndFilter,
                            ),
                            activeColor: theme.primaryColor,
                            inactiveColor: theme.primaryColor.withOpacity(0.3),
                            labels: RangeLabels(
                              '\$${priceStartFilter.toStringAsFixed(2)}',
                              '\$${priceEndFilter.toStringAsFixed(2)}',
                            ),
                            min: 0,
                            max: 1000,
                            onChanged: (value) {
                              setState(() {
                                priceStartFilter = value.start;
                                priceEndFilter = value.end;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: () => filter(),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Apply',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: theme.textTheme.bodyLarge?.color,
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
