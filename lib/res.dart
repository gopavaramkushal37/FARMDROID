import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'database.dart'; // Import DatabaseHelper
import 'globals.dart';

class PincodeFilteredDisplayPage extends StatefulWidget {
  final String selectedEntity;

  PincodeFilteredDisplayPage(this.selectedEntity);

  @override
  _PincodeFilteredDisplayPageState createState() =>
      _PincodeFilteredDisplayPageState();
}

class _PincodeFilteredDisplayPageState
    extends State<PincodeFilteredDisplayPage> {
  late Database database;
  List<Map<String, dynamic>> resources = [];

  @override
  void initState() {
    super.initState();
    openDatabaseAndFetchData();
  }

  Future<void> openDatabaseAndFetchData() async {
    database = await DatabaseHelper.instance.database;
    resources = await database.query('resources');

    // Filter resources based on matching entity and pincode
    resources = resources
        .where((resource) =>
    resource['entity'] == widget.selectedEntity &&
        resource['pincode'] == loggedInPincode) // Check entity and pincode match
        .toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.selectedEntity}'),
      ),
      body: ListView.builder(
        itemCount: resources.length,
        itemBuilder: (context, index) {
          final resource = resources[index];
          return Card(
            margin: EdgeInsets.all(10),
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('Name: ${resource['name']}'),
                  subtitle: Text('Mobile: ${resource['mobile']}'),
                  trailing: Text('Price: ${resource['price']}'),
                ),
                SizedBox(height: 8), // Add spacing between cards
              ],
            ),
          );
        },
      ),
    );
  }
}
