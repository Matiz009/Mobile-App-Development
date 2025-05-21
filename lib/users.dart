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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            theme.appBarTheme.backgroundColor ?? theme.primaryColor,
        title: Text(
          'Count: ${widget.count}',
          style: TextStyle(
            fontSize: 30,
            color: theme.appBarTheme.foregroundColor ?? Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Welcome to the Users screen!',
          style: theme.textTheme.headlineSmall,
        ),
      ),
    );
  }
}
