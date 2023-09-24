import 'package:flutter/material.dart';
import 'reg_data.dart';
import 'home.dart';
import 'globals.dart';

void main() {
  runApp(SignUpPage());
}

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Farmdroid',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Farmdroid'),
        ),
        body: SignUpForm(),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController nameController = TextEditingController(text: loggedInUserName);
  final TextEditingController mobileController = TextEditingController(text: loggedInMobile);
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController(text: loggedInPincode);

  String selectedUserRole = 'Farmer';
  final List<String> userRoles = ['Farmer', 'Retailer'];

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    stateController.dispose();
    pincodeController.dispose();
    super.dispose();
  }

  Future<void> _saveRegistrationData(BuildContext context) async {
    String name = nameController.text;
    String mobile = mobileController.text;
    String password = passwordController.text;
    String address = stateController.text;
    String pincode = pincodeController.text;
    String role = selectedUserRole;

    loggedInPincode = pincode;
    loggedInMobile = mobile;
    loggedInUserName = name;

    Map<String, dynamic> registrationData = {
      'name': name,
      'mobile': mobile,
      'password': password,
      'address': address,
      'pincode': pincode,
      'role': role,
    };

    await DatabaseHelper.instance.insertRegistration(registrationData);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()), // Navigate to MyApp
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: mobileController,
                  decoration: InputDecoration(labelText: 'Mobile Number'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: stateController,
                  decoration: InputDecoration(labelText: 'State'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: pincodeController,
                  decoration: InputDecoration(labelText: 'Pincode'),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        value: selectedUserRole,
                        onChanged: (newValue) {
                          setState(() {
                            selectedUserRole = newValue!;
                          });
                        },
                        items: userRoles.map((role) {
                          return DropdownMenuItem<String>(
                            value: role,
                            child: Text(role),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _saveRegistrationData(context),
                  child: Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farmdroid',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Farmdroid'),
        ),
        body: Center(
          child: Text('Welcome to MyApp!'),
        ),
      ),
    );
  }
}
