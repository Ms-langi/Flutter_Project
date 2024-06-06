import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database_helper.dart';
import 'home_page.dart'; // Import your HomePage screen

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = false;
  late final DatabaseHelper _databaseHelper;

  @override
  void initState() {
    super.initState();
    _databaseHelper =
        DatabaseHelper.instance; // Initialize DatabaseHelper instance
    _checkUserRegistered();
  }

  void _checkUserRegistered() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      if (mounted) {
        // Check if widget is mounted
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      }
    } else {
      List<Map<String, dynamic>> users =
          await _databaseHelper.getUsers(); // Use _databaseHelper instance
      if (users.isNotEmpty) {
        setState(() {
          _isLogin = true;
        });
      }
    }
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> user = {
        'username': _usernameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
      };
      await _databaseHelper.insertUser(user); // Use _databaseHelper instance
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User registered successfully!')));
        setState(() {
          _isLogin = true;
        });
      }
    }
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      List<Map<String, dynamic>> users =
          await _databaseHelper.getUsers(); // Use _databaseHelper instance
      for (var user in users) {
        if (user['username'] == _usernameController.text &&
            user['password'] == _passwordController.text) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          if (mounted) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Login successful!')));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          }
          return;
        }
      }
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Invalid credentials!')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'Login' : 'Register'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              if (!_isLogin)
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _isLogin ? _login : _register,
                child: Text(_isLogin ? 'Login' : 'Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
