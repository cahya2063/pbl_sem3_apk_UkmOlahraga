import 'package:flutter/material.dart';
import 'package:pblukm/models/divisimodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pblukm/models/jadwalmodel.dart';

class Jadwal extends StatefulWidget {
  const Jadwal({super.key});

  @override
  State<Jadwal> createState() => _JadwalState();
}

class _JadwalState extends State<Jadwal> {
  late List<modelDiv> divisi = []; //list untuk tampung data API tabel divisi
  late List<modelJadwal> jadwal = []; //list untuk tampung data API tabel jadwal
  final Map<int, String> divisiMap = {}; //
  List<String> namaDivisiList = [];

  Future<List<modelDiv>> fetchDatadivisi() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/divisi/view'));
    if (response.statusCode == 200) {
      List<dynamic> responseBody = json.decode(response.body);

      // Memetakan id divisi dengan nama divisi
      for (var item in responseBody[0]) {
        divisiMap[item['id']] = item['nama'];
      }

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

  Future<List<modelJadwal>> fetchDatajadwal() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/jadwal/view'));
    if (response.statusCode == 200) {
      List<dynamic> responseBody = json.decode(response.body);

      for (var item in responseBody[0]) {
        int divisiId = item['divisi_id'];
        String? divisiNama = divisiMap[divisiId];
        // Menambahkan nama divisi yang cocok dengan divisi_id ke dalam list namaDivisiList
        if (divisiNama != null) {
          namaDivisiList.add(divisiNama);
        }
      }

      List<dynamic> jadwalList = responseBody[0];
      List<modelJadwal> jadwals =
          jadwalList.map((item) => modelJadwal.fromjson(item)).toList();
      return jadwals;
    } else {
      throw 'gagal ambil data status code : ${response.statusCode}';
    }
  }

  // String findNamaByDivisiId(List<dynamic> divisiId){
  //   for(var item in divisi){
  //     if (item.id == divisiId) {
  //       return item.nama;
  //     }
  //   }
  //   return 'nama tidak di temukan';
  // }

  @override
  void initState() {
    super.initState();
    fetchDatadivisi().then((value) {
      if (mounted) {
        setState(() {
          divisi = value;
        });
      }
    });
    super.initState();
    fetchDatajadwal().then((value) {
      if (mounted) {
        setState(() {
          jadwal = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // fetchDatadivisi();
    // fetchDatajadwal();

    // List<dynamic> contoh = [];
    // divisi.forEach((mapItem) {
    //   contoh.add(mapItem.id as int);
    //  });
    // int examp = 2;
    // String nama = findNamaByDivisiId(contoh);
    return Scaffold(
      backgroundColor: const Color(0xFFDBEAFF),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 50, bottom: 50),
              child: Text(
                'Jadwal',
                style: TextStyle(fontFamily: 'PoppinsBold', fontSize: 50),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: ListView.builder(
                    itemCount: jadwal.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: const DecorationImage(
                                          image: AssetImage('img/bgtombol.png'),
                                          fit: BoxFit.cover)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          namaDivisiList[index],
                                          style: const TextStyle(
                                              fontFamily: 'PoppinsBold',
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 20, left: 20),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '${jadwal[index].hari} : ',
                                                style: const TextStyle(
                                                    fontFamily: 'PoppinsBold',
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Text(
                                              '${jadwal[index].waktu_mulai} - ',
                                              style: const TextStyle(
                                                  fontFamily: 'PoppinsBold',
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              jadwal[index].waktu_selesai,
                                              style: const TextStyle(
                                                  fontFamily: 'PoppinsBold',
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
