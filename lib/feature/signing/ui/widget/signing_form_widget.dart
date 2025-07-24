import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restero/core/widget/common_text_field_widget.dart';
import 'package:restero/feature/signing/logic/signing_cubit.dart';
import 'package:restero/feature/signing/logic/signing_state.dart';

class SigningFormWidget extends StatefulWidget {
  const SigningFormWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<SigningFormWidget> createState() => _SigningFormWidgetState();
}

class _SigningFormWidgetState extends State<SigningFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      final authCubit = context.read<AuthCubit>();
      authCubit.signIn(
        email: widget.emailController.text.trim(),
        password: widget.passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.goNamed('home');
          widget.emailController.clear();
          widget.passwordController.clear();
        } else if (state is AuthFailure) {
          widget.passwordController.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed: ${state.error}')),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'OR',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20.h),
              CommonTextFieldWidget(
                controller: widget.emailController,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                labelText: 'Email',
              ),
              SizedBox(height: 20.h),
              CommonTextFieldWidget(
                controller: widget.passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty || value.length < 6) {
                    return 'Please enter a valid Password';
                  }
                  return null;
                },
                labelText: 'Password',
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.centerRight,
                  ),
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFCC5920),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFCC5920),
                  minimumSize: Size(width, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0.r),
                  ),
                ),
                onPressed: isLoading ? null : _signIn,
                child: isLoading
                    ? CircularProgressIndicator(color: Color(0xFFCC5920))
                    : Text(
                        'Sign In',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
