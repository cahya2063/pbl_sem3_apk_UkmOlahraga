import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pblukm/editprof.dart';
import 'package:pblukm/login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // variabel untuk model nya

  // fetch data by id (via api) atau diupdate berdasarkan value dari shared preference
  // di update pakai setState

  //initstate digunakan untuk manggil anggota/view/{id}

  @override
  Widget build(BuildContext context) {
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
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Devita',
                          style: TextStyle(
                              fontFamily: 'PoppinsBold', fontSize: 30),
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => EditProf())));
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
                            child: const Padding(
                              padding: EdgeInsets.only(top: 15, left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      'Detail Pengguna',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  Text(
                                    'Nim',
                                    style: TextStyle(
                                        fontFamily: 'PoppinsBold',
                                        fontSize: 15),
                                  ),
                                  Text(
                                    '3622583020xx',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    'Gmail',
                                    style: TextStyle(
                                        fontFamily: 'PoppinsBold',
                                        fontSize: 15),
                                  ),
                                  Text(
                                    'devita@emanil.com',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    'Kota',
                                    style: TextStyle(
                                        fontFamily: 'PoppinsBold',
                                        fontSize: 15),
                                  ),
                                  Text(
                                    'Banyuwangi',
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
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const login()));
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
