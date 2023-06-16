import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aplikacja_3/models/person.dart';

class LocalStorage {
  static const String personsKey = 'persons';

  Future<void> savePersons(List<Person> persons) async {
    final prefs = await SharedPreferences.getInstance();
    final personsJson = persons.map((person) => jsonEncode(person.toJson())).toList();
    await prefs.setStringList(personsKey, personsJson);
  }

  Future<List<Person>> getPersons() async {
    final prefs = await SharedPreferences.getInstance();
    final personsJson = prefs.getStringList(personsKey) ?? [];
    return personsJson.map((json) => Person.fromJson(jsonDecode(json))).toList();
  }
}
