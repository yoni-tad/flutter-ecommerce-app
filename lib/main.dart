import 'package:ecommerce/provider/cart_provider.dart';
import 'package:ecommerce/provider/items_provider.dart';
import 'package:ecommerce/provider/theme_provider.dart';
import 'package:ecommerce/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://wbdlpfxoqrvuqqebgbqx.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndiZGxwZnhvcXJ2dXFxZWJnYnF4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDkyMTQ1MTIsImV4cCI6MjA2NDc5MDUxMn0.kG6HtZ8_d5f00iGNbIk6hm5A3-0PXi6eR4egwfzm5vY',
  );

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xffFF4747),
      statusBarColor: Color(0xffFF4747),
    ),
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemsProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],

      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          final theme = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'eCommerce App',
            theme: theme.themeData,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
