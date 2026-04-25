import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_provider.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil data user dari Provider
    final userEmail = context.watch<AuthProvider>().email;

    // Data dummy untuk ListView.builder (Minimal 10 item)
    final List<String> items = List.generate(
      10,
      (index) => "Berita Teknologi ${index + 1}",
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Utama"),
        // Tombol Logout (Wajib)
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthProvider>().logout();
              // Navigator.pushAndRemoveUntil (Wajib: menghapus semua riwayat halaman)
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Widget Card dengan styling (Wajib)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4, // Shadow
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ), // Rounded
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    const CircleAvatar(radius: 30, child: Icon(Icons.person)),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Selamat datang,",
                          style: TextStyle(fontSize: 14),
                        ),
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

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Berita Terbaru",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          // Widget Advanced: ListView.builder (Wajib)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: const Icon(Icons.article, color: Colors.blue),
                    title: Text(items[index]),
                    subtitle: const Text("Klik untuk membaca selengkapnya..."),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Aksi dummy saat item diklik
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // Optional: Bottom Navigation Bar (Nilai Tambah)
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
