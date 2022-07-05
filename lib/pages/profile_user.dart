import 'package:cleaningservice/pages/home_page.dart';
import 'package:cleaningservice/pages/login_page.dart';
import 'package:cleaningservice/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? name;
  String? email;
  String? token;

  void userLog() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    name = preferences.getString('name');
    email = preferences.getString('email');
    token = preferences.getString('token');
    setState(() {});
  }

  @override
  void initState() {
    userLog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (token == null) {
      return SafeArea(
          child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: Text('Login'),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Register()));
                },
                child: Text('Register'),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
              )
            ],
          ),
        ),
      ));
    } else {
      return SafeArea(
          child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Container(color: Colors.green, height: 300),
                Positioned.fill(
                  child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.account_box,
                              size: 120, color: Colors.white),
                          Text(
                            name != null ? name! : '',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Text(
                            email != null ? email! : '',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Text(
                            "088917398731",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            "Jalan Cendrawasih no 901",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      )),
                )
              ],
            ),
            SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                logout();
              },
              child: Text('Logout'),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
            )
          ],
        ),
      ));
    }
  }

  Future<void> logout() async {
    final response = await http.post(
        Uri.parse('http://ilkom03.mhs.rey1024.com/api/logout'),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.clear();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Gagal logout')));
    }
  }
}
