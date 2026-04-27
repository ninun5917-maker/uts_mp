import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>(); // Untuk ngontrol valdasi semua form
  final _emailController =
      TextEditingController(); // Untuk ngambil teks yang di ketik di form email
  final _passwordController =
      TextEditingController(); // Untuk ngambil teks yang di password

  bool _isLoading = false; // Untuk munculin animasi loading
  bool _isPasswordVisible = false; // Untuk bisa lihat dan tidak password

  // Fungsi tombol login
  void _login() async {
    if (_formKey.currentState!.validate()) {
      // Memeriksa input
      setState(() => _isLoading = true); // Aktifkan mode loading

      // Simulasi animasi loading nya
      await Future.delayed(const Duration(seconds: 2));

      // Mengecek Credential admin@test.com / Admin123
      if (_emailController.text == "admin@test.com" &&
          _passwordController.text == "Admin123") {
        if (!mounted) return; // Mastiin wiget masih ada sebelum navigasi jalan
        context.read<AuthProvider>().login(
          _emailController.text,
        ); // Menyimpan email ke Provider

        setState(
          () => _isLoading = false,
        ); // Stop mode loading kalo udah sukses
        Navigator.pushReplacementNamed(
          context,
          '/dashboard',
        ); // Pindah dashboard & hpus Hystory lgn nya
      } else {
        // Kalo salah loading mati. notif error muncul
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email atau Password Salah!"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Praktikum")),
      body: Center(
        child: SingleChildScrollView(
          // Agar Konten bisa di Scroll saat muncul Keyboard
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey, // Ngubungin form sama globalkey
            child: Column(
              children: [
                // Buat nampilin icon kunci
                const Icon(Icons.lock_person, size: 80, color: Colors.blue),
                const SizedBox(height: 20),

                // Tempat masukin email
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  // Ngecek format email pake REGEX
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Email wajib diisi';
                    // Regex format email
                    final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(value);
                    return emailValid ? null : "Format email tidak valid";
                  },
                ),
                const SizedBox(height: 15),

                // Tempat masukin password
                TextFormField(
                  controller: _passwordController,
                  obscureText:
                      !_isPasswordVisible, // buat hide teks password nya
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    // Untuk tombol mata
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () => setState(
                        () => _isPasswordVisible = !_isPasswordVisible,
                      ),
                    ),
                  ),
                  // Ngecek password (Min 8 karakter, Huruf + Angka)
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Password wajib diisi';
                    if (value.length < 8) return 'Minimal 8 karakter';
                    // Regex Huruf dan Angka (Pengecekan)
                    if (!RegExp(
                      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
                    ).hasMatch(value)) {
                      return 'Harus mengandung huruf dan angka';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),

                // Tombol dengan Loading Indicator
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          ) // Animasi Loading
                        : const Text("LOGIN"),
                  ),
                ),

                // Untuk pindah ke halaman Lupas Password
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/forgot_password'),
                  child: const Text("Lupa Password?"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
