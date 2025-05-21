import 'package:appone/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      ); // Prints after 1 second.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: Color(0xFF363567)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Center(
              child: CircleAvatar(
                backgroundColor: Colors.black,
                radius: 120,
                child: CircleAvatar(
                  radius: 110,
                  backgroundImage: AssetImage('assets/image.jpg'),
                ),
              ),
            ),
            SizedBox(height: 50),
            Text(
              'Welcome',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Britanic Bold',
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 100),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
