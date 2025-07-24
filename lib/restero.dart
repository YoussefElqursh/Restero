import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restero/feature/cart/logic/cart_cubit.dart';
import 'package:restero/feature/home/ui/screen/home_layout.dart';
import 'package:restero/feature/signing/ui/screen/signing_screen.dart';

import 'feature/splash/ui/screen/splash_screen.dart';

class Restero extends StatelessWidget {
  const Restero({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(),
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp.router(
            routerConfig: _router,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: GoogleFonts.inter().fontFamily),
          );
        },
      ),
    );
  }
}

final _router = GoRouter(
  routes: [
    GoRoute(name: '/', path: '/', builder: (context, state) => SplashScreen()),
    GoRoute(
      name: 'signing',
      path: '/signing',
      builder: (context, state) => SigningScreen(),
    ),
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) => HomeLayout(),
    ),
  ],
);
