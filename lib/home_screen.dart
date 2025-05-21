import 'package:appone/themeProvider.dart';
import 'package:appone/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  String randomString;
  HomeScreen({super.key, required this.randomString});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int count = 0;
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor:
            theme.appBarTheme.backgroundColor ?? theme.primaryColor,
        title: Text(
          'Counter App ${widget.randomString}',
          style: textTheme.titleLarge?.copyWith(
            color: theme.appBarTheme.foregroundColor ?? Colors.white,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        actions: [
          Switch(
            value: themeProvider.isDarkMode,
            onChanged: themeProvider.toggleTheme,
            activeColor: Colors.white,
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text('Count: $count', style: textTheme.titleLarge),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: increment,
                    icon: Icon(Icons.add, color: theme.iconTheme.color),
                    iconSize: 28,
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    onPressed: decrement,
                    icon: Icon(Icons.remove, color: theme.iconTheme.color),
                    iconSize: 28,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                style: textTheme.bodyLarge,
                decoration: InputDecoration(
                  labelText: 'Enter your name',
                  hintText: 'Name',
                  border: const OutlineInputBorder(),
                  labelStyle: TextStyle(color: theme.hintColor),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                style: textTheme.bodyLarge,
                decoration: InputDecoration(
                  labelText: 'Enter your age',
                  hintText: 'Age',
                  border: const OutlineInputBorder(),
                  labelStyle: TextStyle(color: theme.hintColor),
                ),
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => Users(count: count),
                    ),
                  );
                },
                child: Text(
                  'Go to Users',
                  style: textTheme.labelLarge?.copyWith(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
