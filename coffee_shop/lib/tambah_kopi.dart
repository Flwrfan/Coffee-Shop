import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TambahKopiPage extends StatefulWidget {
  @override
  _TambahKopiPageState createState() => _TambahKopiPageState();
}

class _TambahKopiPageState extends State<TambahKopiPage> {
  final TextEditingController kopiController = TextEditingController();
  final TextEditingController ukuranController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();

  String selectedCategory = 'Cappuccino'; // Kategori default
  String selectedSize = 'Reguler'; // Ukuran default

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> tambahKopi() async {
    try {
      // Menambahkan data kopi ke koleksi Firebase Firestore dengan ID unik yang dibuat secara otomatis
      await _firestore.collection(selectedCategory).add({
        'tambah_kopi': kopiController.text,
        'ukuran': ukuranController.text,
        'deskripsi': deskripsiController.text,
        'harga': (hargaController.text),
      });

      // Membersihkan teks pada input setelah menambahkan data
      kopiController.clear();
      ukuranController.clear();
      deskripsiController.clear();
      hargaController.clear();

      // Menampilkan pesan sukses atau melakukan navigasi ke layar lain
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data kopi berhasil ditambahkan'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      // Menangani kesalahan
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan, coba lagi nanti'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Tambah Kopi',
      //     style: TextStyle(fontSize: 18),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                value: selectedCategory,
                items: [
                  'Cappuccino',
                  'Espresso',
                  'Latte',
                  'Americano',
                ].map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
              ),
              TextFormField(
                controller: kopiController,
                decoration: InputDecoration(labelText: 'Nama Kopi'),
              ),
              TextFormField(
                controller: ukuranController,
                decoration: InputDecoration(labelText: 'Ukuran'),
              ),
              TextFormField(
                controller: deskripsiController,
                decoration: InputDecoration(labelText: 'Deskripsi'),
                maxLines: 3,
              ),
              TextFormField(
                controller: hargaController,
                decoration: InputDecoration(labelText: 'Harga'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: tambahKopi,
                child: Text('Tambah Kopi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
