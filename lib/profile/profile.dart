import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pblukm/profile/editprof.dart';
import 'package:pblukm/auth/login.dart';
import 'package:pblukm/auth/loginform.dart';
import 'package:pblukm/models/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late User userLogin;
  Future<void> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User userLogin2 =
        User.fromjson2(json.decode(prefs.getString("UserLoginInfo")!));
    setState(() {
      userLogin = userLogin2;
      // print(userLogin.statuspendaftar);
      // print(userLogin.isAnggota);
      //print(recruitment);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefs();
  }
  // variabel untuk model nya

  // fetch data by id (via api) atau diupdate berdasarkan value dari shared preference
  // di update pakai setState

  //initstate digunakan untuk manggil anggota/view/{id}

  @override
  Widget build(BuildContext context) {
    //setState(() {});
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 250,
                  decoration: const BoxDecoration(
                    color: Color(0xFFDBEAFF),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'img/avatar.png',
                        width: 100,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          '${userLogin.namaLogin}',
                          style: TextStyle(
                              fontFamily: 'PoppinsBold', fontSize: 30),
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                          final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => EditProf())));
                                    if (result != userLogin.emailLogin) {
                                      setState(() {
                                        userLogin.emailLogin = result;
                                      });
                                      
                                    }
                          },
                          icon: const Icon(Iconsax.edit),
                          label: const Text('Edit Profil'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 13, 41, 183),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 30, left: 30, right: 30, bottom: 50),
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.blue),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(0, 2),
                                      spreadRadius: 0.0,
                                      blurRadius: 3)
                                ],
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: EdgeInsets.only(top: 15, left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      'Detail Pengguna',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  const Text(
                                    'Nim',
                                    style: TextStyle(
                                        fontFamily: 'PoppinsBold',
                                        fontSize: 15),
                                  ),
                                  Text(
                                    '${userLogin.nimLogin}',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  const Text(
                                    'Gmail',
                                    style: TextStyle(
                                        fontFamily: 'PoppinsBold',
                                        fontSize: 15),
                                  ),
                                  Text(
                                    '${userLogin.emailLogin}',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  const Text(
                                    'Prodi',
                                    style: TextStyle(
                                        fontFamily: 'PoppinsBold',
                                        fontSize: 15),
                                  ),
                                  Text(
                                    '${userLogin.prodiLogin}',
                                    style: TextStyle(fontSize: 15),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, bottom: 10),
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 13, 41, 183),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () {},
                              child: const Text(
                                'Tentang Kami',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, bottom: 10),
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 13, 41, 183),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                onPressed: () async{
                                  SharedPreferences  prefs = await SharedPreferences.getInstance();
                                  prefs.remove("UserLoginInfo");
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>login()));
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => const login()));
                                },
                                child: const Text(
                                  'Log out',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
