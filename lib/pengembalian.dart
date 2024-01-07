import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pblukm/form/borrowform.dart';
import 'package:pblukm/form/pengembalianform.dart';
//import 'package:pblukm/form/oprecform2.dart';
import 'package:pblukm/loginform.dart';
import 'package:pblukm/models/alatmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pblukm/models/borrowmodel.dart';
import 'package:pblukm/models/pengembalianmodel.dart';

class Pengembalianform extends StatefulWidget {
  const Pengembalianform({super.key});

  @override
  State<Pengembalianform> createState() => _PengembalianformState();
}

class _PengembalianformState extends State<Pengembalianform> {
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
    newpengembalian.nama_barangController.text = selectalat;
    newpengembalian.statusController.text = selectKondisi;
    //newPinjam.prodiController.text = formloginState.prodiLogin;
  }

  Future<void> addPengembalian(ModelPengembalian pengembalian) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/pengembalian/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: json.encode(pengembalian.tojson()),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      String status = data['status'];
      String message = data['message'];
      if (message == 'data peminjaman tidak ditemukan') {
        if (mounted) {
          setState(() {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(status),
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
          });
        }
      } else if(message == 'jumlah barang yang dikembalikan tidak sesuai'){
        if (mounted) {
          setState(() {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(status),
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
          });
        }
      }
      else{
        if (mounted) {
          setState(() {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(status),
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
          });
        }
      }
      //Navigator.pop(context);
    } else {
      throw "tidak bisa pinjam ${response.statusCode}";
    }
  }

  formPengembalian newpengembalian = formPengembalian();
  //formPinjam newPinjam = formPinjam();

  //final _dateController = TextEditingController();
  List<String> jurusan = ['sipil', 'TRM', 'JBI', 'AGB', 'MBP'];
  List<String> kondisi = ['baik', 'kurang', 'rusak'];
  String selectKondisi = 'baik';

  String selectalat = 'bola basket';

  @override
  Widget build(BuildContext context) {
    newpengembalian.nama_barangController.text = selectalat;
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
                'Form Pengembalian',
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
                                    controller: newpengembalian.namaController,
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
                                    controller: newpengembalian.nimController,
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
                                    controller: newpengembalian.prodiController,
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
                          child: DropdownButtonFormField<String>(
                            value: selectalat,
                            onChanged: (newvalue) {
                              setState(() {
                                selectalat = newvalue!;
                                newpengembalian.nama_barangController.text =
                                    selectalat;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'kembalikan apa?',
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
                          'total pengembalian',
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
                                  child: TextFormField(
                                    controller:
                                        newpengembalian.jml_barangController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                      filled: false,
                                      hintText: 'kembalikan berapa?',
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
                          padding: const EdgeInsets.only(bottom: 20),
                          child: TextField(
                            controller: newpengembalian.tggl_pinjamController,
                            decoration: const InputDecoration(
                              hintText: 'Tanggal Pinjam',
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
                              _selectDatePinjam();
                            },
                          ),
                        ),
                        // input tanggal pinjam
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: TextField(
                            controller: newpengembalian.tggl_kembaliController,
                            decoration: const InputDecoration(
                              hintText: 'Tanggal Kembali',
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
                              _selectDatePengembalian();
                            },
                          ),
                        ),
                        // input tanggal kembali
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: DropdownButtonFormField<String>(
                            value: selectKondisi,
                            onChanged: (newvalue) {
                              setState(() {
                                selectKondisi = newvalue!;
                                newpengembalian.statusController.text =
                                    selectalat;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'kondisi alat',
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
                            items: kondisi
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style:
                                        const TextStyle(fontFamily: 'Poppins'),
                                  ));
                            }).toList(),
                          ),
                        ),
                        //dropdown alat
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
                                    print(newpengembalian.namaController);
                                    print(newpengembalian.nimController);
                                    print(newpengembalian.prodiController);
                                    print(
                                        newpengembalian.nama_barangController);
                                    print(newpengembalian.jml_barangController);
                                    print(
                                        newpengembalian.tggl_pinjamController);
                                    print(
                                        newpengembalian.tggl_kembaliController);
                                    print(newpengembalian.statusController);
                                    ModelPengembalian pengembalianbaru =
                                        newpengembalian.convertToModel();
                                    addPengembalian(pengembalianbaru);
                                    //Navigator.pop(context);
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

  Future<void> _selectDatePinjam() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(200),
        lastDate: DateTime(2100));
    if (_picked != null) {
      setState(() {
        newpengembalian.tggl_pinjamController.text =
            _picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> _selectDatePengembalian() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(200),
        lastDate: DateTime(2100));
    if (_picked != null) {
      setState(() {
        newpengembalian.tggl_kembaliController.text =
            _picked.toString().split(" ")[0];
      });
    }
  }
}
