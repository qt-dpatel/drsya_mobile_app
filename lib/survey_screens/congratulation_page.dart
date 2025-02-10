import 'package:drsya_mobile_app/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class CongratulationsPage extends StatefulWidget {
  const CongratulationsPage({super.key});

  @override
  State<CongratulationsPage> createState() => _CongratulationPageState();
}

class _CongratulationPageState extends State<CongratulationsPage> {
  int _countdown = 3;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _timer?.cancel();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Your Survey is Submitted!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Your response helps us create better experiences!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Image.asset(
              'assets/congrats.png', // Replace with actual asset
              fit: BoxFit.cover, // Ensures it covers the entire container
            ),
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color:
                    Color.fromRGBO(252, 244, 237, 1), // rgba(252, 244, 237, 1)
                borderRadius: BorderRadius.circular(12), // Radius of 12
              ),
              child: Column(
                children: [
                  Text(
                    'Holiday Trends 2025',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(243, 111, 52, 1)),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Completed in 7m 55s',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Submitted on Jan 23, 2025',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Redirecting to Home in $_countdown seconds',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
