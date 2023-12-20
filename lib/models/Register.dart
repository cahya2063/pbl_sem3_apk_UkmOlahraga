class Registermodel {
  int? id;
  String name;
  String nim;
  String prodi;
  String email;
  String password;

  Registermodel(
      {this.id,
      required this.name,
      required this.nim,
      required this.prodi,
      required this.email,
      required this.password});

      factory Registermodel.fromjson(Map<String, dynamic> json){
        return Registermodel(
          id: json['id'] as int,
          name: json['name'] as String,
          nim: json['nim'] as String,
          prodi: json['prodi'] as String,
          email: json['email'] as String,
          password: json['password'] as String,
        );
      }

      Map<String, dynamic> toJson(){
        final Map<String, dynamic> dataregist = <String, dynamic> {};
        dataregist['id'] = id;
        dataregist['name'] = name;
        dataregist['nim'] = nim;
        dataregist['prodi'] = prodi;
        dataregist['email'] = email;
        dataregist['password'] = password;
        return dataregist;
      }
}
