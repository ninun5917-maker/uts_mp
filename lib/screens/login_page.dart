import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/auth_provider.dart'; // '../' artinya keluar folder screens dulu baru masuk ke models

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // State tambahan sesuai instruksi wajib:
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true); // Aktifkan loading

      // Simulasi proses network (mock)
      await Future.delayed(const Duration(seconds: 2));

      // Credential sesuai instruksi: admin@test.com / Admin123
      if (_emailController.text == "admin@test.com" &&
          _passwordController.text == "Admin123") {
        if (!mounted) return;
        context.read<AuthProvider>().login(_emailController.text);

        setState(() => _isLoading = false);
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
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
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Icon(Icons.lock_person, size: 80, color: Colors.blue),
                const SizedBox(height: 20),

                // Email dengan REGEX
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
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

                // Password dengan Toggle Visibility & Huruf+Angka
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
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
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Password wajib diisi';
                    if (value.length < 8) return 'Minimal 8 karakter';
                    // Regex Huruf dan Angka
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
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("LOGIN"),
                  ),
                ),

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
