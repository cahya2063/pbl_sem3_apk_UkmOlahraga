import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pblukm/transaksi/history.dart';
//import 'package:pblukm/login.dart';
//import 'package:pblukm/loginform.dart';
import 'package:pblukm/models/beritamodel.dart';
import 'package:pblukm/models/usermodel.dart';
import 'package:pblukm/pendaftaran/oprec.dart';
//import 'package:pblukm/pinjamform.dart';
//import 'package:pblukm/stok.dart';
import 'package:http/http.dart' as http;
import 'package:pblukm/transaksi/pengembalian.dart';
import 'package:pblukm/transaksi/stok.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late User userLogin;
  Future<void> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User userLogin2 =
        User.fromjson2(json.decode(prefs.getString("UserLoginInfo")!));
    //if (mounted) {
    setState(() {
      userLogin = userLogin2;
      print(userLogin.statuspendaftar);
      print(userLogin.isAnggota);
      print(userLogin.iduserLogin);
      print('halaman home');
      //runApp(MaterialApp(home: userLogin.emailLogin == null ? login() : Home(),));
      //print(recruitment);
    });
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();

    _getdataFormAPI();
  }

  // late User userLogin;
  List<dynamic> articles1 = [];
  // dynamic status = formloginState.statuspendaftar;
  bool recruitment = false;
  bool isPinjam = true;
  String subtitle = '';
  @override
  Widget build(BuildContext context) {
    //setState(() {});
    // if (formloginState.statuspendaftar.contains('terima')) {
    //   recruitment = false;
    //   popPinjam = 'terus aktif yaa!';
    // } else if (userLogin.statuspendaftar == "menunggu") {
    //   recruitment = false;
    //   popPinjam = 'tunggu ACC dari kami ya!';
    // } else if (formloginState.statuspendaftar.contains('tolak')) {
    //   recruitment = false;
    //   popPinjam = 'maaf nihh tapi kamu bukan anggota';
    // } else if (formloginState.statuspendaftar.contains('kamu belum daftar')) {
    //   recruitment = true;
    //   popPinjam = 'ayo daftar jadi anggota kami...';
    // }

    // if (formloginState.isAnggota.contains('Anggota') &&
    //     formloginState.statuspendaftar.contains('terima')) {
    //   isPinjam = true;
    // } else if (formloginState.isAnggota.contains('Anggota') &&
    //     formloginState.statuspendaftar.contains('menunggu')) {
    //   isPinjam = false;
    //   popPinjam = 'tunggu ACC dari kami ya!';
    // } else if (formloginState.isAnggota.contains('Anggota') &&
    //     formloginState.statuspendaftar.contains('tolak')) {
    //   isPinjam = false;
    //   popPinjam = 'coba lagi tahun depan yaa..';
    // } else {
    //   isPinjam = false;
    //   popPinjam = 'ayo daftar jadi anggota kami...';
    // }

    if (userLogin.statuspendaftar!.contains('menunggu')) {
      recruitment = false;
      isPinjam = false;
      subtitle = 'tunggu ACC dari kami ya!';
    } else if (userLogin.statuspendaftar!.contains('kamu belum terdaftar')) {
      recruitment = true;
      isPinjam = false;
      subtitle = 'ayo daftar jadi anggota kami...';
    } else if (userLogin.statuspendaftar!.contains('terima')) {
      recruitment = false;
      isPinjam = true;
      subtitle = 'terus aktif yaa!';
    } else if (userLogin.statuspendaftar!.contains('tolak')) {
      recruitment = false;
      isPinjam = false;
      subtitle = 'coba lagi tahun depan yaa..';
    }

    // if (userLogin.isAnggota == 'kamu bukan anggota') {
    //   subtitle = 'ayo daftar jadi anggota kami...';
    //   isPinjam = false;
    // }
    // else if(userLogin.isAnggota == 'anggota'){
    //   isPinjam = true;
    // }

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
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                        const Text(
                          'welcome',
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        //teks welcome
                        Text(
                          userLogin.namaLogin,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  // user name
                  const Expanded(
                    child: SizedBox(
                      width: 10,
                    ),
                  ),
                  //jarak antara profil dan icon notifikasi
                  Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(userLogin.statuspendaftar!),
                                content: Text(subtitle),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Iconsax.notification_bing,
                          size: 30,
                        )),
                  )
                  // icon notifikasi
                ],
              ),
            ),
            //header
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
                              onPressed: () async {
                                if (recruitment == false) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(userLogin.statuspendaftar!),
                                        content: Text(subtitle),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  //print(recruitment);
                                } else {
                                  final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Oprec()));
                                  if (result == "menunggu") {
                                    setState(() {
                                      userLogin.statuspendaftar = "menunggu";
                                      userLogin.isAnggota = "anggota";
                                    });
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  side: const BorderSide(
                                      color: Colors.blue, width: 2),
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
                                    Iconsax.user_add4,
                                    size: 50,
                                    color: Colors.green,
                                  ),
                                  Text(
                                    'Pendaftaran',
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
                                  isPinjam == false
                                      ? showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                  userLogin.statuspendaftar!),
                                              content: Text(subtitle),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            );
                                          },
                                        )
                                      : displaySheets(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    side: const BorderSide(
                                        color: Colors.blue, width: 2),
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
                                      Iconsax.wallet_add,
                                      size: 50,
                                      color: Color.fromARGB(255, 255, 231, 16),
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
                    //teks berita olahrga
                    SizedBox(
                      height: 400,
                      child: ListView.builder(
                          itemCount: articles1.length,
                          itemBuilder: (BuildContext context, index) {
                            return ListTile(
                              contentPadding: const EdgeInsets.all(10),
                              title: Text(articles1[index]
                                  .title), //tampilkan title API dari masing masing data yang ada di dalam articles[index]
                              subtitle: Text(articles1[index].sourceId +
                                  '     ' +
                                  articles1[index]
                                      .author), //tampilkan tanggal published API dari masing masing data yang ada di dalam articles[index]
                              leading: const CircleAvatar(
                                child: Icon(Icons.public),
                              ),

                              onTap: () {
                                _launchURL(articles1[index]
                                    .url); //jika list tile di tekan maka akan menjalankan function _launchurl, dan membuka url yang ada pada list articles
                              },
                            );
                          }),
                    ),
                    //halaman berita
                    const SizedBox(
                      height: 20,
                    )
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
    // ignore: non_constant_identifier_names
    var ApiUrl =
        'https://newsapi.org/v2/top-headlines?country=id&category=sports&apiKey=55573e14a5df46adbad7353c4dfea188';

    // Mengirim permintaan GET ke API dan menunggu respons
    // ignore: non_constant_identifier_names
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
    if (mounted) {
      setState(() {
        articles1 = api;
      });
    }
  }

  _launchURL(String url) async {
    //fungsi untuk membuka url
    if (await canLaunchUrl(Uri.parse(url))) {
      //jika url valid maka akan berpindah ke browser
      await launchUrl(Uri.parse(url));
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
                                    builder: (context) => const Stok()));
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
            //tombol peminjaman alat
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
                                    builder: (context) => const history()));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 13, 41, 183),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: const Text(
                            'pengembalian alat',
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                  ),
                ),
              ],
            ),
            //tombol pengembalian
          ],
        ),
      ),
    ),
  );
}
//pop up
