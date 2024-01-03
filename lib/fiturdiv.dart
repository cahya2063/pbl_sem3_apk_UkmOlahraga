import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
//import 'package:pblukm/models/oprec.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Futsal extends StatefulWidget {
  const Futsal({super.key});

  @override
  State<Futsal> createState() => _FutsalState();
}

class _FutsalState extends State<Futsal> {
  List<dynamic> dataAnggota = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8000/api/pendaftaran/view')); // Ganti URL_API_ANDA dengan URL API yang sesuai

    if (response.statusCode == 200) {
      setState(() {
        final anggotaList = jsonDecode(response.body);
        dataAnggota = anggotaList[0]
            .where((item) =>
                item['status'] == 'terima' &&
                (item['divisi_1'] == 'Futsal' || item['divisi_2'] == 'Futsal'))
            .toList();
      });
    } else {
      throw 'failed to load data ${response.statusCode}';
    }
  }

  @override
  Widget build(BuildContext context) {
    //fetchData();
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
                'Futsal',
                overflow: TextOverflow.ellipsis,
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
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'divisi/futsal.png',
                            width: 250,
                          ),
                        ],
                      ),
                     const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          '- anggota -',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.blue, width: 1),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 3,
                                        blurRadius: 5)
                                  ],
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Nama',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Expanded(
                                          child: SizedBox(
                                        width: 10,
                                      )),
                                      Text(
                                        'Prodi',
                                        style: TextStyle(fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemCount: dataAnggota.length,
                            itemBuilder: (BuildContext context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 50,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          //border: Border.all(color: Colors.blue),

                                          //borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 1,
                                                blurRadius: 5)
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  dataAnggota[index]['nama'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),
                                              const Expanded(
                                                  flex: 1,
                                                  child: SizedBox(
                                                    width: 10,
                                                  )),
                                              Text(
                                                dataAnggota[index]['prodi'],
                                                style: TextStyle(fontSize: 20),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//fitur div futsal

class Badminthon extends StatefulWidget {
  const Badminthon({super.key});

  @override
  State<Badminthon> createState() => _BadminthonState();
}

class _BadminthonState extends State<Badminthon> {
  List<dynamic> dataAnggota = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8000/api/pendaftaran/view')); // Ganti URL_API_ANDA dengan URL API yang sesuai

    if (response.statusCode == 200) {
      setState(() {
        final anggotaList = jsonDecode(response.body);
        dataAnggota = anggotaList[0]
            .where((item) =>
                item['status'] == 'terima' &&
                (item['divisi_1'] == 'Badminton' ||
                    item['divisi_2'] == 'Badminton'))
            .toList();
      });
    } else {
      throw 'failed to load data ${response.statusCode}';
    }
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
                'Badminton',
                overflow: TextOverflow.ellipsis,
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
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'divisi/badminton 1.png',
                            width: 250,
                          ),
                        ],
                      ),
                     const Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          '- anggota -',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.blue, width: 1),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 3,
                                        blurRadius: 5)
                                  ],
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Nama',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Expanded(
                                          child: SizedBox(
                                        width: 10,
                                      )),
                                      Text(
                                        'Prodi',
                                        style: TextStyle(fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemCount: dataAnggota.length,
                            itemBuilder: (BuildContext context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 50,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          //border: Border.all(color: Colors.blue),

                                          //borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 1,
                                                blurRadius: 5)
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  dataAnggota[index]['nama'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),
                                              const Expanded(
                                                  flex: 1,
                                                  child: SizedBox(
                                                    width: 10,
                                                  )),
                                              Text(
                                                dataAnggota[index]['prodi'],
                                                style: TextStyle(fontSize: 20),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//fitur div badminthon

class Basket extends StatefulWidget {
  const Basket({super.key});

  @override
  State<Basket> createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  List<dynamic> dataAnggota = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8000/api/pendaftaran/view')); // Ganti URL_API_ANDA dengan URL API yang sesuai

    if (response.statusCode == 200) {
      setState(() {
        final anggotaList = jsonDecode(response.body);
        dataAnggota = anggotaList[0]
            .where((item) =>
                item['status'] == 'terima' &&
                (item['divisi_1'] == 'Basket' || item['divisi_2'] == 'Basket'))
            .toList();
      });
    } else {
      throw 'failed to load data ${response.statusCode}';
    }
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
                'Basket',
                overflow: TextOverflow.ellipsis,
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
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'divisi/basket.png',
                            width: 230,
                          ),
                        ],
                      ),
                      Padding(//========
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          '- anggota -',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.blue, width: 1),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 3,
                                        blurRadius: 5)
                                  ],
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Nama',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Expanded(
                                          child: SizedBox(
                                        width: 10,
                                      )),
                                      Text(
                                        'Prodi',
                                        style: TextStyle(fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemCount: dataAnggota.length,
                            itemBuilder: (BuildContext context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 50,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          //border: Border.all(color: Colors.blue),

                                          //borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 1,
                                                blurRadius: 5)
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  dataAnggota[index]['nama'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),
                                              const Expanded(
                                                  flex: 1,
                                                  child: SizedBox(
                                                    width: 10,
                                                  )),
                                              Text(
                                                dataAnggota[index]['prodi'],
                                                style: TextStyle(fontSize: 20),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//fitur div basket

class Volly extends StatefulWidget {
  const Volly({super.key});

  @override
  State<Volly> createState() => _VollyState();
}

class _VollyState extends State<Volly> {
  List<dynamic> dataAnggota = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8000/api/pendaftaran/view')); // Ganti URL_API_ANDA dengan URL API yang sesuai

    if (response.statusCode == 200) {
      setState(() {
        final anggotaList = jsonDecode(response.body);
        dataAnggota = anggotaList[0]
            .where((item) =>
                item['status'] == 'terima' &&
                (item['divisi_1'] == 'Volly' || item['divisi_2'] == 'Volly'))
            .toList();
      });
    } else {
      throw 'failed to load data ${response.statusCode}';
    }
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
                'Volly',
                overflow: TextOverflow.ellipsis,
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
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 30, bottom: 30),
                            child: Image.asset(
                              'divisi/voli.png',
                              width: 230,
                            ),
                          ),
                        ],
                      ),
                     const Padding(//========
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        '- anggota -',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.blue, width: 1),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 3,
                                      blurRadius: 5)
                                ],
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  children: [
                                    Text(
                                      'Nama',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Expanded(
                                        child: SizedBox(
                                      width: 10,
                                    )),
                                    Text(
                                      'Prodi',
                                      style: TextStyle(fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 200,
                        child: ListView.builder(
                          itemCount: dataAnggota.length,
                          itemBuilder: (BuildContext context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        //border: Border.all(color: Colors.blue),

                                        //borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              spreadRadius: 1,
                                              blurRadius: 5)
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                dataAnggota[index]['nama'],
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                style:
                                                    TextStyle(fontSize: 20),
                                              ),
                                            ),
                                            const Expanded(
                                                flex: 1,
                                                child: SizedBox(
                                                  width: 10,
                                                )),
                                            Text(
                                              dataAnggota[index]['prodi'],
                                              style: TextStyle(fontSize: 20),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//fitur div volly

class Silat extends StatefulWidget {
  const Silat({super.key});

  @override
  State<Silat> createState() => _SilatState();
}

class _SilatState extends State<Silat> {
  List<dynamic> dataAnggota = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8000/api/pendaftaran/view')); // Ganti URL_API_ANDA dengan URL API yang sesuai

    if (response.statusCode == 200) {
      setState(() {
        final anggotaList = jsonDecode(response.body);
        dataAnggota = anggotaList[0]
            .where((item) =>
                item['status'] == 'terima' &&
                (item['divisi_1'] == 'Silat' || item['divisi_2'] == 'Silat'))
            .toList();
      });
    } else {
      throw 'failed to load data ${response.statusCode}';
    }
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
                'Silat',
                overflow: TextOverflow.ellipsis,
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
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 30, bottom: 30),
                            child: Image.asset(
                              'divisi/silat.png',
                              width: 265,
                            ),
                          ),
                        ],
                      ),
                     const Padding(//========
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      '- anggota -',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.blue, width: 1),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 3,
                                    blurRadius: 5)
                              ],
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                children: [
                                  Text(
                                    'Nama',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Expanded(
                                      child: SizedBox(
                                    width: 10,
                                  )),
                                  Text(
                                    'Prodi',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: dataAnggota.length,
                        itemBuilder: (BuildContext context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(left: 30, right: 30),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      //border: Border.all(color: Colors.blue),

                                      //borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            spreadRadius: 1,
                                            blurRadius: 5)
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              dataAnggota[index]['nama'],
                                              overflow:
                                                  TextOverflow.ellipsis,
                                              style:
                                                  TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          const Expanded(
                                              flex: 1,
                                              child: SizedBox(
                                                width: 10,
                                              )),
                                          Text(
                                            dataAnggota[index]['prodi'],
                                            style: TextStyle(fontSize: 20),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                    ],
                    
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//fitur div Silat

class Tenismeja extends StatefulWidget {
  const Tenismeja({super.key});

  @override
  State<Tenismeja> createState() => _TenismejaState();
}

class _TenismejaState extends State<Tenismeja> {
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
                'Tenismeja',
                overflow: TextOverflow.ellipsis,
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 30),
                              child: Image.asset(
                                'divisi/tenismeja.png',
                                width: 265,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 40, right: 10),
                                child: SizedBox(
                                  height: 108,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff9BBBFC),
                                      foregroundColor: Colors.deepPurple,
                                      shadowColor: const Color.fromARGB(
                                          255, 13, 41, 183),
                                      elevation: 8,
                                      padding: EdgeInsets
                                          .zero, // Hapus padding agar gambar bisa memenuhi seluruh area
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),
                                    child: const Text(
                                      'Pengurus',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 45, left: 10),
                                child: SizedBox(
                                  height: 108,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff9BBBFC),
                                      foregroundColor: Colors.deepPurple,
                                      shadowColor: const Color.fromARGB(
                                          255, 13, 41, 183),
                                      elevation: 8,
                                      padding: EdgeInsets
                                          .zero, // Hapus padding agar gambar bisa memenuhi seluruh area
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),
                                    child: const Text(
                                      'Anggota',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
}
//fitur div Tenismeja

class Karate extends StatefulWidget {
  const Karate({super.key});

  @override
  State<Karate> createState() => _KarateState();
}

class _KarateState extends State<Karate> {
    List<dynamic> dataAnggota = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8000/api/pendaftaran/view')); // Ganti URL_API_ANDA dengan URL API yang sesuai

    if (response.statusCode == 200) {
      setState(() {
        final anggotaList = jsonDecode(response.body);
        dataAnggota = anggotaList[0]
            .where((item) =>
                item['status'] == 'terima' &&
                (item['divisi_1'] == 'Karate' || item['divisi_2'] == 'Karate'))
            .toList();
      });
    } else {
      throw 'failed to load data ${response.statusCode}';
    }
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
                'Karate',
                overflow: TextOverflow.ellipsis,
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
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 30, bottom: 30),
                            child: Image.asset(
                              'divisi/karate.png',
                              width: 265,
                            ),
                          ),
                        ],
                      ),
                     const Padding(//========
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      '- anggota -',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.blue, width: 1),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 3,
                                    blurRadius: 5)
                              ],
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                children: [
                                  Text(
                                    'Nama',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Expanded(
                                      child: SizedBox(
                                    width: 10,
                                  )),
                                  Text(
                                    'Prodi',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: dataAnggota.length,
                        itemBuilder: (BuildContext context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(left: 30, right: 30),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      //border: Border.all(color: Colors.blue),

                                      //borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            spreadRadius: 1,
                                            blurRadius: 5)
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              dataAnggota[index]['nama'],
                                              overflow:
                                                  TextOverflow.ellipsis,
                                              style:
                                                  TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          const Expanded(
                                              flex: 1,
                                              child: SizedBox(
                                                width: 10,
                                              )),
                                          Text(
                                            dataAnggota[index]['prodi'],
                                            style: TextStyle(fontSize: 20),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//fitur div Karate

// ignore: camel_case_types
class E_sport extends StatefulWidget {
  const E_sport({super.key});

  @override
  State<E_sport> createState() => _E_sportState();
}

// ignore: camel_case_types
class _E_sportState extends State<E_sport> {
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
                'E-sport',
                overflow: TextOverflow.ellipsis,
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 30),
                              child: Image.asset(
                                'divisi/esport.png',
                                width: 210,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 40, right: 10),
                                child: SizedBox(
                                  height: 108,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff9BBBFC),
                                      foregroundColor: Colors.deepPurple,
                                      shadowColor: const Color.fromARGB(
                                          255, 13, 41, 183),
                                      elevation: 8,
                                      padding: EdgeInsets
                                          .zero, // Hapus padding agar gambar bisa memenuhi seluruh area
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),
                                    child: const Text(
                                      'Pengurus',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 45, left: 10),
                                child: SizedBox(
                                  height: 108,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff9BBBFC),
                                      foregroundColor: Colors.deepPurple,
                                      shadowColor: const Color.fromARGB(
                                          255, 13, 41, 183),
                                      elevation: 8,
                                      padding: EdgeInsets
                                          .zero, // Hapus padding agar gambar bisa memenuhi seluruh area
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),
                                    child: const Text(
                                      'Anggota',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
}
//fitur div E_sport

class Catur extends StatefulWidget {
  const Catur({super.key});

  @override
  State<Catur> createState() => _CaturState();
}

class _CaturState extends State<Catur> {
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
                'Catur',
                overflow: TextOverflow.ellipsis,
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 30),
                              child: Image.asset(
                                'divisi/catur.png',
                                width: 265,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 40, right: 10),
                                child: SizedBox(
                                  height: 108,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff9BBBFC),
                                      foregroundColor: Colors.deepPurple,
                                      shadowColor: const Color.fromARGB(
                                          255, 13, 41, 183),
                                      elevation: 8,
                                      padding: EdgeInsets
                                          .zero, // Hapus padding agar gambar bisa memenuhi seluruh area
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),
                                    child: const Text(
                                      'Pengurus',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 45, left: 10),
                                child: SizedBox(
                                  height: 108,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff9BBBFC),
                                      foregroundColor: Colors.deepPurple,
                                      shadowColor: const Color.fromARGB(
                                          255, 13, 41, 183),
                                      elevation: 8,
                                      padding: EdgeInsets
                                          .zero, // Hapus padding agar gambar bisa memenuhi seluruh area
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),
                                    child: const Text(
                                      'Anggota',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
}
//fitur div Catur

class Tarungderajat extends StatefulWidget {
  const Tarungderajat({super.key});

  @override
  State<Tarungderajat> createState() => _TarungderajatState();
}

class _TarungderajatState extends State<Tarungderajat> {
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
                'Tarung derajat',
                overflow: TextOverflow.ellipsis,
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 30),
                              child: Image.asset(
                                'divisi/tarungderajat.png',
                                width: 300,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 40, right: 10),
                                child: SizedBox(
                                  height: 108,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff9BBBFC),
                                      foregroundColor: Colors.deepPurple,
                                      shadowColor: const Color.fromARGB(
                                          255, 13, 41, 183),
                                      elevation: 8,
                                      padding: EdgeInsets
                                          .zero, // Hapus padding agar gambar bisa memenuhi seluruh area
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),
                                    child: const Text(
                                      'Pengurus',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 45, left: 10),
                                child: SizedBox(
                                  height: 108,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff9BBBFC),
                                      foregroundColor: Colors.deepPurple,
                                      shadowColor: const Color.fromARGB(
                                          255, 13, 41, 183),
                                      elevation: 8,
                                      padding: EdgeInsets
                                          .zero, // Hapus padding agar gambar bisa memenuhi seluruh area
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),
                                    child: const Text(
                                      'Anggota',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
}
//fitur div Tarungderajat

class Taekwondo extends StatefulWidget {
  const Taekwondo({super.key});

  @override
  State<Taekwondo> createState() => _TaekwondoState();
}

class _TaekwondoState extends State<Taekwondo> {
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
                'Taekwondo',
                overflow: TextOverflow.ellipsis,
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 30),
                              child: Image.asset(
                                'divisi/taekwondo.png',
                                width: 200,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 40, right: 10),
                                child: SizedBox(
                                  height: 108,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff9BBBFC),
                                      foregroundColor: Colors.deepPurple,
                                      shadowColor: const Color.fromARGB(
                                          255, 13, 41, 183),
                                      elevation: 8,
                                      padding: EdgeInsets
                                          .zero, // Hapus padding agar gambar bisa memenuhi seluruh area
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),
                                    child: const Text(
                                      'Pengurus',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 45, left: 10),
                                child: SizedBox(
                                  height: 108,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff9BBBFC),
                                      foregroundColor: Colors.deepPurple,
                                      shadowColor: const Color.fromARGB(
                                          255, 13, 41, 183),
                                      elevation: 8,
                                      padding: EdgeInsets
                                          .zero, // Hapus padding agar gambar bisa memenuhi seluruh area
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),
                                    child: const Text(
                                      'Anggota',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
}
//fitur div Taekwondo
