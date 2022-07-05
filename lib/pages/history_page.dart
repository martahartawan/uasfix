import 'package:cleaningservice/models/history_order_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String? id;
  String? token;
  late Future data;
  List<History> history = [];

  userLog() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString('id');
    token = preferences.getString('token');
    setState(() {});
  }

  loadHistoryOrder() async {
    data = historyOrder();
    data.then((value) {
      setState(() {
        history = value;
      });
    });
    setState(() {});
  }

  @override
  void initState() {
    userLog().then((_) {
      loadHistoryOrder();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return Center(child: CircularProgressIndicator());
    } else {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
              title: Text('History Pemesanan'), backgroundColor: Colors.green),
          body: ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, i) {
                if (history[i].userId == id) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListBody(
                        children: [
                          ListTile(
                            leading: Icon(Icons.verified),
                          ),
                          Text(history[i].invoice,
                              style: TextStyle(fontSize: 20)),
                          SizedBox(height: 5),
                          Text('Service : ' + history[i].layanan.name),
                          Text('Pemesan : ' + history[i].user.name),
                        ],
                      ),
                    )),
                  );
                } else {
                  return Container();
                }
              }),
        ),
      );
    }
  }

  Future historyOrder() async {
    if (token != null) {
      final response = await http.get(
          Uri.parse('http://ilkom03.mhs.rey1024.com/api/order'),
          headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> data = jsonResponse["data"];

        return data.map<History>((json) => History.fromJson(json)).toList();
      } else {
        throw Exception("failed load data history");
      }
    } else {
      print('error');
    }
  }
}
