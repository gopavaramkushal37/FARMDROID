import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Page2 extends StatelessWidget {
  final Map<String, String> governmentSchemes = {
    'Andhra Pradesh': 'https://www.apagrisnet.gov.in/',
    'Uttar Pradesh': 'http://upagriculture.com/',
    'Gujarat': 'https://ikhedut.gujarat.gov.in/',
    'Karnataka': 'https://raitamitra.karnataka.gov.in/',
    'Tamil Nadu': 'https://agritech.tnau.ac.in/ta/index_ta.html',
    // Add more states and links as needed
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Government Schemes'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select a State:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              hint: Text('Select a state'),
              onChanged: (String? selectedState) {
                if (selectedState != null) {
                  String? schemeUrl = governmentSchemes[selectedState];
                  if (schemeUrl != null) {
                    launch(schemeUrl);
                  }
                }
              },
              items: governmentSchemes.keys
                  .map<DropdownMenuItem<String>>(
                    (String state) => DropdownMenuItem<String>(
                  value: state,
                  child: Text(state),
                ),
              )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}