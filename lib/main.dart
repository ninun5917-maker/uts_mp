import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/auth_provider.dart';
import 'screens/login_page.dart';
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
      title: 'UTS MP',
      debugShowCheckedModeBanner: false,
      // Hapus baris androidOverscrollIndicator yang merah tadi
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      // TAMBAHKAN BAGIAN INI UNTUK MEMATIKAN EFEK MELAR GLOBAL
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: child!,
        );
      },
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
      },
    );
  }
}
