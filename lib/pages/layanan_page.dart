import 'package:cleaningservice/models/layanan_model.dart';
import 'package:cleaningservice/pages/detail_layanan.dart';
import 'package:cleaningservice/services/layanan_services.dart';
import 'package:flutter/material.dart';

class LayananPage extends StatefulWidget {
  const LayananPage({Key? key}) : super(key: key);

  @override
  State<LayananPage> createState() => _LayananPageState();
}

class _LayananPageState extends State<LayananPage> {
  late Future data;
  List<Layanan> layanans = [];

  loadLayanans() {
    data = LayananServices().getLayanans();
    data.then((value) {
      setState(() {
        layanans = value;
      });
    });
  }

  @override
  void initState() {
    loadLayanans();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (layanans.length == 0) {
      return Center(child: CircularProgressIndicator());
    } else {
      return SafeArea(
          child: Scaffold(
        appBar: AppBar(title: Text('All Layanan'), backgroundColor: Colors.green),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.builder(
              itemCount: layanans.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailLayanan(layanans: layanans[i])));
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(layanans[i].name),
                      subtitle: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                            'http://ilkom03.mhs.rey1024.com/apiCS/public/images/' +
                                layanans[i].image),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ));
    }
  }
}
