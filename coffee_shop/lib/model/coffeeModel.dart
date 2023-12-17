import 'dart:convert';

coffeeModel ceritaFromJson(String str) => coffeeModel.fromJson(json.decode(str));
String ceritaToJson(coffeeModel data) => json.encode(data.toJson());

class coffeeModel {
  final String deskripsi;
  final String gambar;
  final String harga;
  final String jenis;
  final String jumlah;
  final String nama;
  final String ukuran;
  coffeeModel({
    required this.deskripsi,
    required this.gambar,
    required this.harga,
    required this.jenis,
    required this.jumlah,
    required this.nama,
    required this.ukuran,
  });
  factory coffeeModel.fromJson(Map<String, dynamic> json) => coffeeModel(
        deskripsi: json["deskripsi"],
        gambar: json["gambar"],
        harga: json["harga"],
        jenis: json["jenis"],
        jumlah: json["jumlah"],
        nama: json["nama"],
        ukuran: json["ukuran"]
      );
  Map<String, dynamic> toJson() => {
        "deskripsi": deskripsi,
        "gambar": gambar,
        "harga": harga,
        "jenis": jenis,
        "jumlah": jumlah,
        "nama": nama,
        "ukuran": ukuran
      };
}