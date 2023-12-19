import 'package:flutter/material.dart';
import 'package:pblukm/fiturdiv.dart';
import 'package:pblukm/models/divisimodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Divisi extends StatefulWidget {
  const Divisi({super.key});

  @override
  State<Divisi> createState() => _DivisiState();
}

class _DivisiState extends State<Divisi> {
  late List<modelDiv> divisi = []; //list untuk tampung data API tabel divisi

  Future<List<modelDiv>> fetchDatadivisi() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/divisi/view'));
    if (response.statusCode == 200) {
      List<dynamic> responseBody = json.decode(response.body);

      List<dynamic> divisiList = responseBody[0];

      // Mengonversi setiap item dalam daftar menjadi objek modelDiv
      List<modelDiv> divisis =
          divisiList.map((item) => modelDiv.fromJson(item)).toList();

      // Mengembalikan daftar modelDiv setelah konversi
      return divisis;
    } else {
      throw "Failed to load data: ${response.statusCode}";
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDatadivisi().then((value) {
      setState(() {
        divisi = value;
      });
    });
  }

  final Map<int, String> fiturdiv = {
    0: '/futsal',
    1: '/basket',
    2: '/badminthon',
    3: '/tarungderajat',
    4: '/catur',
  };

  @override
  Widget build(BuildContext context) {
    fetchDatadivisi();
    return Scaffold(
      backgroundColor: const Color(0xFFDBEAFF),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 50, bottom: 50),
              child: Text(
                'Divisi',
                style: TextStyle(fontFamily: 'PoppinsBold', fontSize: 50),
              ),
            ),
            Expanded(
              child: Container(
                height: 500,
                width: 500,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ListView.builder(
                      itemCount: divisi.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, bottom: 30),
                          child: Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (fiturdiv.containsKey(index)) {
                                    Navigator.pushNamed(
                                        context, fiturdiv[index]!);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  shadowColor:
                                      const Color.fromARGB(255, 13, 41, 183),
                                  elevation: 8,
                                  padding: EdgeInsets
                                      .zero, // Hapus padding agar gambar bisa memenuhi seluruh area
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                child: Center(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset('img/bgtombol.png'),
                                      Text(
                                        divisi[index].nama,
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
