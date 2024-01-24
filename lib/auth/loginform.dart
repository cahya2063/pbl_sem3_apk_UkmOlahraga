// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pblukm/models/usermodel.dart';
//import 'package:pblukm/models/oprec.dart';
//import 'package:pblukm/home.dart';
import 'package:pblukm/home/navbar.dart';
import 'package:http/http.dart' as http;
import 'package:pblukm/widget/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  late User userLogin;
// Bagian dari fungsi getStatusPendaftarByNIM
  //function untuk mengambil data status di tabel anggota berdasarkan nim yang cocok
  Future<void> getStatusPendaftarByNIM(String nim) async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:8000/api/pendaftaran/view/$nim'));//kirim request ke API
    if (response.statusCode == 200) {//jika respons OK maka : 
      final data = json.decode(response.body); //lakukan decoding pada respons dan masukkan ke variabel data
      var pendaftarData = data[0]; // Mengakses array dalam di indeks 0

      if (pendaftarData != null) {//jika pendaftar data tidak kosong maka : 
        userLogin.statuspendaftar = pendaftarData['status'];//masukkan nilai pada pendaftarData['status'] ke userLogin.statuspendaftar
        userLogin.isAnggota = pendaftarData['jabatan'];//masukkan nilai pada pendaftarData['jabatan'] ke userLogin.isAnggota
      }

      print('checkpoint');
    } else {
      throw "Failed to load data: ${response.statusCode}";
    }
  }

  Future<void> loginUser() async {
    bool isValid = formKey.currentState!.validate();//validator
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

      if (data['status'] == true && data['message'] == 'Login Berhasil') {//jika Login berhasil maka : 
        userLogin = User.fromjson(data);//masukkan variabel data ke userLogin

        await getStatusPendaftarByNIM(userLogin.nimLogin);//masukkan userLogin.nimLogin ke parameter 
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("UserLoginInfo", json.encode(userLogin.tojson()));//atur nilai userLogin.toJson ke shared preferences menggunakan key "userLoginInfo"
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => navbar()));//jika berhasil simpan arahakan ke navbar
      } else {// jika login gagal maka : 
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
                          Padding(
                            padding: EdgeInsets.only(
                                left: 30, top: 30, right: 30, bottom: 20),
                            child: textFieldAuth(
                                validasi: 'mana emailmu?',
                                hinText: 'Masukkan Emailmu',
                                controller: textEmail,
                                judul: 'Email',
                                tipe: TextInputType.emailAddress),
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
                                    child: button(text: 'Sign In', pressed: loginUser)
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
