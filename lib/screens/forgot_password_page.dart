import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>(); // Ngawasin validasi input email
  final _emailController =
      TextEditingController(); // Controller untuk ngabil teks email pemulihan

  // Animasi loading pas tombol di tekan
  bool _isLoading = false;

  // Untuk mensimulasi pengiriman link reset password
  void _sendResetLink() async {
    if (_formKey.currentState!.validate()) {
      // Mastiin email valid
      setState(() => _isLoading = true); // Nyalain mode loading muter-muter

      // Simulasi proses pengiriman link (2 detik)
      await Future.delayed(const Duration(seconds: 2));

      // Matiin mode loading setelah selesai
      setState(() => _isLoading = false);

      // Notifikasi Sukses
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Link reset telah dikirim ke email Anda"),
            backgroundColor: Colors.green,
          ),
        );
        // Kembali otomatis ke login setelah sukses
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Penerapan SafeArea agar konten tidak terpotong notch/status bar
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Reset Password")),
        body: Padding(
          padding: const EdgeInsets.all(20.0), // Jarak antara konten dan layar
          child: Form(
            key: _formKey, // Ngubungin form dan kunci validasi
            child: Column(
              // Widget Column
              mainAxisAlignment:
                  MainAxisAlignment.center, // Konten di tengah layar
              crossAxisAlignment:
                  CrossAxisAlignment.stretch, // Konten belebar memenuhi layar
              children: [
                // Judul Halaman
                const Text(
                  "Lupa Kata Sandi?",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10), // Widget SizedBox
                const Text(
                  // Intruksi masukin email
                  "Masukkan email Anda untuk menerima link pemulihan.",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // Tempat masukin email untuk pemulihan
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email Pemulihan",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  // Mastiin input ga kosong dan formatnya bener
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Email tidak boleh kosong';
                    // Mastiin ada @ dan .
                    final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(value);
                    return emailValid ? null : "Format email tidak valid";
                  },
                ),
                const SizedBox(height: 20),

                // Tombol kirim link dengan Loading State
                ElevatedButton(
                  // Kalo lagi loading tombol ga bisa di klik
                  onPressed: _isLoading ? null : _sendResetLink,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ) // Loading indikator saat proses
                      : const Text("KIRIM LINK RESET"),
                ),
                const SizedBox(height: 10),

                // Tombol Kembali ke Login menggunakan Navigator.pop
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Kembali ke Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
