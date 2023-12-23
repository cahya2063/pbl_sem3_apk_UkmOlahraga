import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pblukm/models/beritamodel.dart';
import 'package:pblukm/oprec.dart';
import 'package:pblukm/pinjamform.dart';
import 'package:pblukm/stok.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void initState() {
    super.initState();
    _getdataFormAPI();
  }

  List<dynamic> articles1 = [];
  bool hasilFetchOpenRecr = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'img/avatar.png',
                    width: 65,
                  ),
                  //gambar profil
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                        Text(
                          'Welcome',
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        //teks welcome
                        Text(
                          'Devita',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  //user name
                  // const Expanded(
                  //   child: SizedBox(
                  //     width: 10,
                  //   ),
                  // ),
                  //jarak antara profil dan icon notifikasi
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 0),
                  //   child: IconButton(
                  //       onPressed: () {},
                  //       icon: const Icon(
                  //         Iconsax.notification_bing,
                  //         size: 30,
                  //       )),
                  // )
                  //icon notifikasi
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 30, bottom: 40, left: 5, right: 5),
                      child: Image.asset(
                        'img/header.png',
                        width: 360,
                      ),
                    ),
                    //logo sport
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        '| Dashboard',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    //teks dashboard
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 100,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Oprec()));
                              },
                              style: ElevatedButton.styleFrom(
                                  side: const BorderSide(color: Colors.blue),
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.deepPurple,
                                  elevation: 10,
                                  shadowColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Iconsax.strongbox_2,
                                    size: 50,
                                    color: Colors.green,
                                  ),
                                  Text(
                                    'Recruitment',
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //tombol recruitment
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 30),
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 100,
                              child: ElevatedButton(
                                onPressed: () {
                                  displaySheets(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    side: const BorderSide(color: Colors.blue),
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.deepPurple,
                                    elevation: 10,
                                    shadowColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Iconsax.folder_2,
                                      size: 50,
                                      color: Colors.yellow,
                                    ),
                                    Text(
                                      'Alat',
                                      style: TextStyle(color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //tombol alat
                    const Center(
                      child: Text(
                        'Berita olahraga',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 400,
                      child: ListView.builder(
                          itemCount: articles1.length,
                          itemBuilder: (BuildContext context, index) {
                            return ListTile(
                              contentPadding: EdgeInsets.all(10),
                              title: Text(articles1[index]
                                  .title), //tampilkan title API dari masing masing data yang ada di dalam articles[index]
                              subtitle: Text(articles1[index].sourceId +
                                  '     ' +
                                  articles1[index]
                                      .author), //tampilkan tanggal published API dari masing masing data yang ada di dalam articles[index]
                              leading: CircleAvatar(
                                child: Icon(Icons.public),
                              ),

                              onTap: () {
                                _launchURL(articles1[index]
                                    .url); //jika list tile di tekan maka akan menjalankan function _launchurl, dan membuka url yang ada pada list articles
                              },
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
            //logo Sport
          ],
        ),
      ),
    );
  }

  static Future<List<Api>> connectToApi() async {
    // URL API yang akan diakses untuk mendapatkan data
    var ApiUrl =
        'https://newsapi.org/v2/top-headlines?country=id&category=sports&apiKey=55573e14a5df46adbad7353c4dfea188';

    // Mengirim permintaan GET ke API dan menunggu respons
    var ApiResult = await http.get(Uri.parse(ApiUrl));

    // Mendekode data JSON dari API dan mengambil daftar artikel
    var articles = json.decode(ApiResult.body)['articles'] as List;
    // Mengonversi data dari API ke dalam List<Api>
    // Menggunakan fungsi map() untuk mengonversi setiap objek artikel menjadi objek Api
    List<Api> apiList =
        articles.map((articles) => Api.createApi(articles)).toList();

    return apiList;
  }

  Future<void> _getdataFormAPI() async {
    var api = await connectToApi();
    setState(() {
      articles1 = api;
    });
  }

  _launchURL(String url) async {
    //fungsi untuk membuka url
    if (await canLaunch(url)) {
      //jika url valid maka akan berpindah ke browser
      await launch(url);
    } else {
      throw 'tidak bisa membuka url'; // jika url tidak valid akan ada peringatan
    }
  }
}

Future displaySheets(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
    builder: (context) => SizedBox(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: SizedBox(
                      height: 60,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Pinjamform()));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 13, 41, 183),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: const Text(
                            'peminjaman alat',
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: SizedBox(
                      height: 60,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 13, 41, 183),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: const Text(
                            'pengambalian alat',
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
//pop up
