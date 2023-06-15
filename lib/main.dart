import 'package:flutter/material.dart';

import 'package:aplikacja_3/classes/person.dart';
import 'package:aplikacja_3/services/network.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Person',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RandomPersonPage(),
    );
  }
}

class RandomPersonPage extends StatefulWidget {
  @override
  _RandomPersonPageState createState() => _RandomPersonPageState();
}

class _RandomPersonPageState extends State<RandomPersonPage> {
  Person? randomPerson;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchRandomPerson();
  }

  Future<void> fetchRandomPerson() async {
    setState(() {
      isLoading = true;
    });

    try {
      final networkService = NetworkService();
      final person = await networkService.fetchRandomPerson();
      setState(() {
        randomPerson = person;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to fetch random person.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Person'),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : randomPerson != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(randomPerson!.avatarImage),
              radius: 50,
            ),
            SizedBox(height: 16),
            Text(
              randomPerson!.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'City: ${randomPerson!.city}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Phone: ${randomPerson!.phoneNumber}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        )
            : Text('No data available.'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchRandomPerson,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
