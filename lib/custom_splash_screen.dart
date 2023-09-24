import 'package:flutter/material.dart';
import 'LoginPage.dart'; // Update this import to match your file structure

class CustomSplashScreen extends StatefulWidget {
  @override
  _CustomSplashScreenState createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add a delay to simulate a splash screen
    Future.delayed(Duration(seconds: 3), () {
      // Navigate to the login page after the delay
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Your Splash Screen Content'),
      ),
    );
  }
}
