import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pblukm/models/historymodel.dart';
import 'package:http/http.dart' as http;
import 'package:pblukm/models/usermodel.dart';
import 'package:pblukm/transaksi/pengembalian.dart';
import 'package:shared_preferences/shared_preferences.dart';

class history extends StatefulWidget {
  const history({super.key});

  @override
  State<history> createState() => _historyState();
}

class _historyState extends State<history> {
  List<modelHistory> history = [];
  late User userLogin;

  Future<List<modelHistory>> fetchDataPinjam() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8000/api/pinjam/view/${userLogin.nimLogin}'));
    if (response.statusCode == 200) {
      List<dynamic> responseBody = json.decode(response.body);
      List<dynamic> historyList = responseBody[0];
      List<modelHistory> historys =
          historyList.map((item) => modelHistory.fromJson(item)).toList();
      return historys;
    } else {
      throw 'tidak bisa ambil data ${response.statusCode}';
    }
  }

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
      print('halaman history');
      //runApp(MaterialApp(home: userLogin.emailLogin == null ? login() : Home(),));
      //print(recruitment);
    });
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs().then((_) {
      fetchDataPinjam().then((value) {
        setState(() {
          history = value;
        });
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
      backgroundColor: const Color(0xFFDBEAFF),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 0, bottom: 50),
              child: Text(
                'History',
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
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 40,
                          left: 20,
                          right: 20,
                        ),
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            ListView.builder(
                                itemCount: history.length,
                                itemBuilder: (BuildContext context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Container(
                                      height: 400,
                                      decoration: BoxDecoration(
                                        color: Color(0xff9BBBFC),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30,
                                            right: 30,
                                            top: 30,
                                            bottom: 30),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'nama : ',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                                Expanded(
                                                    child: SizedBox(
                                                  width: 1,
                                                )),
                                                Text(
                                                  'id : ${history[index].id}',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              history[index].nama,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    height: 2,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Text(
                                              'nama alat: ',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              history[index].nama_barang,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    height: 2,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Text(
                                              'jumlah alat : ',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              '${history[index].jml_barang}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    height: 2,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Text(
                                              'tanggal peminjaman : ',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              history[index].tggl_pinjam,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    height: 2,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: FloatingActionButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                elevation: 10,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Pengembalianform()));
                                },
                                child: Icon(
                                  Iconsax.arrow_circle_right4,
                                  size: 30,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
