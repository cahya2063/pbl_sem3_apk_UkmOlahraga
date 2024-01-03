class Modelalat{
  String nama;
  int stok;

  Modelalat({required this.nama, required this.stok});

  factory Modelalat.fromJson(Map<String, dynamic> json){
    return Modelalat(
      nama: json['nama_barang'] as String, 
      stok: json['stok'] as int);
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> dataAlat = <String, dynamic> {};
    dataAlat['nama_barang'] = nama;
    dataAlat['stok'] = stok;
    return dataAlat;
  }
}