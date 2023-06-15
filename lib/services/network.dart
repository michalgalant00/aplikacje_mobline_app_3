import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:aplikacja_3/classes/person.dart';

class NetworkService {
  Future<Person> fetchRandomPerson() async {
    final response = await http.get(Uri.parse('https://randomuser.me/api/'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final results = jsonData['results'];
      if (results != null && results.isNotEmpty) {
        final personData = results[0];
        return _convertToPerson(personData);
      }
    }
    throw Exception('Failed to fetch random person.');
  }

  Person _convertToPerson(Map<String, dynamic> personData) {
    final nameData = personData['name'];
    final name = '${nameData['first']} ${nameData['last']}';

    final city = personData['location']['city'];

    final phoneNumber = personData['phone'];

    final avatarImage = personData['picture']['large'];

    return Person(
      name: name,
      city: city,
      phoneNumber: phoneNumber,
      avatarImage: avatarImage,
    );
  }
}
