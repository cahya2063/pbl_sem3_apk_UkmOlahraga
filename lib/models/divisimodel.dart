class modelDiv {
  int? id;
  String nama;

  modelDiv({required this.nama, this.id});

  factory modelDiv.fromJson(Map<String, dynamic> json) {
    return modelDiv(
      nama: json['nama'] as String,
      id: json['id'] as int,
      );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> datadiv = <String, dynamic>{};
    datadiv['nama'] = nama;
    datadiv['id'] = id;
    return datadiv;
  }
}
