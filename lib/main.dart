import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_provider.dart';
import 'login_page.dart';
import 'forgot_password_page.dart'; // Tambahkan import ini
import 'dashboard_page.dart'; // Tambahkan import ini

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UTS Mobile Programming',
      theme: ThemeData(primarySwatch: Colors.blue),

      // Menggunakan initialRoute karena kita beralih ke pushNamed
      initialRoute: '/',

      // Daftarkan semua halaman di sini agar bisa dipanggil dengan Navigator.pushNamed
      routes: {
        '/': (context) => const LoginPage(),
        '/forgot_password': (context) => const ForgotPasswordPage(),
        '/dashboard': (context) => const DashboardPage(),
      },
    );
  }
}
