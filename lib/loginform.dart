// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
//import 'package:pblukm/models/oprec.dart';
//import 'package:pblukm/home.dart';
import 'package:pblukm/navbar.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class formlogin extends StatefulWidget {
  const formlogin({super.key});

  @override
  State<formlogin> createState() => formloginState();
}

// ignore: camel_case_types
class formloginState extends State<formlogin> {
  final textEmail = TextEditingController();
  final textPass = TextEditingController();
  
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static String? token;
  static var namaLogin;
  static var emailLogin;
  static var nimLogin;
  static var prodiLogin;
  static int? iduserLogin;

  //static var nimPendaftar;
  static var statuspendaftar = '';
  static var isAnggota = '';
// Bagian dari fungsi getStatusPendaftarByNIM
  Future<void> getStatusPendaftarByNIM() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/pendaftaran/view'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body); // Data adalah array luaran
      final pendaftarData = data[0]; // Mengakses array dalam di indeks 0

      bool terdaftar = false;
      bool anggota = true;
      // Anda dapat mengakses data pendaftaran seperti ini
      for (var pendaftar in pendaftarData) {
        // Menggunakan variabel 'pendaftar' untuk mengakses setiap objek data pendaftaran

        var nimpendaf = pendaftar['nim'];
        if (nimpendaf == nimLogin) {
          statuspendaftar = pendaftar['status'];
          isAnggota = pendaftar['jabatan'];
          terdaftar = true;
          anggota = true;
        }
      }
      if (!terdaftar) {
        statuspendaftar = 'kamu belum terdaftar';
      }
      if(!anggota){
        isAnggota = 'kamu bukan anggota';
      }
    } else {
      throw "Failed to load data: ${response.statusCode}";
    }
  }

  Future<void> loginUser() async {
    bool isValid = formKey.currentState!.validate();
    if (!isValid) {
      // Tampilkan pesan jika form tidak valid
      return;
    }
    // Ganti URL dengan URL endpoint login Anda
    var url = Uri.parse('http://10.0.2.2:8000/api/login');
    var response = await http.post(
      url,
      body: {
        'email': textEmail.text,
        'password': textPass.text,
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data['status'] == true && data['message'] == 'Login Berhasil') {
        // Jika login berhasil, Anda dapat melakukan sesuatu di sini
        var token1 = data['access_token']['plainTextToken'];
        var nama1 = data['data']['name'];
        var nim1 = data['data']['nim'];
        var email1 = data['data']['email'];
        var prodi1 = data['data']['prodi'];
        var id1 = data['data']['id'];
        // ignore: avoid_print
        print('Login berhasil, access token: $token1');
        // Navigasi ke halaman selanjutnya setelah berhasil login
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const navbar()));
        namaLogin = nama1;
        nimLogin = nim1;
        emailLogin = email1;
        prodiLogin = prodi1;
        token = token1;
        iduserLogin = id1;
        await getStatusPendaftarByNIM();
      } else {
        // Jika login gagal, tampilkan pesan kesalahan
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Login Gagal'),
              content: const Text('Email atau password salah.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      // Jika terjadi kesalahan pada respons dari server
      // ignore: avoid_print
      print('Error: ${response.reasonPhrase}');
    }
  }

  bool obscuretext = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFDBEAFF),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Iconsax.arrow_left_2)),
              ),
              //tombol back
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 20),
                  child: Image.asset(
                    'img/logoukm.png',
                    width: 150,
                  ),
                ),
              ),
              //logo ukm
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  //white container
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Center(
                              child: Text(
                                'Welcome Back!',
                                style: TextStyle(fontSize: 28),
                              ),
                            ),
                          ),
                          // teks welcome back
                          const Padding(
                            padding: EdgeInsets.only(top: 7),
                            child: Center(
                              child: Text(
                                'Continue to your account',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            ),
                          ),
                          //teks continue to your account
                          const Padding(
                            padding: EdgeInsets.only(left: 30, top: 30),
                            child: Text(
                              'Email',
                              style: TextStyle(
                                  fontFamily: 'PoppinsBold', fontSize: 15),
                            ),
                          ),
                          // text Email
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 30, left: 30, bottom: 20, top: 0),
                            child: TextFormField(
                              controller: textEmail,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Mana emailmu?';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: false,
                                //fillColor: Color.fromARGB(104, 31, 65, 187),
                                hintText: 'Masukkan Emailmu',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                          //bagian input username
                          const Padding(
                            padding: EdgeInsets.only(left: 30, top: 0),
                            child: Text(
                              'Password',
                              style: TextStyle(
                                  fontFamily: 'PoppinsBold', fontSize: 15),
                            ),
                          ),
                          // text nama
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 30, left: 30, top: 0, bottom: 30),
                            child: TextFormField(
                              controller: textPass,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Mana passwordmu?';
                                }
                                return null;
                              },
                              obscureText: obscuretext,
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      obscuretext = !obscuretext;
                                    });
                                  },
                                  child: Icon(obscuretext
                                      ? Iconsax.eye
                                      : Iconsax.eye_slash),
                                ),
                                hintText: 'Masukkan Password',
                                border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                          //bagian input password
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 50, left: 50),
                                  child: SizedBox(
                                    height: 60,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          print(textEmail);
                                          print(textPass);
                                          // ketika diklik, nanti response dari api
                                          // response nya berupa token / id user.
                                          // atau berupa objek user
                                          // objek tersebut bisa di simpan di shared preferense

                                          //response status menunggu, kirim ke halaman tunggu
                                          // klo diterima kasih ke home

                                          loginUser();
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shadowColor: const Color.fromARGB(
                                                255, 13, 41, 183),
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 13, 41, 183)),
                                        child: const Text(
                                          'Sign In',
                                          style: TextStyle(fontSize: 22),
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //tombol Sign In
                          SizedBox(
                            height: 50,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
