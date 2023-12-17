import 'package:coffee_shop/home_screen.dart';
import 'package:coffee_shop/product_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:coffee_shop/favorite_coffee_list.dart';
import 'package:coffee_shop/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDvs2Q0bYqgnBAJe_wPrnqRGGLt2KHqS5w",
      appId: "1:962532402148:android:ee59c2492127a8fc171df1",
      messagingSenderId: "your_messaging_sender_id",
      projectId: "coffee-shop-6b6ff",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SplashScreen(),
    );
  }
}
