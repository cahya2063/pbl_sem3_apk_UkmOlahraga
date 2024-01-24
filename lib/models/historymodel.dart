// ignore_for_file: non_constant_identifier_names, camel_case_types

//import 'dart:ffi';

class modelHistory{
  int id;
  String nama;
  String nim;
  String prodi;
  String nama_barang;
  int jml_barang;
  String tggl_pinjam;

  modelHistory({
    required this.id,
    required this.nama,
    required this.nim,
    required this.prodi,
    required this.nama_barang,
    required this.jml_barang,
    required this.tggl_pinjam,
  });

  factory modelHistory.fromJson(Map <String, dynamic> json){
    return modelHistory(
      id: json['id'] as int,
      nama: json['nama'] as String, 
      nim: json['nim'] as String, 
      prodi: json['prodi'] as String, 
      nama_barang: json['nama_barang'] as String, 
      jml_barang: json['jml_barang'] as int, 
      tggl_pinjam: json['tggl_pinjam'] as String,
      );
  }
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> dataHis = <String, dynamic> {};
    dataHis['id'] = id;
    dataHis['nama'] = nama;
    dataHis['nim'] = nim;
    dataHis['pordi'] = prodi;
    dataHis['nama_barang'] = nama_barang;
    dataHis['jml_barang'] = jml_barang;
    dataHis['tggl_pinjam'] = tggl_pinjam;
    return dataHis;
  }
}