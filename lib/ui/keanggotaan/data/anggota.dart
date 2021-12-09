class Anggota {
  String nama;
  String nomorHp;
  String alamat;
  DateTime tanggalLahir;
  DateTime tanggalBergabung;
  String jenisKelamin;
  String nik;
  String pekerjaan;

  Anggota({
    this.nama = '',
    this.nomorHp = '',
    this.alamat = '',
    required this.tanggalLahir,
    required this.tanggalBergabung,
    this.jenisKelamin = '',
    this.nik = '',
    this.pekerjaan = '',
  });
}
