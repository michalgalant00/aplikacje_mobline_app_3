import 'package:flutter/material.dart';
import 'package:aplikacja_3/services/network_service.dart';

class DownloadButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Fetch data from the network
        NetworkService().fetchData(10).then((response) {
          if (response.data != null) {
            // Handle the fetched data
          } else {
            // Handle the error
          }
        });
      },
      child: Text('Download'),
    );
  }
}
