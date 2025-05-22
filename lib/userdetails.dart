import 'package:flutter/material.dart';
import 'package:appone/model.dart';

class UserDetailPage extends StatelessWidget {
  final UsersModel user;

  const UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        backgroundColor: theme.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _infoTile('Username', '@${user.username}'),
            _infoTile('Email', user.email),
            _infoTile('Phone', user.phone),
            _infoTile('Website', user.website),
            const SizedBox(height: 16),
            Text('Address', style: theme.textTheme.titleMedium),
            _infoTile('Street', user.address.street),
            _infoTile('Suite', user.address.suite),
            _infoTile('City', user.address.city),
            _infoTile('Zipcode', user.address.zipcode),
            _infoTile(
              'Geo',
              'Lat: ${user.address.geo.lat}, Lng: ${user.address.geo.lng}',
            ),
            const SizedBox(height: 16),
            Text('Company', style: theme.textTheme.titleMedium),
            _infoTile('Name', user.company.name),
            _infoTile('Catch Phrase', user.company.catchPhrase),
            _infoTile('BS', user.company.bs),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$title: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
