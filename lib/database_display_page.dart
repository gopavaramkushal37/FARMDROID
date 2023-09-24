import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'database.dart';
import 'globals.dart';

class DatabaseDisplayPage extends StatefulWidget {
  @override
  _DatabaseDisplayPageState createState() => _DatabaseDisplayPageState();
}

class _DatabaseDisplayPageState extends State<DatabaseDisplayPage> {
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

    // Filter resources based on global values
    resources = resources
        .where((resource) =>
    resource['name'] == loggedInUserName &&
        resource['mobile'] == loggedInMobile &&
        resource['pincode'] == loggedInPincode)
        .toList();

    setState(() {});
  }

  Future<void> deleteResource(int id) async {
    await database.delete(
      'resources',
      where: 'id = ?',
      whereArgs: [id],
    );
    openDatabaseAndFetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database Display'),
      ),
      body: ListView.builder(
        itemCount: resources.length,
        itemBuilder: (context, index) {
          final resource = resources[index];
          return ListTile(
            title: Text('Name: ${resource['name']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Entity: ${resource['entity']}'),
                Text('Mobile: ${resource['mobile']}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    deleteResource(resource['id']);
                  },
                ),
                Text('Price: ${resource['price']}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
