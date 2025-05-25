import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'register_page.dart';
import 'home_page_with_nav.dart';
import 'theme_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Giriş başarılı!')),
      );
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePageWithNav()),
        );
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    Color iconColor = isDark ? Colors.white : Colors.black87; // Ay koyu gri değil beyaz için siyaha yakın, güneş beyaz
    Color sunIconColor = Colors.white; // Güneş ikonu beyaz (karanlık modda görünür olsun)
    Color moonIconColor = Colors.grey.shade800; // Ay ikonu koyu gri siyaha yakın

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Icon(Icons.lock_outline, size: 80, color: Colors.deepPurple),
                    const SizedBox(height: 16),
                    Text(
                      'Giriş Yap',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'E-posta',
                        border: const OutlineInputBorder(),
                        labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: isDark ? Colors.white54 : Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: isDark ? Colors.deepPurple.shade200 : Colors.deepPurple),
                        ),
                      ),
                      style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'E-posta gerekli';
                        if (!value.contains('@')) return 'Geçerli bir e-posta girin';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Şifre',
                        border: const OutlineInputBorder(),
                        labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: isDark ? Colors.white54 : Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: isDark ? Colors.deepPurple.shade200 : Colors.deepPurple),
                        ),
                      ),
                      style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Şifre gerekli';
                        if (value.length < 6) return 'Şifre en az 6 karakter olmalı';
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Giriş Yap'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Hesabınız yok mu?",
                          style: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const RegisterScreen()),
                            );
                          },
                          child: Text(
                            "Kayıt Ol",
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) =>
                  RotationTransition(turns: animation, child: child),
              child: IconButton(
                key: ValueKey<bool>(isDark),
                icon: Icon(
                  isDark ? Icons.wb_sunny : Icons.nightlight_round,
                  color: isDark ? sunIconColor : moonIconColor,
                ),
                iconSize: 28,
                onPressed: () {
                  themeProvider.toggleTheme(!isDark);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}