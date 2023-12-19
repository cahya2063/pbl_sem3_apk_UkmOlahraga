import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

class Pinjamform extends StatefulWidget {
  const Pinjamform({super.key});

  @override
  State<Pinjamform> createState() => _PinjamformState();
}

class _PinjamformState extends State<Pinjamform> {
  @override
  TextEditingController _dateController = TextEditingController();
  List<String> jurusan = ['sipil', 'TRM', 'JBI', 'AGB', 'MBP'];
  String selectjr = 'sipil';
  List<String> alat = [
    'bola basket',
    'bola futsal',
    'bola takraw',
    'bola volly',
    'sarung tinju',
    'matras',
    'raket',
    'papan catur',
    'shuttle cock'
  ];
  String selectalat = 'bola basket';
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: DropdownButtonFormField<String>(
                            value: selectjr,
                            onChanged: (newvalue) {
                              setState(() {
                                selectjr = newvalue!;
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
                            items: jurusan
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
                        //dropdown jurusan

                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: TextField(
                            controller: _dateController,
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
                            items: alat
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
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
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

                        const Text(
                          'kondisi alat',
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
                                    maxLines: 8,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 10),
                                      filled: false,
                                      hintText: 'bagaimana kondisi alatnya?',
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
                        //deskripsi kondisi alat

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
                                  onPressed: () {},
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
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }
}
