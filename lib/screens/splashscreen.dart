import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qrcodeapp/screens/home.dart'; 
import 'dart:async';
class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a time-consuming operation such as loading data
    Timer(const Duration(seconds: 4), () {
      // Navigate to the next screen after 4 seconds
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: Center(
          
      child: Lottie.network(
  'https://lottie.host/1768928d-6082-4cb9-ac0b-0e7747b1d23b/3eU34DrFYC.json',
  errorBuilder: (context, error, stackTrace) {
    print('Error loading animation: $error');
    return const Text('Error loading animation');
  },
)
)

      

          
    );
  }
}