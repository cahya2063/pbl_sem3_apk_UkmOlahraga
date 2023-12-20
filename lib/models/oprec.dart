import 'dart:ffi';

import 'package:flutter/material.dart';

class oprecmodel {
  int? id;
  String nama;
  String nim;
  String prodi;
  String email;
  String no_telp;
  String? cv; // boleh null
  String divisi_1;
  String? divisi_2; // boleh null
  String? jabatan;
  String? status;

  oprecmodel({
    this.id,
    required this.nama,
    required this.nim,
    required this.prodi,
    required this.email,
    required this.no_telp,
    this.cv,
    required this.divisi_1,
    this.divisi_2,
    this.jabatan,
    this.status,
  });

  factory oprecmodel.fromjson(Map<String, dynamic> json) {
    return oprecmodel(
        id: json['id'] as int,
        nama: json['nama'] as String,
        nim: json['nim'] as String,
        prodi: json['prodi'] as String,
        email: json['email'] as String,
        no_telp: json['no_telp'] as String,
        cv: json['cv'],
        divisi_1: json['divisi_1'] as String,
        divisi_2: json['divisi_2'] ,
        jabatan: json['jabatan'] as String,
        status: json['status'] as String);
  }
  Map<String, dynamic> tojson() {
    final Map<String, dynamic> dataoprec = <String, dynamic>{};
    dataoprec['id'] = id;
    dataoprec['nama'] = nama;
    dataoprec['nim'] = nim;
    dataoprec['prodi'] = prodi;
    dataoprec['email'] = email;
    dataoprec['no_telp'] = no_telp;
    dataoprec['cv'] = cv;
    dataoprec['divisi_1'] = divisi_1;
    dataoprec['divisi_2'] = divisi_2;
    dataoprec['jabatan'] = jabatan;
    dataoprec['status'] = status;

    return dataoprec;
  }
}
