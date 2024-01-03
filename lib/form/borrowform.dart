import 'package:flutter/material.dart';
import 'package:pblukm/loginform.dart';
import 'package:pblukm/models/borrowmodel.dart';
import 'package:pblukm/models/oprec.dart';

class formPinjam{
  
  final namaController = TextEditingController();
  final nimController = TextEditingController();
  final prodiController = TextEditingController();
  final dateController = TextEditingController();
  final alatController = TextEditingController();
  final jumlahController = TextEditingController();
  //final kondisiController = TextEditingController();

  //int? jumlahAlat = int.tryParse(jumlahController.text);
  Modelborrow convertToModel(){
    //String tanggal = dateController.text;
    
    namaController.text = formloginState.namaLogin;
    nimController.text = formloginState.nimLogin;
    prodiController.text = formloginState.prodiLogin;
    
    Modelborrow newborrow = Modelborrow(
      nama: this.namaController.text, 
      nim: this.nimController.text, 
      prodi: this.prodiController.text, 
      nama_barang: this.alatController.text, 
      jml_barang: int.tryParse(jumlahController.text), 
      tggl_pinjam: dateController.text,
      
      );
      
      return newborrow;

  }
  
}