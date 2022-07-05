import 'dart:convert';
import 'package:cleaningservice/models/layanan_model.dart';
import 'package:http/http.dart' as http;

class LayananServices {
  final apiUrl = 'http://ilkom03.mhs.rey1024.com/api/';

  Future getLayanans() async {
    final response = await http.get(Uri.parse(apiUrl + 'layanans'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      return data.map<Layanan>((json) => Layanan.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load data");
    }
  }
}
