class User {
  String namaLogin;
  String nimLogin;
  String emailLogin;
  String prodiLogin;
  String token;
  int iduserLogin;

  String? statuspendaftar;
  String? isAnggota;

  User(
      {required this.iduserLogin,
      required this.namaLogin,
      required this.emailLogin,
      required this.prodiLogin,
      required this.token,
      required this.nimLogin,
      this.statuspendaftar = "kamu belum terdaftar",
      this.isAnggota = "kamu bukan anggota"});

  factory User.fromjson(Map<String, dynamic> data) {
    return User(
        token: data['access_token']['plainTextToken'] as String,
        namaLogin: data['data']['name'] as String,
        nimLogin: data['data']['nim'] as String,
        emailLogin: data['data']['email'] as String,
        prodiLogin: data['data']['prodi'] as String,
        iduserLogin: data['data']['id'] as int);
  }

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> dataLogin = <String, dynamic>{};
    dataLogin['iduserLogin'] = iduserLogin;
    dataLogin['namaLogin'] = namaLogin;
    dataLogin['nimLogin'] = nimLogin;
    dataLogin['emailLogin'] = emailLogin;
    dataLogin['prodiLogin'] = prodiLogin;
    dataLogin['token'] = token;

    dataLogin['statuspendaftar'] = statuspendaftar;
    dataLogin['isAnggota'] = isAnggota;

    return dataLogin;
  }

  factory User.fromjson2(Map<String, dynamic> data) {
    return User(
        token: data['token'] as String,
        namaLogin: data['namaLogin'] as String,
        nimLogin: data['nimLogin'] as String,
        emailLogin: data['emailLogin'] as String,
        prodiLogin: data['prodiLogin'] as String,
        iduserLogin: data['iduserLogin'] as int,
        statuspendaftar: data['statuspendaftar'] as String,
        isAnggota: data['isAnggota'] as String);
  }
}
