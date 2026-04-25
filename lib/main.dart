import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/auth_provider.dart'; // Sesuaikan folder
import 'screens/login_page.dart';
import 'screens/forgot_password_page.dart';
import 'screens/dashboard_page.dart';

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
