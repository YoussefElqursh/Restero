import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restero/feature/signing/ui/widget/signing_form_widget.dart';

class SigningScreen extends StatefulWidget {
  const SigningScreen({super.key});

  @override
  State<SigningScreen> createState() => _SigningScreenState();
}

class _SigningScreenState extends State<SigningScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFDFD2C9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/restero_app_icon.jpg',
                    width: width.w,
                    height: 200.h,
                  ),
                ),
                SizedBox(height: 20.h),
                Center(
                  child: Text(
                    'Welcome to Restero',
                    style: GoogleFonts.inter(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 70.h),
                Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0.r),
                    border: Border.all(color: Color(0xFFCC5920), width: 2.0),
                  ),
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 10.0.h,
                        children: [
                          MaterialButton(
                            onPressed: () {},
                            height: 50.0.h,
                            minWidth: double.infinity,
                            elevation: 0.0,
                            highlightElevation: 0.0,
                            focusElevation: 0.0,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0.r),
                              ),
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 50.0.h,
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0.r),
                                ),
                                color: Colors.white,
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/google_logo.png',
                                  ),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {},
                            height: 50.0.h,
                            minWidth: double.infinity,
                            elevation: 0.0,
                            highlightElevation: 0.0,
                            focusElevation: 0.0,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0.r),
                              ),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0.r),
                                ),
                                color: Colors.white,
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/facebook_logo.png',
                                  ),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(child: const Divider(thickness: 1.0, color: Color(0xFFCC5920))),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'OR',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(child: const Divider(thickness: 1.0, color: Color(0xFFCC5920))),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      SigningFormWidget(
                        emailController: emailController,
                        passwordController: passwordController,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
