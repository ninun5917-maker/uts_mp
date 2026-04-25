import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  // State untuk Loading sesuai instruksi
  bool _isLoading = false;

  void _sendResetLink() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulasi proses pengiriman link (2 detik)
      await Future.delayed(const Duration(seconds: 2));

      setState(() => _isLoading = false);

      // Feedback visual menggunakan Snackbar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Link reset telah dikirim ke email Anda"),
            backgroundColor: Colors.green,
          ),
        );
        // Kembali ke login setelah sukses
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
          padding: const EdgeInsets.all(20.0), // Widget Padding
          child: Form(
            key: _formKey,
            child: Column(
              // Widget Column
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Lupa Kata Sandi?",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10), // Widget SizedBox
                const Text(
                  "Masukkan email Anda untuk menerima link pemulihan.",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // Input Email dengan Validasi Format (Regex)
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email Pemulihan",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Email tidak boleh kosong';
                    // Regex format email
                    final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(value);
                    return emailValid ? null : "Format email tidak valid";
                  },
                ),
                const SizedBox(height: 20),

                // Tombol dengan Loading State
                ElevatedButton(
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
                        )
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
