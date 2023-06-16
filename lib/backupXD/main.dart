import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:aplikacja_3/classes/person.dart';
import 'package:aplikacja_3/services/network.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Person> people = [];
  bool isOfflineMode = false;

  @override
  void initState() {
    super.initState();
    fetchPeopleData();
  }

  Future<void> fetchPeopleData() async {
    if (isOfflineMode) {
      await readPeopleDataFromLocalFile();
    } else {
      final networkService = NetworkService();
      final person = await networkService.fetchData();
      setState(() {
        people.add(person);
      });
      writePeopleDataToLocalFile();
    }
  }

  Future<void> readPeopleDataFromLocalFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/people_data.json');
      final jsonData = await file.readAsString();
      final decodedData = jsonDecode(jsonData);
      final List<Person> loadedPeople = [];

      for (final item in decodedData) {
        final person = Person(
          name: item['name'],
          city: item['city'],
          phoneNumber: item['phoneNumber'],
          avatarImage: item['avatarImage'],
        );
        loadedPeople.add(person);
      }

      setState(() {
        people = loadedPeople;
      });
    } catch (e) {
      print('Error reading local data: $e');
    }
  }

  Future<void> writePeopleDataToLocalFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/people_data.json');
      final encodedData = jsonEncode(people);
      await file.writeAsString(encodedData);
    } catch (e) {
      print('Error writing local data: $e');
    }
  }

  void toggleOfflineMode() {
    setState(() {
      isOfflineMode = !isOfflineMode;
      if (!isOfflineMode) {
        fetchPeopleData();
      }
    });
  }

  void refreshData() {
    setState(() {
      people = [];
      fetchPeopleData();
    });
  }

  void addPerson(Person person) {
    setState(() {
      people.add(person);
      writePeopleDataToLocalFile();
    });
  }

  void editPerson(Person person, int index) {
    setState(() {
      people[index] = person;
      writePeopleDataToLocalFile();
    });
  }

  void deletePerson(int index) {
    setState(() {
      people.removeAt(index);
      writePeopleDataToLocalFile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Person App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Person App'),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Offline Mode'),
                Switch(
                  value: isOfflineMode,
                  onChanged: (value) {
                    toggleOfflineMode();
                  },
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: people.length,
                itemBuilder: (BuildContext context, int index) {
                  final person = people[index];
                  return ListTile(
                    leading: Image.network(person.avatarImage),
                    title: Text(person.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(person.city),
                        Text(person.phoneNumber),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        deletePerson(index);
                      },
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return EditPersonDialog(
                            person: person,
                            editPerson: (editedPerson) {
                              editPerson(editedPerson, index);
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AddPersonDialog(
                  addPerson: addPerson,
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class AddPersonDialog extends StatefulWidget {
  final Function addPerson;

  AddPersonDialog({required this.addPerson});

  @override
  _AddPersonDialogState createState() => _AddPersonDialogState();
}

class _AddPersonDialogState extends State<AddPersonDialog> {
  final _nameController = TextEditingController();
  final _cityController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _cityController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void submitForm() {
    final name = _nameController.text;
    final city = _cityController.text;
    final phoneNumber = _phoneNumberController.text;
    final avatarImage = ''; // Set the avatar image here

    if (name.isNotEmpty && city.isNotEmpty && phoneNumber.isNotEmpty) {
      final newPerson = Person(
        name: name,
        city: city,
        phoneNumber: phoneNumber,
        avatarImage: avatarImage,
      );
      widget.addPerson(newPerson);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Person'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _cityController,
            decoration: InputDecoration(labelText: 'City'),
          ),
          TextField(
            controller: _phoneNumberController,
            decoration: InputDecoration(labelText: 'Phone Number'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            submitForm();
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}

class EditPersonDialog extends StatefulWidget {
  final Person person;
  final Function editPerson;

  EditPersonDialog({required this.person, required this.editPerson});

  @override
  _EditPersonDialogState createState() => _EditPersonDialogState();
}

class _EditPersonDialogState extends State<EditPersonDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _cityController;
  late final TextEditingController _phoneNumberController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.person.name);
    _cityController = TextEditingController(text: widget.person.city);
    _phoneNumberController =
        TextEditingController(text: widget.person.phoneNumber);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cityController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void submitForm() {
    final name = _nameController.text;
    final city = _cityController.text;
    final phoneNumber = _phoneNumberController.text;

    if (name.isNotEmpty && city.isNotEmpty && phoneNumber.isNotEmpty) {
      final editedPerson = Person(
        name: name,
        city: city,
        phoneNumber: phoneNumber,
        avatarImage: widget.person.avatarImage,
      );
      widget.editPerson(editedPerson);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Person'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _cityController,
            decoration: InputDecoration(labelText: 'City'),
          ),
          TextField(
            controller: _phoneNumberController,
            decoration: InputDecoration(labelText: 'Phone Number'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            submitForm();
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
