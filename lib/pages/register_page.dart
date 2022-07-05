import 'package:cleaningservice/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var _nameController = TextEditingController();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _passConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'name',
              ),
            ),
            SizedBox(
              height: 10,
            ),
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
            TextField(
              controller: _passConfirmController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Konfirmasi Password',
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
                    Register();
                  },
                  child: Text(
                    'Register',
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

  Future<void> Register() async {
    if (_nameController.text.isNotEmpty && _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty && _passConfirmController.text.isNotEmpty) {
      final response = await http
          .post(Uri.parse('http://ilkom03.mhs.rey1024.com/api/register'), body: {
        'name': _nameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'password_confirmation': _passConfirmController.text
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
            .showSnackBar(SnackBar(content: Text('Gagal Register')));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Form masih kosong')));
    }
  }
}
