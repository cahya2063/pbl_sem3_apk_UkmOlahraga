class modelJadwal {
  int? id;
  String hari;
  int? divisi_id;
  String waktu_mulai;
  String waktu_selesai;

  modelJadwal(
      {this.id,
      required this.hari,
      this.divisi_id,
      required this.waktu_mulai,
      required this.waktu_selesai});

      factory modelJadwal.fromjson(Map<String, dynamic> json){
        return modelJadwal(
          id: json['id'] as int,
          hari: json['hari'] as String,
          divisi_id: json['divisi_id'] as int,
          waktu_mulai: json['waktu_mulai'] as String,
          waktu_selesai: json['waktu_selesai'] as String,
        );
      }

      Map<String, dynamic> tojson(){
        final Map<String,dynamic> datajadwal = <String, dynamic>{};
        datajadwal['id'] = id;
        datajadwal['hari'] = hari;
        datajadwal['divisi_id'] = divisi_id;
        datajadwal['waktu_mulai'] = waktu_mulai;
        datajadwal['waktu_selesai'] = waktu_selesai;
        return datajadwal;
      }
}
