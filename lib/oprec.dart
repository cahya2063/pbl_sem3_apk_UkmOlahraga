import 'dart:convert';
import 'dart:io';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pblukm/form/oprecform.dart';
import 'package:pblukm/form/oprecform2.dart';
import 'package:pblukm/models/oprec.dart';
import 'package:http/http.dart' as http;

class Oprec extends StatefulWidget {
  // final Function(oprecmodel) addOprec;
  // const Oprec(this.addOprec, {super.key});
  const Oprec({super.key});

  @override
  State<Oprec> createState() => _OprecState();
}

class _OprecState extends State<Oprec> {
  late List<oprecmodel> data = [];

  Future<List<oprecmodel>> fetchData() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/anggota/view'));
    if (response.statusCode == 200) {
      // Map<String, dynamic> responseBody = json.decode(response.body);
      // List<dynamic> divisiList = responseBody['data'];

      List<dynamic> responseBody = json.decode(response.body);
      List<dynamic> divisiList = responseBody.elementAt(0);

      // Mengonversi setiap item dalam daftar menjadi objek modelDiv
      List<oprecmodel> oprec =
          divisiList.map((item) => oprecmodel.fromjson(item)).toList();

      // Mengembalikan daftar modelDiv setelah konversi
      return oprec;
    } else {
      throw "Failed to load data: ${response.statusCode}";
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData().then((value) {
      setState(() {
        data = value;
      });
    });

    newoprec.prodiController.text = selectjr;
    newoprec.divisi_1Controller.text = selctdiv1;
  }

  Future<void> _addPerson(oprecmodel person) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/anggota/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(person.tojson()),
    );
    if (response.statusCode == 200) {
      fetchData().then((value) {
        setState(() {
          data = value;
        });
      });
    } else {
      print(response.body);
      throw "Failed to add data";
    }
  }

  
  oprecform2 newoprec = oprecform2();
  

  List<String> jurusan = ['sipil', 'TRM', 'JBI', 'AGB', 'MBP'];
  String selectjr = 'sipil';

  List<String> div1 = ['basket', 'futsal', 'badminthon', 'catur', 'taekwondo'];
  String selctdiv1 = 'basket';
  List<String> div2 = [
    'none',
    'basket',
    'futsal',
    'badminthon',
    'catur',
    'taekwondo'
  ];
  String selctdiv2 = 'none';
  File? file;
  String filename = '';
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
                  'Recruitment',
                  textAlign: TextAlign.center,
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
                    padding:
                        const EdgeInsets.only(top: 38, left: 35, right: 35),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Email',
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
                                      controller: newoprec.emailController,
                                      // onSubmitted: (_) => newoprec.daftar(),
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        filled: false,
                                        hintText: 'masukkan Emailmu!',
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
                                          borderRadius:
                                              BorderRadius.circular(15),
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
                          //input email
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
                                      controller: newoprec.namaController,
                                      // onSubmitted: (_) => newoprec.daftar(),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        filled: false,
                                        hintText: 'masukkan Namamu!',
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
                                          borderRadius:
                                              BorderRadius.circular(15),
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
                                      controller: newoprec.nimController,
                                      // onSubmitted: (_) => newoprec.daftar(),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        filled: false,
                                        hintText: 'masukkan Nimmu!',
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
                                          borderRadius:
                                              BorderRadius.circular(15),
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
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: DropdownButtonFormField<String>(
                              value: selectjr,
                              onChanged: (newvalue) {
                                setState(() {
                                  selectjr = newvalue!;
                                  newoprec.prodiController.text = selectjr;
                                });
                              },
                              decoration: InputDecoration(
                                labelText: 'Jurusanmu!',
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
                              items: jurusan.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: const TextStyle(
                                          fontFamily: 'Poppins'),
                                    ));
                              }).toList(),
                            ),
                          ),
                          //dropdown jurusan
                          const Text(
                            'No Hp',
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
                                      controller: newoprec.no_telpController,
                                      // onSubmitted: (_) => newoprec.daftar(),
                                      keyboardType: TextInputType.phone,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        filled: false,
                                        hintText: 'masukkan NoHp!',
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
                                          borderRadius:
                                              BorderRadius.circular(15),
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
                          //input no hp
                          const Text(
                            'CV',
                            style: TextStyle(
                                fontFamily: 'PoppinsBold', fontSize: 15),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
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
                                                    '$filename',
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
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: DropdownButtonFormField<String>(
                              value: selctdiv1,
                              onChanged: (newvalue) {
                                setState(() {
                                  selctdiv1 = newvalue!;
                                  newoprec.divisi_1Controller.text = selctdiv1;
                                });
                              },
                              decoration: InputDecoration(
                                labelText: 'pilihan 1',
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
                              items: div1.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: const TextStyle(
                                          fontFamily: 'Poppins'),
                                    ));
                              }).toList(),
                            ),
                          ),
                          //dropdown div 1
                          DropdownButtonFormField<String>(
                            value: selctdiv2,
                            onChanged: (newvalue) {
                              setState(
                                () {
                                  selctdiv2 = newvalue!;
                                  if (selctdiv2 == div2[0]) {
                                    return null;
                                  }
                                },
                              );
                            },
                            decoration: InputDecoration(
                              labelText: 'pilihan 2',
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
                            items: div2
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
                                      // oprecform((p0) => _addPerson(p0));
                                      print("test");
                                      print(newoprec.namaController.text);

                                      oprecmodel dataBaru =
                                          newoprec.convertToModel();
                                      _addPerson(dataBaru);

                                      // oprecmodel dummy = oprecmodel(
                                      //     nama: "coba",
                                      //     nim: "123",
                                      //     prodi: "trpl",
                                      //     email: "asd@gmail.com",
                                      //     no_telp: "123",
                                      //     divisi_1: "badminton");
                                      // _addPerson(dummy);
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
      } else {
        'tidak ada gambar dipilih';
      }
    });
  }
  //untuk ambil gambar dari galeri
}
