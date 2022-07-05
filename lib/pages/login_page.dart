import 'package:cleaningservice/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 120,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    login();
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.green))),
            )
          ],
        ),
      ),
    ));
  }

  Future<void> login() async {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      final response = await http
          .post(Uri.parse('http://ilkom03.mhs.rey1024.com/api/login'), body: {
        'email': _emailController.text,
        'password': _passwordController.text
      });
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        final id = data['user']['id'];
        final name = data['user']['name'];
        final email = data['user']['email'];
        final token = data['token'];
        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        preferences.setString('id', id.toString());
        preferences.setString('name', name);
        preferences.setString('email', email);
        preferences.setString('token', token);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomePage();
        }));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Gagal login')));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Form masih kosong')));
    }
  }
}
