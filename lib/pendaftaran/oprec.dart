// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pblukm/form/oprecform2.dart';
// import 'package:pblukm/home.dart';
// import 'package:pblukm/loginform.dart';
import 'package:pblukm/models/oprec.dart';
import 'package:http/http.dart' as http;
import 'package:pblukm/models/divisimodel.dart';
import 'package:pblukm/models/usermodel.dart';
import 'package:pblukm/widget/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Oprec extends StatefulWidget {
  const Oprec({super.key});

  @override
  State<Oprec> createState() => _OprecState();
}

class _OprecState extends State<Oprec> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //late List<oprecmodel> data = [];
  late List<modelDiv> divisi = []; //list untuk tampung data API tabel divisi
  bool isCvUpload = false;

  File? file;
  String filename = '';

  Future<List<modelDiv>> fetchDatadivisi() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/divisi/view'));
    if (response.statusCode == 200) {
      List<dynamic> responseBody = jsonDecode(response.body);

      List<dynamic> divisiList = responseBody[0];

      // Mengonversi setiap item dalam divisiList menjadi objek modelDiv
      List<modelDiv> divisis =
          divisiList.map((item) => modelDiv.fromJson(item)).toList();

      // Mengembalikan daftar modelDiv setelah konversi
      return divisis;
    } else {
      throw "Failed to load data: ${response.statusCode}";
    }
  }

  Future<void> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User userLogin2 =
        User.fromjson2(json.decode(prefs.getString("UserLoginInfo")!));
    setState(() {
      userLogin = userLogin2;
      newoprec.prodiController.text = userLogin!.prodiLogin;
      newoprec.nimController.text = userLogin!.nimLogin;
      newoprec.namaController.text = userLogin!.namaLogin;
      newoprec.emailController.text = userLogin!.emailLogin;

      newoprec.semesterController.text = selectsemester;
      newoprec.divisi_1Controller.text = selctdiv1;
      // print(userLogin.statuspendaftar!);
    });
  }

  User? userLogin;

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
    fetchDatadivisi().then((value) {
      setState(() {
        divisi = value;
      });
    });
  }

  Future<void> _addPerson(oprecmodel person) async {
    bool isValid = formKey.currentState!.validate();
    if (file == null) {
      print('Tidak ada gambar yang dipilih');
      return;
    }

    if (!isCvUpload) {
      return;
    }
    if (!isValid) {
      return;
    }
    // Mengonversi gambar menjadi base64
    String base64Image = base64Encode(file!.readAsBytesSync());
    person.cv = base64Image;

    // Mengirim data ke endpoint API untuk pengunggahan gambar
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/pendaftaran/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(person.tojson()),
    );

    if (response.statusCode == 200) {
      // Logika setelah pengunggahan berhasil
      print('Gambar berhasil diunggah.');
      // Navigator.push(
      //     context, MaterialPageRoute(builder: ((context) => Home())));
      Navigator.pop(context, "menunggu");
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Berhasil daftar '),
              content: Text('terus pantau notifikasimu!!'),
            );
          });
    } else {
      // Penanganan kesalahan jika pengunggahan gagal
      print('Gagal mengunggah gambar: ${response.statusCode}');
      print(response.body);
    }
  }

  oprecform2 newoprec = oprecform2();

  String selctdiv1 = 'Basket';

  String selctdiv2 = 'none';

  List<String> jurusan = ['sipil', 'TRM', 'JBI', 'AGB', 'MBP'];
  String selectjr = 'sipil';
  List<String> semester = ['1', '3'];
  String selectsemester = '1';
  void kembali() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        kembali();
        return true;
      },
      child: Scaffold(
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
                  'Pendaftaran',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'PoppinsBold',
                    fontSize: 35,
                  ),
                ),
              ),
              //teks pendaftaran
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
                  //container putih
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 38, left: 35, right: 35),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: textFieldPendaftaran(
                                      valid: (value) {
                                        if (value!.isEmpty) {
                                          return 'Mana No Hpmu?';
                                        }
                                        return null;
                                      },
                                      controller: newoprec.emailController,
                                      hinText: userLogin!.emailLogin,
                                      tipe: TextInputType.text,
                                      judul: 'Email',
                                      read: true),
                                ),
                              ],
                            ),
                          ),
                          //input email
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: textFieldPendaftaran(
                                      valid: (value) {
                                        if (value!.isEmpty) {
                                          return 'Mana No Hpmu?';
                                        }
                                        return null;
                                      },
                                      controller: newoprec.namaController,
                                      hinText: userLogin!.namaLogin,
                                      tipe: TextInputType.text,
                                      judul: 'Nama Lengkap',
                                      read: true),
                                ),
                              ],
                            ),
                          ),
                          //nama lengkap
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: textFieldPendaftaran(
                                    valid: (value) {
                                      if (value!.isEmpty) {
                                        return 'Mana No Hpmu?';
                                      }
                                      return null;
                                    },
                                    controller: newoprec.nimController,
                                    hinText: userLogin!.nimLogin,
                                    tipe: TextInputType.number,
                                    judul: 'Nim',
                                    read: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //input NIM
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: textFieldPendaftaran(
                                      valid: (value) {
                                        if (value!.isEmpty) {
                                          return 'Mana No Hpmu?';
                                        }
                                        return null;
                                      },
                                      controller: newoprec.prodiController,
                                      hinText: userLogin!.prodiLogin,
                                      tipe: TextInputType.text,
                                      judul: 'Prodi',
                                      read: true),
                                ),
                              ],
                            ),
                          ),
                          //input prodi
                          Form(
                            key: formKey,
                            child: Row(
                              children: [
                                Expanded(
                                  child: textFieldPendaftaran(
                                      controller: newoprec.no_telpController,
                                      hinText: 'Masukkan No Hp',
                                      tipe: TextInputType.number,
                                      judul: 'No Hp',
                                      valid: (value) {
                                        if (value!.isEmpty) {
                                          return 'Mana No Hpmu?';
                                        }
                                        return null;
                                      },
                                      read: false),
                                ),
                              ],
                            ),
                          ),
                          //input no hp
                          const Text(
                            'Semester',
                            style: TextStyle(
                                fontFamily: 'PoppinsBold', fontSize: 15),
                          ),
                          // text semester
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: DropdownButtonFormField<String>(
                              value: selectsemester,
                              onChanged: (newvalue) {
                                setState(() {
                                  selectsemester = newvalue!;
                                  newoprec.semesterController.text =
                                      selectsemester;
                                });
                              },
                              decoration: InputDecoration(
                                // labelText: 'pilihan 1',
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
                              items: semester.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style:
                                        const TextStyle(fontFamily: 'Poppins'),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          //dropdown semester
                          const Text(
                            'CV',
                            style: TextStyle(
                                fontFamily: 'PoppinsBold', fontSize: 15),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Container(
                                    height: 55,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        filename != null
                                            ? Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    filename,
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),
                                                ),
                                              )
                                            : const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 5),
                                                child: Text(
                                                  'gambar cv',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              fromGallery();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 155, 187, 252),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: const Text(
                                              'choose file',
                                              style: TextStyle(fontSize: 20),
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
                          // input gambar
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Divisi',
                              style: TextStyle(
                                  fontFamily: 'PoppinsBold', fontSize: 15),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: DropdownButtonFormField<String>(
                              value: selctdiv1,
                              onChanged: (newvalue) {
                                setState(() {
                                  selctdiv1 = newvalue!;
                                  newoprec.divisi_1Controller.text = selctdiv1;
                                });
                              },
                              decoration: InputDecoration(
                                // labelText: 'pilihan 1',
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
                              items: divisi.map<DropdownMenuItem<String>>(
                                  (modelDiv value) {
                                return DropdownMenuItem<String>(
                                  value: value.nama,
                                  child: Text(
                                    value.nama,
                                    style:
                                        const TextStyle(fontFamily: 'Poppins'),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          //dropdown div 1
                          DropdownButtonFormField<String>(
                            value: selctdiv2,
                            onChanged: (newvalue) {
                              setState(
                                () {
                                  if (newvalue == 'none') {
                                    selctdiv2 = '';
                                  }
                                  selctdiv2 = newvalue!;

                                  newoprec.divisi_2Controller.text = selctdiv2;
                                },
                              );
                            },
                            decoration: InputDecoration(
                              // labelText: 'pilihan 2',
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
                            items: [
                              // Menambahkan opsi "none" secara manual
                              const DropdownMenuItem<String>(
                                value: 'none',
                                child: Text(
                                  'None',
                                  style: TextStyle(fontFamily: 'Poppins'),
                                ),
                              ),
                              // Menggunakan data dari API untuk mengisi pilihan pada dropdown
                              ...divisi.map<DropdownMenuItem<String>>(
                                  (modelDiv value) {
                                return DropdownMenuItem<String>(
                                  value: value.nama,
                                  child: Text(
                                    value.nama,
                                    style:
                                        const TextStyle(fontFamily: 'Poppins'),
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                          //dropdown div 2
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
                                      backgroundColor: const Color.fromARGB(
                                          255, 13, 41, 183),
                                    ),
                                    onPressed: () {
                                      if (!isCvUpload) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Peringatan'),
                                              content: const Text(
                                                  'Anda harus mengunggah CV terlebih dahulu.'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      } else {
                                        print(newoprec.namaController);
                                        print(newoprec.nimController);
                                        print(newoprec.prodiController);
                                        oprecmodel dataBaru =
                                            newoprec.convertToModel();
                                        _addPerson(dataBaru);
                                      }
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
      ),
    );
  }

  Future fromGallery() async {
    // ignore: non_constant_identifier_names
    final PickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery); //mengambil gambar dari source galeri

    setState(() {
      if (PickedFile != null) {
        file = File(PickedFile.path); //mengambil gambar
        filename = file!.path.split('/').last; //mengambil nama file dari path
        isCvUpload = true;
      } else {
        'tidak ada gambar dipilih';
      }
    });
  }
  //untuk ambil gambar dari galeri
}
