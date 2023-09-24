import 'package:flutter/material.dart';
import 'SignUpPage.dart';
import 'reg_data.dart';
import 'home.dart';
import 'globals.dart';
import 'custom_splash_screen.dart'; // Import your SplashScreen widget
import 'custom_splash_screen.dart'; // Import your CustomSplashScreen widget

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomSplashScreen(), // Display the CustomSplashScreen initially
    );
  }
}


class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmdroid'),
      ),

      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String selectedUserRole = 'Farmer';
  final List<String> userRoles = ['Farmer', 'Retailer'];

  @override
  void dispose() {
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _performLogin() async {
    String mobile = mobileController.text;
    String password = passwordController.text;
    String role = selectedUserRole;

    List<Map<String, dynamic>> users = await DatabaseHelper.instance.getUser(
      mobile: mobile,
      password: password,
      role: role,
    );

    if (users.isNotEmpty) {
      loggedInUserName = users[0]['name'];
      loggedInPincode = users[0]['pincode'];
      loggedInMobile = users[0]['mobile'];
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      // Show login failed message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed. Please check your credentials.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _performLogin,
              child: Text('Login'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Navigate to forgot password screen
              },
              child: Text('Forgot Password?'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Navigate to sign up screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Text('Don\'t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}
