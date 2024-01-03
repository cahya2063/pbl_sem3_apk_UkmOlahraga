import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pblukm/form/borrowform.dart';
import 'package:pblukm/form/oprecform2.dart';
import 'package:pblukm/loginform.dart';
import 'package:pblukm/models/alatmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pblukm/models/borrowmodel.dart';

class Pinjamform extends StatefulWidget {
  const Pinjamform({super.key});

  @override
  State<Pinjamform> createState() => _PinjamformState();
}

class _PinjamformState extends State<Pinjamform> {
  late List<Modelalat> alat = [];

  Future<List<Modelalat>> fetchDataAlat() async {
    var response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/stok/alat'));

    if (response.statusCode == 200) {
      List<dynamic> responseBody = json.decode(response.body);
      List<dynamic> alatList = responseBody[0];
      List<Modelalat> alats =
          alatList.map((item) => Modelalat.fromJson(item)).toList();

      return alats;
    } else {
      throw "tidak bisa ambil data alat ${response.statusCode}";
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataAlat().then((value) {
      setState(() {
        alat = value;
      });
    });
    newPinjam.alatController.text = selectalat;
    //newPinjam.prodiController.text = formloginState.prodiLogin;
  }

  Future<void> addPinjam(Modelborrow pinjam) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/pinjam/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: json.encode(pinjam.tojson()),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      String message = data['message'];
       if (message == 'stok tidak mencukupi') {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Peminjaman gagal'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('berhasil pinjam'),
            content: Text('silahkan ambil di sekret'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      print('berhasil pinjam');

    }
    } else {
      throw "tidak bisa pinjam ${response.statusCode}";
    }
  }




  formPinjam newPinjam = new formPinjam();

  //final _dateController = TextEditingController();
  List<String> jurusan = ['sipil', 'TRM', 'JBI', 'AGB', 'MBP'];
  List<String> kondisi = ['baik', 'kurang', 'rusak'];
  String selectKondisi = 'baik';

  String selectalat = 'bola basket';

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
              padding: EdgeInsets.only(top: 0, bottom: 40),
              child: Text(
                'Form peminjaman',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'PoppinsBold',
                  fontSize: 35,
                ),
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
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 38, left: 35, right: 35),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nama Lengkap',
                          style: TextStyle(
                              fontFamily: 'PoppinsBold', fontSize: 15),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: TextField(
                                    readOnly: true,
                                    controller: newPinjam.namaController,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                      filled: false,
                                      hintText: '${formloginState.namaLogin}',
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                            color: Colors.blue,
                                            width: 2.0,
                                          )),
                                      hintStyle: const TextStyle(
                                          fontFamily: 'Poppins'),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                          color: Colors.blue,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //nama lengkap
                        const Text(
                          'Nim',
                          style: TextStyle(
                              fontFamily: 'PoppinsBold', fontSize: 15),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: TextField(
                                    readOnly: true,
                                    controller: newPinjam.nimController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                      filled: false,
                                      hintText: '${formloginState.nimLogin}',
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                            color: Colors.blue,
                                            width: 2.0,
                                          )),
                                      hintStyle: const TextStyle(
                                          fontFamily: 'Poppins'),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                          color: Colors.blue,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //input NIM
                        const Text(
                          'Prodi',
                          style: TextStyle(
                              fontFamily: 'PoppinsBold', fontSize: 15),
                        ),
                        //text prodi
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: TextField(
                                    readOnly: true,
                                    controller: newPinjam.prodiController,
                                    // onSubmitted: (_) => newoprec.daftar(),

                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                      filled: false,
                                      hintText: '${formloginState.prodiLogin}',
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                            color: Colors.blue,
                                            width: 2.0,
                                          )),
                                      hintStyle: const TextStyle(
                                          fontFamily: 'Poppins'),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                          color: Colors.blue,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //input prodi
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: TextFormField(
                            
                            controller: newPinjam.dateController,
                            decoration: const InputDecoration(
                              hintText: 'Tanggal',
                              filled: true,
                              prefixIcon: Icon(Iconsax.calendar_add5),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                            readOnly: true,
                            onTap: () {
                              _selectDate();
                            },
                          ),
                        ),
                        // input tanggal
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: DropdownButtonFormField<String>(
                            value: selectalat,
                            onChanged: (newvalue) {
                              setState(() {
                                selectalat = newvalue!;
                                newPinjam.alatController.text = selectalat;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'pinjam apa?',
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    width: 2.0,
                                    color: Colors.blue,
                                  )),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                  )),
                              labelStyle:
                                  const TextStyle(fontFamily: 'Poppins'),
                            ),
                            items: alat.map<DropdownMenuItem<String>>(
                                (Modelalat value) {
                              return DropdownMenuItem<String>(
                                value: value.nama,
                                child: Text(
                                  value.nama,
                                  style: const TextStyle(fontFamily: 'Poppins'),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        //dropdown alat
                        const Text(
                          'total peminjaman',
                          style: TextStyle(
                              fontFamily: 'PoppinsBold', fontSize: 15),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: TextField(
                                    controller: newPinjam.jumlahController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                      filled: false,
                                      hintText: 'pinjam berapa?',
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                            color: Colors.blue,
                                            width: 2.0,
                                          )),
                                      hintStyle: const TextStyle(
                                          fontFamily: 'Poppins'),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                          color: Colors.blue,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //input total peminjaman
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 120,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor:
                                        const Color.fromARGB(255, 13, 41, 183),
                                  ),
                                  onPressed: () {
                                    print(newPinjam.namaController);
                                    print(newPinjam.nimController);
                                    print(newPinjam.prodiController);
                                    print(newPinjam.alatController);
                                    print(newPinjam.dateController);
                                    print(newPinjam.jumlahController);
                                    //addPinjam(pinjam)
                                    Modelborrow pinjamBaru =
                                        newPinjam.convertToModel();
                                    addPinjam(pinjamBaru);
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //tombol submit

                        const SizedBox(
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
    );
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(200),
        lastDate: DateTime(2100));
    if (_picked != null) {
      setState(() {
        newPinjam.dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }
}
