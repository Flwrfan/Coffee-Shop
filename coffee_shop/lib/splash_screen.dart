import 'package:coffee_shop/login.dart';
import 'package:flutter/material.dart';
import 'package:coffee_shop/home_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen Example',
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Simulate a loading delay (you can replace this with actual loading logic)
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'images/start.jpg',
                // Replac=  width: double.infinity, // Adjust the width as needed
                // height: double.infinity, // Adjust the height as needed
              ),
              fit: BoxFit.cover)),
    ));
  }
}
