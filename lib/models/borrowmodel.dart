class Modelborrow{
  
  String nama;
  String nim;
  String prodi;
  String nama_barang;
  int? jml_barang;
  String tggl_pinjam;
  String? bukti;

  Modelborrow({
    required this.nama,
    required this.nim,
    required this.prodi,
    required this.nama_barang,
    this.jml_barang,
    required this.tggl_pinjam,
    this.bukti,
    });

    factory Modelborrow.fromJson(Map <String, dynamic> json){
      return Modelborrow(
        nama: json['nama'] as String, 
        nim: json['nim'] as String, 
        prodi: json['prodi'] as String, 
        nama_barang: json['nama_barang'] as String, 
        jml_barang: json['jml_barang'] as int, 
        tggl_pinjam: json['tggl_pinjam'] as String,
        bukti: json['bukti'] as String,
        );
    }

    Map <String, dynamic> tojson(){
      final Map <String, dynamic> dataPinjam = <String, dynamic> {};
      dataPinjam['nama'] = nama;
      dataPinjam['nim'] = nim;
      dataPinjam['prodi'] = prodi;
      dataPinjam['nama_barang'] = nama_barang;
      dataPinjam['jml_barang'] = jml_barang;
      dataPinjam['tggl_pinjam'] = tggl_pinjam;
      dataPinjam['bukti'] = bukti;
      return dataPinjam;
    }
}