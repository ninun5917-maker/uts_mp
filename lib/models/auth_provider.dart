import 'package:flutter/material.dart';

// untuk memberitau widget lain kalo ada data berubah
class AuthProvider with ChangeNotifier {
  String _email =
      ''; // Variabel dengan tanda '_' hanya bisa diakses di dalam file ini (Encapsulation)
  bool _isLoggedIn = false;

  // Ngasi akses "baca saja" ke variabel privat agar bisa dipakai di halaman lain
  String get email => _email;
  bool get isLoggedIn => _isLoggedIn;

  // Fungsi untuk mengisi data user saat berhasil masuk
  void login(String email) {
    _email = email; // Nyimpen email yang di input user
    _isLoggedIn = true; // Mengubah status jadi sudah login
    notifyListeners(); // Ngasitau seluruh aplikasi kalo ada data yang berubah
  }

  //fungsi Logout Nya
  void logout() {
    _email = ""; // Ngehapus email yang tersimpan
    _isLoggedIn = false; // Ngubah status jadi belum login
    notifyListeners(); // Ngasitau aplikasi untuk kembali ke tampilan awal
  }
}
