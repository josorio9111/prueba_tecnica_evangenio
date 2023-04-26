import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica_evangenio/provider/auth_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final controller = Provider.of<AuthProvider>(context, listen: false);
      String ruta = '';
      if (await controller.auth()) {
        ruta = 'home';
      } else {
        ruta = 'login';
      }
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, ruta, (_) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
