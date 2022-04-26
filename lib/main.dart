import 'package:e_shop_online/adminscreens/addproduct.dart';
import 'package:e_shop_online/screens/main_screen.dart';
import 'package:e_shop_online/screens/products/product_detail.dart';
import 'package:e_shop_online/screens/products/productscreen.dart';
import 'package:e_shop_online/utils/custom_color.dart';
import 'package:e_shop_online/profileinitepage.dart';
import 'package:e_shop_online/login_screen.dart';
import 'package:e_shop_online/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle
    (const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

       primaryColor: primaryColor,
        fontFamily: ' roboto-regular'
      ),
      home: SplashInitScreen(),
      routes: {
        SplashScreen.id:(context)=> SplashScreen(),
        LoginScreen.id:(context)=> LoginScreen(),
        ProfileInitPage.id:(context)=> ProfileInitPage(),
        MainPage.id:(context)=> MainPage(),
        AddProductPage.id:(context) => AddProductPage(),
        ProductScreen.id:(context) => ProductScreen(),
        ProductDetailPage.id:(context) => ProductDetailPage()
      },
    );
  }
}

