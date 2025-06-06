import 'package:cached_network_image/cached_network_image.dart';
import 'package:chapasdk/features/native-checkout/bloc/chapa_native_checkout_bloc.dart';
import 'package:chapasdk/features/native-checkout/chapa_native_payment.dart';
import 'package:ecommerce/provider/cart_provider.dart';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:ecommerce/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CartProvider>(context, listen: false).getItems();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final items = cartProvider.cart;

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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DrawerWidget(),
                            ),
                          );
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
                        'My Cart',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          cartProvider.cleanItems();
                          toastification.show(
                            style: ToastificationStyle.fillColored,
                            context: context,
                            title: Text("Cart cleared"),
                            autoCloseDuration: Duration(seconds: 5),
                          );
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
                              Icons.delete,
                              color: theme.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              items.length == 0
                  ? Center(
                    child: Text(
                      'Cart is empty',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                  )
                  : Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: item.image,
                                  placeholder:
                                      (context, url) => Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                  errorWidget:
                                      (context, url, error) =>
                                          Icon(Icons.error),
                                  width: 100.w,
                                  height: 50.h,
                                ),
                                SizedBox(width: 5.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        items[index].title,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                      Text(
                                        items[index].category,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 3.h),
                                      Text(
                                        '\$${items[index].price.toString()}',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
              Column(
                children: [
                  cartProvider.totalPrice > 0
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tax',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '\$15.00',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )
                      : SizedBox(),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '\$${cartProvider.totalPrice > 0 ? (cartProvider.totalPrice + 15).toStringAsFixed(2) : 0}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => ChapaNativePayment(
                                amount: '100.00',
                                currency: 'USD',
                                email: 'customer@example.com',
                                firstName: 'John',
                                lastName: 'Doe',
                                txRef:
                                    'TX-${DateTime.now().millisecondsSinceEpoch}',
                                title: 'Ecommerce Checkout',
                                context: context,
                                desc: 'Payment for items in cart',
                                phone: '0900123456',
                                publicKey:
                                    'CHAPUBK_TEST-cpUaKk9QLa2XYIc0uALJPyO7KdnD1nyd',
                                onPaymentFinished:
                                    (p0, p1, p2) => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomeScreen(),
                                        ),
                                      ),
                                    },
                                namedRouteFallBack: '',
                              ),
                        ),
                      );
                    },
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
                                'Checkout',
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
            ],
          ),
        ),
      ),
    );
  }
}
