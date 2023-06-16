import 'package:flutter/material.dart';
import 'package:aplikacja_3/screens/components/person_list.dart';
import 'package:aplikacja_3/screens/widgets/download_button.dart';
import 'package:aplikacja_3/screens/widgets/switch_button.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isOfflineMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Person App'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              DownloadButton(),
              SizedBox(width: 16),
              Expanded(child: TextField(decoration: InputDecoration(hintText: 'Number of users'))),
              SizedBox(width: 16),
              SwitchButton(
                value: isOfflineMode,
                onChanged: (value) {
                  setState(() {
                    isOfflineMode = value;
                  });
                },
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  // Save locally
                },
                child: Text('SAVE LOCALLY'),
              ),
            ],
          ),
          Expanded(
            child: PersonList(isOfflineMode: isOfflineMode),
          ),
        ],
      ),
    );
  }
}
