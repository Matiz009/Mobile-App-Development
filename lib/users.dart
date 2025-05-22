import 'package:appone/userdetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model.dart';

class Users extends StatefulWidget {
  final int count;
  const Users({super.key, required this.count});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  late Future<List<UsersModel>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers();
  }

  Future<List<UsersModel>> fetchUsers() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );

    if (response.statusCode == 200) {
      List<dynamic> users = jsonDecode(response.body);
      return users.map((user) => UsersModel.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

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
      body: FutureBuilder<List<UsersModel>>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final user = snapshot.data![index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailPage(user: user),
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.name, style: theme.textTheme.titleLarge),
                        const SizedBox(height: 5),
                        Text(
                          '@${user.username}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const Divider(height: 20),
                        Text('Email: ${user.email}'),
                        Text('Phone: ${user.phone}'),
                        Text('Website: ${user.website}'),
                        const SizedBox(height: 10),
                        Text('Company: ${user.company.name}'),
                        Text('CatchPhrase: "${user.company.catchPhrase}"'),
                        const SizedBox(height: 5),
                        Text(
                          'Address: ${user.address.street}, ${user.address.city}',
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
