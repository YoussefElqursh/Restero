import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      (){
        if (!mounted) return; // ✔️ Prevent crashes

          FirebaseAuth.instance.authStateChanges().listen((user) {
            if (user != null) {
              // ignore: use_build_context_synchronously
              context.goNamed('home');
            }
          });
        // ignore: use_build_context_synchronously
        context.goNamed('signing');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFDFD2C9),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Center(
              child: Image.asset(
                'assets/images/restero_app_icon.jpg',
                width: width.w,
                height: 500.h,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: CircularProgressIndicator(color: Color(0xFFCC5920)),
            ),
          ),
        ],
      ),
    );
  }
}
