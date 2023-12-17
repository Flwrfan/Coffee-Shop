import 'package:coffee_shop/colors.dart';
import 'package:coffee_shop/home_screen.dart';
import 'package:coffee_shop/services/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuthService _authService = FirebaseAuthService();

  void register() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String fullname = _fullnameController.text;
    String username = _usernameController.text;
    String phoneNumber = _phoneNumberController.text;

    if (email.isEmpty ||
        password.isEmpty ||
        fullname.isEmpty ||
        username.isEmpty ||
        phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Semua bidang harus diisi"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    User? user =
        await _authService.signUpWithEmailAndPassword(email, password, context);

    if (user != null) {
      // Simpan data pengguna ke Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'email': email,
        'fullname': fullname,
        'username': username,
        'phoneNumber': phoneNumber,
        // tambahkan lebih banyak data pengguna jika diperlukan
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Pengguna berhasil dibuat"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Tidak dapat membuat pengguna"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Register",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                hintText: "Email Address",
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            TextField(
              controller: _fullnameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: "Full Name",
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: "Username",
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            TextField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.phone),
                hintText: "Phone Number",
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.key),
                hintText: "Password",
              ),
              obscureText: true,
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 55,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                onPressed: () {
                  register();
                },
                child: const Text(
                  "Daftar",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Sudah punya akun?"),
                const SizedBox(width: 8.0),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: const Text(
                    "Login.",
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _fullnameController.dispose();
    _usernameController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
