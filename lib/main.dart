import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/auth_provider.dart';
import 'screens/login_page.dart';
import 'screens/dashboard_page.dart';
import 'screens/forgot_password_page.dart';

// Fungsi utama
void main() {
  runApp(
    // Ngebungkus aplikasi pake provider biar data user bisa di akhir di mana aja
    ChangeNotifierProvider(
      create: (context) => AuthProvider(), // Inisialisasi Logic autentikasi
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Pondasi design dan navigasi
    return MaterialApp(
      title: 'UTS MP',
      // Ngilangin banner debug di pojok kanan atas
      debugShowCheckedModeBanner: false,
      // Ngatur design semua aplikasi pake design 3
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      // Matikan effext melar
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: child!,
        );
      },

      // Nentuin halaman awal yang muncul
      initialRoute: '/',
      // Daftar alamat setiap halamn di aplikasi
      routes: {
        '/': (context) => const LoginPage(), // Halaman Login
        '/dashboard': (context) => const DashboardPage(), // Halaman Dashboard
        '/forgot_password': (context) =>
            const ForgotPasswordPage(), // Halaman Lupas Password
      },
    );
  }
}
