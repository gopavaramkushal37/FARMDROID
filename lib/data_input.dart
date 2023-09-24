import 'package:flutter/material.dart';
import 'globals.dart'; // Import global variables
import 'database.dart'; // Import DatabaseHelper
import 'database_display_page.dart'; // Import DatabaseDisplayPage

class DataInputPage extends StatelessWidget {
  final String buttonText;

  DataInputPage(this.buttonText);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Button Text: $buttonText',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            DataInputForm(entity: buttonText), // Pass buttonText here
          ],
        ),
      ),
    );
  }
}

class DataInputForm extends StatefulWidget {
  final String entity; // Add this variable

  DataInputForm({required this.entity}); // Update the constructor

  @override
  _DataInputFormState createState() => _DataInputFormState();
}

class _DataInputFormState extends State<DataInputForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: TextEditingController(text: loggedInUserName),
            decoration: InputDecoration(labelText: 'Name'),
            enabled: false,
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: TextEditingController(text: loggedInMobile),
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(labelText: 'Mobile Number'),
            enabled: false,
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Price'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a price';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid price';
              }
              return null;
            },
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await DatabaseHelper.instance.insertData(
                  loggedInUserName,
                  loggedInMobile,
                  double.parse(priceController.text),
                  widget.entity,
                  loggedInPincode,
                );
                priceController.clear();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Data submitted successfully')),
                );
              }
            },
            child: Text('Submit'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DatabaseDisplayPage(),
                ),
              );
            },
            child: Text('My Resources'),
          ),
        ],
      ),
    );
  }
}
