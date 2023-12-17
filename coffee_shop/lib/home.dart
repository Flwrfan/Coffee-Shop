import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/deskripsi.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> categories = [
    "Arabika",
    "Robusta",
    "Espresso",
    "Amerikano",
    "Mocca",
    "Latte",
    "Cappucino",
  ];

  String searchQuery = '';
  String selectedCategory = '';

  Future<QuerySnapshot<Map<String, dynamic>>> fetchData(String category) async {
  QuerySnapshot<Map<String, dynamic>> snapshot;

     if (searchQuery.isNotEmpty) {
    snapshot = await FirebaseFirestore.instance
        .collection(category)
        .where('nama', isGreaterThanOrEqualTo: searchQuery)
        .get();
  } else {
    snapshot = await FirebaseFirestore.instance.collection(category).get();
  }

  return snapshot;
}

  Widget buildCoffeeContainer(
  BuildContext context,
  Map<String, dynamic> coffeeData,
  String selectedCategory,
) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DescPage(
            nama: coffeeData['nama'] ,
            deskripsi: coffeeData['description'] ,
            gambar: coffeeData['gambar'] ,
            ukuran: coffeeData['ukuran'] ,
            harga: coffeeData['harga'],
            jumlah: coffeeData['jumlah'] ,
            category: selectedCategory,
          ),
        ),
      );
    },
      child: Container(
        width: MediaQuery.of(context).size.width / 2.1,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.orange[800],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Container(
              height: 170,
              width: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  coffeeData['gambar'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    coffeeData['nama'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "\Rp ${coffeeData['harga']}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    coffeeData['deskripsi'] != null
                        ? "${coffeeData['deskripsi'].split('.').take(1).join('.')}."
                        : "Deskripsi tidak tersedia",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Toko Kopi Sederhana',
          style: TextStyle(fontSize: 17.5),
        ),
        backgroundColor: Colors.orange[800],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: InkWell(
                  onTap: () {
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                   
                  ),
                ),
              ),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Temukan Kopi Untukmu",
                style: TextStyle(
                  color: Colors.orange[800],
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.all(10),
              height: 55,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.orange[800],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.black45,
                    size: 35,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    height: 55,
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: Center(
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Cari Kopi ...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
              children: [
                for (int i = 0; i < categories.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedCategory = categories[i];
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: selectedCategory == categories[i]
                            ? Colors.orange[400]
                            : Colors.black,
                      ),
                      child: Text(
                        categories[i],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < categories.length; i++)
                      FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        future: fetchData(categories[i]),
                        builder: (context, snapshot) {
                          if (selectedCategory!.isNotEmpty &&
                              categories[i] != selectedCategory) {
                            return SizedBox();
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Text('Tidak ada Kopi yang dicari');
                          } else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Text(
                                    categories[i],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 180 +
                                      310 * (snapshot.data!.docs.length - 2),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          for (int index = 0;
                                              index < 2;
                                              index++)
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                               child: GestureDetector(
                                                  onTap: () {
                                                    var coffeeData = snapshot.data!.docs[index].data();
                                                    
                                                    
                                                    Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => DescPage(


                                                      nama: coffeeData['nama'] ,
                                                      deskripsi: coffeeData['description'] ,
                                                      gambar: coffeeData['gambar'] ,
                                                      ukuran: coffeeData['ukuran'] ,
                                                      harga: coffeeData['harga'],
                                                      jumlah: coffeeData['jumlah'] ,
                                                      category: selectedCategory,
                                                    ),
                                                  ),
                                                );
                                                    },
                                                  child: Container(
                                                    height: 180,
                                                    decoration: BoxDecoration(
                                                      color: Colors.orange[800],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            child: Image.network(
                                                              snapshot.data!
                                                                  .docs[index]
                                                                  .data()['image'],
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                snapshot.data!
                                                                        .docs[index]
                                                                        .data()[
                                                                    'title'],
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  letterSpacing:
                                                                      1,
                                                                ),
                                                              ),
                                                              
                                                              SizedBox(
                                                                  height: 5),
                                                             Text(
                                                                "\Rp ${snapshot.data!.docs[index].data()['price']}",
                                                                style: TextStyle(
                                                                  color: Colors.black,
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),


                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      // Jarak vertikal antara kontainer
                                      Expanded(
                        
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length - 2,
                              itemBuilder: (context, index) {
                                var coffeeData = snapshot.data!.docs[index + 2].data();
                                return GestureDetector(
                                 onTap: () {
                                           // Ganti dengan kategori yang sesuai
                                          
                                          Navigator.push(
                                            context,
                                             MaterialPageRoute(
                                                    builder: (context) => DescPage(
                                                      nama: coffeeData['nama'],
                                                      deskripsi: coffeeData['description'] ,
                                                      gambar: coffeeData['gambar'] ,
                                                      ukuran: coffeeData['ukuran'] ,
                                                      harga: coffeeData['harga'],
                                                      jumlah: coffeeData['jumlah'] ,
                                                      category: selectedCategory,
                                                    ),
                                                  ),
                                          );
                                        },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 2.1,
                                    padding: const EdgeInsets.all(8),
                                    margin: const EdgeInsets.symmetric(horizontal: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.orange[800],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 170,
                                          width: 120,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: Image.network(
                                              coffeeData['gambar'],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                coffeeData['nama'],
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                "\Rp ${snapshot.data!.docs[index].data()['harga']}",
                                                style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                 fontWeight: FontWeight.bold,
                                                ),
                                                ),
                                              SizedBox(height: 5),
                                              Text(
                                                coffeeData['description'] != null
                                                  ? "${coffeeData['description'].split('.').take(1).join('.')}."
                                                  : "Deskripsi tidak tersedia",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                          ),
                                       
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          
                        ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                // Jarak vertikal antara setiap kategori
                              ],
                            );
                          }
                        },
                      ),
                  ],
                ),
              ),
          ),
          ],
        ),
      ),
    );
  }
}