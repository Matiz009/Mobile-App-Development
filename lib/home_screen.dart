import 'package:appone/users.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  String randomString;
  HomeScreen({super.key, required this.randomString});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int count = 0;
  void increment() {
    setState(() {
      count++;
    });
  }

  void decrement() {
    setState(() {
      count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text(
          'Counter App ${widget.randomString}',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text('Count: $count', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: increment,
                  icon: Icon(Icons.add),
                  iconSize: 20,
                ),
                SizedBox(width: 20),
                IconButton(
                  onPressed: decrement,
                  icon: Icon(Icons.remove),
                  iconSize: 20,
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed('/users'),
              child: const Text('Go to Users', style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed:
                  () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => Users(count: count),
                    ),
                  ),
              child: Text('Go to Users', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
