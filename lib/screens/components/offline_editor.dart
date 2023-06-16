import 'package:aplikacja_3/models/person.dart';
import 'package:flutter/material.dart';

class OfflineEditor extends StatelessWidget {
  final Person person;

  const OfflineEditor({
    required this.person,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(person.avatarImage),
      ),
      title: Text(person.fullName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(person.city),
          Text(person.phoneNumber),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              // Edit locally
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              // Delete locally
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
