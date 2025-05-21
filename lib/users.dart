import 'package:flutter/material.dart';

class Users extends StatefulWidget {
  final int count;
  Users({super.key, required this.count});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text(
          'Count: ${widget.count}',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        centerTitle: true,
      ),
    );
  }
}
