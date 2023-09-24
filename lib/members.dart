import 'package:flutter/material.dart';
import 'reg_data.dart'; // Import your database helper
import 'globals.dart'; // Import your global variables

class Page4 extends StatefulWidget {
  @override
  _Page4State createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  final dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> membersWithSamePinCode = []; // List to store members

  @override
  void initState() {
    super.initState();
    _getMembersWithSamePinCode(); // Call the function to fetch members
  }

  Future<void> _getMembersWithSamePinCode() async {
    membersWithSamePinCode =
    await dbHelper.getUsersWithPinCode(loggedInPincode);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Members in Your FPO'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 16),
        child: ListView.separated(
          itemCount: membersWithSamePinCode.length,
          separatorBuilder: (context, index) => Divider(), // Add division lines
          itemBuilder: (context, index) {
            final member = membersWithSamePinCode[index];
            final name = member['name'] as String;
            final mobile = member['mobile'] as String;

            return ListTile(
              title: Text(name),
              subtitle: Text('Mobile: $mobile'),
            );
          },
        ),
      ),
    );
  }
}
