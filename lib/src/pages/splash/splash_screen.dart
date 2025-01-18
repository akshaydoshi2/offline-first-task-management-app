import 'package:flutter/material.dart';
import 'package:tushop_assesment/l10n/app_localizations.dart';
import 'package:tushop_assesment/src/pages/auth/login_screen.dart';
import 'package:tushop_assesment/src/pages/home/home_screen.dart';
import 'package:tushop_assesment/src/pages/root.dart';
import 'package:tushop_assesment/src/utilities/extensions.dart';
import 'package:tushop_assesment/src/widgets/logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInExpo,
    );
    _controller.forward();
    Future.delayed(const Duration(seconds: 3)).then((_){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Root())
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: AppLogo(context),
      ),
    );
  }
}
