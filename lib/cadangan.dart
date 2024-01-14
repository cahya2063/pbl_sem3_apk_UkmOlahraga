import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
//import 'package:pblukm/models/oprec.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Futsal extends StatefulWidget {
  const Futsal({super.key});

  @override
  State<Futsal> createState() => _FutsalState();
}

class _FutsalState extends State<Futsal> {
  List<dynamic> dataAnggota = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8000/api/pendaftaran/view')); // Ganti URL_API_ANDA dengan URL API yang sesuai

    if (response.statusCode == 200) {
      setState(() {
        final anggotaList = jsonDecode(response.body);
        dataAnggota = anggotaList[0]
            .where((item) =>
                item['status'] == 'terima' &&
                (item['divisi_1'] == 'Futsal' || item['divisi_2'] == 'Futsal'))
            .toList();
      });
    } else {
      throw 'failed to load data ${response.statusCode}';
    }
  }

  @override
  Widget build(BuildContext context) {
    //fetchData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Iconsax.arrow_left_2,
              color: Colors.black,
            )),
      ),
      backgroundColor: const Color(0xFFDBEAFF),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 0, bottom: 50),
              child: Text(
                'Futsal',
                overflow: TextOverflow.ellipsis,
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
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'divisi/futsal.png',
                            width: 250,
                          ),
                        ],
                      ),
                     const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          '- anggota -',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.blue, width: 1),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 3,
                                        blurRadius: 5)
                                  ],
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Nama',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Expanded(
                                          child: SizedBox(
                                        width: 10,
                                      )),
                                      Text(
                                        'Prodi',
                                        style: TextStyle(fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemCount: dataAnggota.length,
                            itemBuilder: (BuildContext context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 50,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          //border: Border.all(color: Colors.blue),

                                          //borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 1,
                                                blurRadius: 5)
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  dataAnggota[index]['nama'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),
                                              const Expanded(
                                                  flex: 1,
                                                  child: SizedBox(
                                                    width: 10,
                                                  )),
                                              Text(
                                                dataAnggota[index]['prodi'],
                                                style: TextStyle(fontSize: 20),
                                              )
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
                    ],
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
//fitur div futsal