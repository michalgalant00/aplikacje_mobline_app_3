import 'package:flutter/material.dart';
import 'package:aplikacja_3/models/person.dart';

class PersonItem extends StatelessWidget {
  final Person person;

  const PersonItem({
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
    );
  }
}
