import 'package:aplikacja_3/screens/components/person_item.dart';
import 'package:flutter/material.dart';
import 'package:aplikacja_3/models/person.dart';
import 'package:aplikacja_3/services/network_service.dart';
import 'package:aplikacja_3/services/local_storage.dart';

class PersonList extends StatelessWidget {
  final bool isOfflineMode;

  const PersonList({super.key,
    required this.isOfflineMode,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Person>>(
      future: isOfflineMode ? LocalStorage().getPersons() : NetworkService().fetchData(10),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.hasData) {
          final List<Person> persons = snapshot.data!;
          return ListView.builder(
            itemCount: persons.length,
            itemBuilder: (context, index) {
              return PersonItem(person: persons[index]);
            },
          );
        }

        return const Center(child: Text('No data available'));
      },
    );
  }
}
