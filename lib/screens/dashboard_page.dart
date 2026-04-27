import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/auth_provider.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Ngambil data email daru auth provider
    final userEmail = context.watch<AuthProvider>().email;

    // 10 data dummy
    final List<String> items = List.generate(
      10,
      (index) => "Berita Teknologi ${index + 1}",
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Utama"),
        // Tombol Logout pojok kanan atas
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Ngambiil fungsi logout di provider
              context.read<AuthProvider>().logout();
              // Balik ke login dan hapus riwayat dengan Navigator.pushAndRemoveUntil
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Widget Card untuk nampilin informasi user
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4, // Shadow pada kartu
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ), // Rounded (sudut krtu jadi tumpul)
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    // Nampilin icon user bentuk llingkaran
                    const CircleAvatar(radius: 30, child: Icon(Icons.person)),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Selamat datang,",
                          style: TextStyle(fontSize: 14),
                        ),
                        // Nampilin email yang di ambil dari provider
                        Text(
                          userEmail, // Menampilkan nama user dari state
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Judul untuk bagian berita
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Berita Terbaru",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          // Daftar berita yang bisa di scroll
          // Widget Advanced ListView.builder (Expanded digunakan agar ListView mengambil sisa ruang yang tersedia)
          Expanded(
            child: ListView.builder(
              // Agar scroll ga ngasi effect melar
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount:
                  items.length, // Nentuin jumlah baris sesuai panjang data
              itemBuilder: (context, index) {
                // Design untuk setiap baris di dalam daftar nya
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: const Icon(Icons.article, color: Colors.blue),
                    title: Text(items[index]), // Judul berita dari data dumy
                    subtitle: const Text("Klik untuk membaca selengkapnya..."),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ), // Icon panah kanan
                    onTap: () {},
                    // Effeck saat berita di tekan
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notif",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting"),
        ],
      ),
    );
  }
}
