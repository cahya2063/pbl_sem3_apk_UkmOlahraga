import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pblukm/models/alatmodel.dart';
import 'package:http/http.dart' as http;
//import 'package:pblukm/models/jadwalmodel.dart';
//import 'package:pblukm/fiturdiv.dart';
import 'package:pblukm/transaksi/pinjamform.dart';

class Stok extends StatefulWidget {
  const Stok({super.key});

  @override
  State<Stok> createState() => _StokState();
}

class _StokState extends State<Stok> {
  late List<Modelalat> alat = [];
  late List<Modelalat> originalAlat = [];

  TextEditingController searchController = TextEditingController();
  Future<List<Modelalat>> fetchDataAlat() async {
    var response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/stok/alat'));

    if (response.statusCode == 200) {
      List<dynamic> responseBody = json.decode(response.body);
      List<dynamic> alatList = responseBody[0];
      List<Modelalat> alats =
          alatList.map((item) => Modelalat.fromJson(item)).toList();//untuk mengubah nilai yang ada pada  Modelalat.fromJson(item)).toList()

      return alats;
    } else {
      throw "tidak bisa ambil data alat ${response.statusCode}";
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataAlat().then((value) {
      setState(() {
        alat = value;
        originalAlat = List.from(alat);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
      //appbar
      backgroundColor: const Color(0xFFDBEAFF),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 20),
              child: Text(
                'Peminjaman',
                style: TextStyle(
                    fontFamily: 'PoppinsBold',
                    fontSize: 50,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
            //teks peminjaman
            Expanded(
              child: Container(
                height: 500,
                width: 500,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                //container putih
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 60, bottom: 30),
                                child: Container(
                                  height: 400,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff9BBBFC),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, left: 20, right: 30),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0, right: 50),
                                          child: TextField(
                                            controller: searchController,
                                            onChanged: (value) {
                                              // Panggil fungsi filter setiap kali isi TextField berubah
                                              filterAlat(value);
                                            },
                                            decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 50),
                                              fillColor: Colors.white,
                                              filled: true,
                                              hintText: 'search...',
                                              prefixIcon: Icon(
                                                Iconsax.search_normal_1,
                                                color: Color(0xff9BBBFC),
                                              ),
                                              hintStyle: TextStyle(
                                                fontFamily: 'PoppinsBold',
                                                fontSize: 18.0,
                                                color: Color(0xff9BBBFC),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                        //searching
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: ListView.builder(
                                                itemCount: alat.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    10)),
                                                        border: Border.all(
                                                          color: Colors.white,
                                                          width: 3.0,
                                                        ),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 5),
                                                            child: Text(
                                                              alat[index].nama,
                                                              style: const TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 90),
                                                              child: Container(
                                                                height: 30,
                                                                decoration: const BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(5))),
                                                                child: Center(
                                                                  child: Text(
                                                                    '${alat[index].stok}',
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Color(
                                                                          0xff9BBBFC),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                  //list alat UKM
                                                }),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 50, right: 50),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                Pinjamform())));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    shadowColor:
                                        const Color.fromARGB(255, 13, 41, 183),
                                    elevation: 8,
                                    padding: EdgeInsets
                                        .zero, // Hapus padding agar gambar bisa memenuhi seluruh area
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                  child: Center(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset('img/bgtombol.png'),
                                        const Text(
                                          'Transaksi',
                                          style: TextStyle(fontSize: 30),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // tombol transaksi
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void filterAlat(String query) {
    setState(() {
      if (query.isEmpty) {
        alat = List.from(originalAlat);
      } else {
        alat = alat.where((alat) {
          return alat.nama.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }
}
