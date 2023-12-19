import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pblukm/home.dart';
import 'package:pblukm/navbar.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class formlogin extends StatefulWidget {
  const formlogin({super.key});

  @override
  State<formlogin> createState() => _formloginState();
}

// ignore: camel_case_types
class _formloginState extends State<formlogin> {
  final textEmail = TextEditingController();
  final textPass = TextEditingController();

  Future<void> loginUser() async {
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
        var accessToken = data['access_token']['plainTextToken'];
        print('Login berhasil, access token: $accessToken');
        // Navigasi ke halaman selanjutnya setelah berhasil login
        Navigator.push(context, MaterialPageRoute(builder: (context)=>navbar()));
      } else {
        // Jika login gagal, tampilkan pesan kesalahan
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Gagal'),
              content: Text('Email atau password salah.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      // Jika terjadi kesalahan pada respons dari server
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
        backgroundColor: Color(0xFFDBEAFF),
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
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            'Welcome Back!',
                            style: TextStyle(fontSize: 28),
                          ),
                        ),
                        // teks welcome back
                        const Padding(
                          padding: EdgeInsets.only(top: 7),
                          child: Text(
                            'Continue to your account',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                        //teks continue to your account
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 30, left: 30, bottom: 30, top: 30),
                          child: TextField(
                            controller: textEmail,
                            decoration: InputDecoration(
                              filled: false,
                              //fillColor: Color.fromARGB(104, 31, 65, 187),
                              hintText: 'masukkan Emailmu',
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
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 30, left: 30, top: 0, bottom: 30),
                          child: TextField(
                            controller: textPass,
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
                              hintText: 'Password SSO',
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
                                padding:
                                    const EdgeInsets.only(right: 50, left: 50),
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
                                          backgroundColor: const Color.fromARGB(
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
                      ],
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
