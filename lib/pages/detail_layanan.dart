import 'package:cleaningservice/models/layanan_model.dart';
import 'package:cleaningservice/pages/history_page.dart';
import 'package:cleaningservice/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DetailLayanan extends StatefulWidget {
  final Layanan layanans;
  const DetailLayanan({required this.layanans});

  @override
  State<DetailLayanan> createState() => _DetailLayananState();
}

class _DetailLayananState extends State<DetailLayanan> {
  String? token;

  void userLog() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
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
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              title: Text('Order Layanan'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: double.maxFinite,
                      child: Image.network(
                          'http://ilkom03.mhs.rey1024.com/apiCS/public/images/' +
                              widget.layanans.image,
                          fit: BoxFit.fill),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    widget.layanans.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.layanans.description,
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 70,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          orderLayanan();
                        },
                        child: Icon(
                          Icons.shopping_cart,
                          size: 30,
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green))),
                  )
                ],
              ),
            )));
  }

  Future<void> orderLayanan() async {
    if (token != null) {
      final response = await http.post(
          Uri.parse('http://ilkom03.mhs.rey1024.com/api/order'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: {
            'layanan_id': widget.layanans.id.toString()
          });
      if (response.statusCode == 201) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HistoryPage()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Gagal order')));
      }
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }
  }
}
