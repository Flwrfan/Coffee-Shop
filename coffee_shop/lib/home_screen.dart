// import 'package:coffee_shop/home.dart';
import 'package:coffee_shop/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/tambah_kopi.dart';
import 'package:coffee_shop/login.dart';
import 'package:coffee_shop/profile_screen.dart';
import 'package:coffee_shop/services/firebase_auth_services.dart';

class HomeScreen extends StatefulWidget {
  bool isLoggedIn;
  String? loggedInUsername;
  String? loggedInEmail;

  HomeScreen({
    Key? key,
    required this.isLoggedIn,
    this.loggedInUsername,
    required this.loggedInEmail,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuthService _authService = FirebaseAuthService();
  late List<Map<String, dynamic>> books = [];
  int _selectedIndex = 0;

  List<Widget> _pages = [];

  List<String> categories = [
    "Arabika",
    "Robusta",
    "Espresso",
    "Amerikano",
    "Mocca",
    "Latte",
    "Cappucino",
  ];

  Future<QuerySnapshot<Map<String, dynamic>>> fetchData(String category) async {
    return FirebaseFirestore.instance.collection(category.toLowerCase()).get();
  }

  @override
  void initState() {
    super.initState();
    _getUserDetails();
    fetchBooks();
    _pages = [
      _buildHomePage(),
      ProfilePage(),
      TambahKopiPage(),
    ];
  }

  Future<void> _getUserDetails() async {
    User? user = await _authService.getCurrentUser();

    if (user != null) {
      setState(() {
        widget.loggedInEmail = user.email;
      });
    }
  }

  Future<void> fetchBooks() async {
    for (String category in categories) {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await fetchData(category);
      setState(() {
        books.addAll(querySnapshot.docs.map((doc) => doc.data()).toList());
      });
    }
  }

  Widget buildHomeContent() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Coffee Shop',
          style: TextStyle(fontSize: 17.5),
        ),
        backgroundColor: Color.fromARGB(255, 10, 5, 1),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tambahkan kode UI dari widget Home di sini
            // Pastikan untuk menyesuaikan kontennya dengan tampilan yang diinginkan
          ],
        ),
      ),
    );
  }

  Widget _buildHomePage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigasi ke halaman Home saat tombol ditekan
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            child: Text('Temukan Kopimu !'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Coffee Shop',
          style: TextStyle(fontSize: 17.5),
        ),
        backgroundColor: Color.fromARGB(255, 10, 5, 1),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Tambah Buku',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Color.fromARGB(255, 10, 5, 1),
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    if (index == 3) {
      _showLogoutConfirmationDialog(context);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Logout'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Apakah Anda ingin keluar?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Ya'),
              onPressed: () {
                _logout(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _logout(BuildContext context) {
    setState(() {
      widget.isLoggedIn = false;
      widget.loggedInUsername = null;
    });
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => Login(),
    ));
  }
}
