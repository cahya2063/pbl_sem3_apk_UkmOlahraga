import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:pblukm/form/borrowform.dart';
import 'package:pblukm/form/pengembalianform.dart';
//import 'package:pblukm/form/oprecform2.dart';
// import 'package:pblukm/loginform.dart';
import 'package:pblukm/models/alatmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// import 'package:pblukm/models/borrowmodel.dart';
import 'package:pblukm/models/pengembalianmodel.dart';
import 'package:pblukm/models/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pengembalianform extends StatefulWidget {
  const Pengembalianform({super.key});

  @override
  State<Pengembalianform> createState() => _PengembalianformState();
}

class _PengembalianformState extends State<Pengembalianform> {
  late List<Modelalat> alat = [];
  File? file;
  String filename = '';
  bool isCvUpload = false;
  User? userLogin;
  String status = '';
  String message = '';
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

  formPengembalian newKembali = formPengembalian();
  Future<void> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User userLogin2 =
        User.fromjson2(json.decode(prefs.getString("UserLoginInfo")!));
    setState(() {
      userLogin = userLogin2;
      newKembali.prodiController.text = userLogin!.prodiLogin;
      newKembali.nimController.text = userLogin!.nimLogin;
      newKembali.namaController.text = userLogin!.namaLogin;
      //newpinjam.emailController.text = userLogin!.emailLogin;

      // print(userLogin.statuspendaftar!);
    });
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
    fetchDataAlat().then((value) {
      setState(() {
        alat = value;
      });
    });
    newKembali.nama_barangController.text = selectalat;
    //newKembali.statusController.text = selectKondisi;
    //newPinjam.prodiController.text = formloginState.prodiLogin;
  }

  Future<void> addPengembalian(ModelPengembalian pengembalian) async {
    if (file == null) {
      print('Tidak ada gambar yang dipilih');
      return;
    }

    if (!isCvUpload) {
      return;
    }
    String base64Image = base64Encode(file!.readAsBytesSync());
    pengembalian.bukti = base64Image;
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/pengembalian/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: json.encode(pengembalian.tojson()),
    );
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> data = json.decode(response.body);
        status = data['status'];
        message = data['message'];
        Navigator.pop(context, ModalRoute.withName('/'));
        if (message == 'data peminjaman tidak ditemukan') {
          dialogNotFound();
        } else if (message == 'jumlah barang yang dikembalikan tidak sesuai') {
          dialogMoreTools();
        } else {
          dialogSucces();
        }
      } catch (e) {
        print('Terjadi kesalahan saat decoding JSON: $e');
        Navigator.popUntil(context, ModalRoute.withName('/'));
        dialogSucces();
      }

      //Navigator.pop(context);
    } else {
      throw "tidak bisa pinjam ${response.statusCode}";
    }
  }

  //formPengembalian newpengembalian = formPengembalian();
  //formPinjam newPinjam = formPinjam();

  //final _dateController = TextEditingController();
  List<String> jurusan = ['sipil', 'TRM', 'JBI', 'AGB', 'MBP'];
  List<String> kondisi = ['baik', 'kurang', 'rusak'];
  String selectKondisi = 'baik';

  String selectalat = 'Bola Basket';

  @override
  Widget build(BuildContext context) {
    newKembali.nama_barangController.text = selectalat;
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
                                    controller: newKembali.namaController,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                      filled: false,
                                      hintText: userLogin!.namaLogin,
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
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: TextField(
                                    readOnly: true,
                                    controller: newKembali.nimController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                      filled: false,
                                      hintText: userLogin!.nimLogin,
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
                                    controller: newKembali.prodiController,
                                    // onSubmitted: (_) => newoprec.daftar(),

                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                      filled: false,
                                      hintText: userLogin!.prodiLogin,
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
                                newKembali.nama_barangController.text =
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
                                    controller: newKembali.jml_barangController,
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
                            controller: newKembali.tggl_pinjamController,
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
                            controller: newKembali.tggl_kembaliController,
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
                        const Text(
                          'Deskripsi',
                          style: TextStyle(
                              fontFamily: 'PoppinsBold', fontSize: 15),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 100,
                                  child: TextField(
                                    keyboardType: TextInputType.multiline,
                                    controller: newKembali.deskripsiController,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                      filled: false,
                                      hintText: 'kondisi alat',
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
                        //nama deskripsi
                        const Text(
                          'Foto alat',
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
                                              padding: EdgeInsets.only(left: 5),
                                              child: Text(
                                                'gambar cv',
                                                style: TextStyle(fontSize: 20),
                                                overflow: TextOverflow.ellipsis,
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
                                    }
                                    //print(newKembali.idController);
                                    print(newKembali.namaController);
                                    print(newKembali.nimController);
                                    print(newKembali.prodiController);
                                    print(newKembali.nama_barangController);
                                    print(newKembali.jml_barangController);
                                    print(newKembali.tggl_pinjamController);
                                    print(newKembali.tggl_kembaliController);
                                    print(newKembali.deskripsiController);
                                    ModelPengembalian pengembalianbaru =
                                        newKembali.convertToModel();
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

  Future<void> _selectDatePinjam() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(200),
        lastDate: DateTime(2100));
    if (_picked != null) {
      setState(() {
        newKembali.tggl_pinjamController.text =
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
        newKembali.tggl_kembaliController.text =
            _picked.toString().split(" ")[0];
      });
    }
  }

  dialogNotFound() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(status),
          content: Text(message),
        );
      },
    );
  }

  dialogMoreTools() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(status),
          content: Text(message),
        );
      },
    );
  }

  dialogSucces() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(status),
          content: Text(message),
        );
      },
    );
  }
}
