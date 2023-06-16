import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aplikacja_3/models/person.dart';
import 'package:aplikacja_3/utils/api_response.dart';

class NetworkService {
  static const String apiUrl = 'https://randomuser.me/api';

  Future<ApiResponse<List<Person>>> fetchData(int count) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/?results=$count'));
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final List<Person> persons = [];

        for (var personJson in data['results']) {
          final person = Person(
            fullName: personJson['name']['first'] + ' ' + personJson['name']['last'],
            city: personJson['location']['city'],
            phoneNumber: personJson['phone'],
            avatarImage: personJson['picture']['large'],
          );
          persons.add(person);
        }

        return ApiResponse(data: persons);
      } else {
        return ApiResponse(error: 'Failed to fetch data');
      }
    } catch (error) {
      return ApiResponse(error: 'Network error');
    }
  }
}
