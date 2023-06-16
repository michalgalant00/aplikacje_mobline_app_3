import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:aplikacja_3/classes/person.dart';

class NetworkService {
  Future<Person> fetchData() async {
    final response = await http.get(Uri.https('randomuser.me', '/api'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final results = jsonData['results'][0];
      final name = results['name']['first'] + ' ' + results['name']['last'];
      final city = results['location']['city'];
      final phoneNumber = results['phone'];
      final avatarImage = results['picture']['large'];

      return Person(
        name: name,
        city: city,
        phoneNumber: phoneNumber,
        avatarImage: avatarImage,
      );
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
