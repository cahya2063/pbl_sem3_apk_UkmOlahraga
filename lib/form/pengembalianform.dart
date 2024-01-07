import 'package:flutter/material.dart';
import 'package:pblukm/loginform.dart';
import 'package:pblukm/models/pengembalianmodel.dart';

class formPengembalian{
  final namaController = TextEditingController();
  final nimController = TextEditingController();
  final prodiController = TextEditingController();
  final nama_barangController = TextEditingController();
  final jml_barangController = TextEditingController();
  final tggl_pinjamController = TextEditingController();
  final tggl_kembaliController = TextEditingController();
  final statusController = TextEditingController();
  
  ModelPengembalian convertToModel(){
    namaController.text = formloginState.namaLogin;
    nimController.text = formloginState.nimLogin;
    prodiController.text = formloginState.prodiLogin;
    ModelPengembalian newPengembalian = ModelPengembalian(
      nama: this.namaController.text, 
      nim: nimController.text, 
      prodi: prodiController.text, 
      nama_barang: nama_barangController.text, 
      jml_barang: int.parse(jml_barangController.text), 
      tggl_pinjam: tggl_pinjamController.text, 
      tggl_kembali: tggl_kembaliController.text, 
      status: statusController.text,);
      return newPengembalian;
  }
}