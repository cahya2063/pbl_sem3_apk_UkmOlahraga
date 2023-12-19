import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pblukm/oprec.dart';
import 'package:pblukm/stok.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                        '|Dashboard',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    //teks dashboard
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: 130,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 30, right: 30, top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // recruitment
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 2, left: 10),
                                          child: IconButton(
                                              onPressed: () {
                                                if (hasilFetchOpenRecr ==
                                                    true) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Oprec()));
                                                } else {
                                                  print("Belum dibuka");
                                                }
                                              },
                                              icon: const Icon(
                                                Iconsax.strongbox_2,
                                                size: 40,
                                                color: Colors.green,
                                              )),
                                        ),
                                        const Text(
                                          'Recruitment',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //fitur Recruitment
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 2, left: 0),
                                          child: IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                            Stok())));
                                              },
                                              icon: const Icon(
                                                Iconsax.card_receive5,
                                                size: 40,
                                                color: Colors.yellow,
                                              )),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(
                                            'Pinjam',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //fitur Pinjam
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 2, left: 0),
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Iconsax.card_send5,
                                                size: 40,
                                                color: Colors.red,
                                              )),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(
                                            'kembali',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //fitur kembali
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 15,
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
}
