class ModelPengembalian{
  String nama;
  String nim;
  String prodi;
  String nama_barang;
  int jml_barang;
  String tggl_pinjam;
  String tggl_kembali;
  String status;
  String? image;

  ModelPengembalian({
    required this.nama,
    required this.nim,
    required this.prodi,
    required this.nama_barang,
    required this.jml_barang,
    required this.tggl_pinjam,
    required this.tggl_kembali,
    required this.status,
    this.image,
  });
  factory ModelPengembalian.fromJson(Map <String, dynamic> json){
    return ModelPengembalian(
      nama: json['nama'] as String, 
      nim: json['nim'] as String, 
      prodi: json['prodi'] as String, 
      nama_barang: json['nama_barang'] as String, 
      jml_barang: json['jml_barang'] as int, 
      tggl_pinjam: json['tggl_pinjam'] as String, 
      tggl_kembali: json['tggl_kembali'] as String, 
      status: json['status'] as String, 
      image: json['image'] as String,
      );
  }
  Map <String, dynamic> tojson(){
    final Map <String, dynamic> data = <String,dynamic> {};
    data['nama'] = nama;
    data['nim'] = nim;
    data['prodi'] = prodi;
    data['nama_barang'] = nama_barang;
    data['jml_barang'] = jml_barang;
    data['tggl_pinjam'] = tggl_pinjam;
    data['tggl_kembali'] = tggl_kembali;
    data['status'] = status;
    data['image'] = image;
    return data;
  }
}