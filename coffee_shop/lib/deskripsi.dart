import 'package:flutter/material.dart';

class DescPage extends StatelessWidget {
  final String nama;
  final String category;
  final String gambar;
  final String ukuran;
  final String deskripsi;
  final String harga;
  final String jumlah;

  DescPage({
    required this.nama,
    required this.category,
    required this.gambar,
    required this.ukuran,
    required this.deskripsi,
    required this.harga,
    required this.jumlah, 
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Deskripsi Kopi',
          style: TextStyle(fontSize: 17.5),
        ),
        backgroundColor: Color.fromARGB(255, 10, 5, 1),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                gambar,
                height: 200,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Nama Kopi: $nama',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Jenis Kopi: $category',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Ukuran Kopi: $ukuran',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Harga Kopi: $harga',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Jumlah Kopi: $jumlah',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Deskripsi:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              deskripsi,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}