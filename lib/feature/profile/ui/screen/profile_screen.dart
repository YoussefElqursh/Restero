import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(15.0.r),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFDFD2C9),
                  ),
                  child: Icon(
                    Icons.person,
                    size: 100,
                    color: Color(0xFFCC5920),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  user?.email ?? "",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(100, 40),
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFFCC5920),
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    context.goNamed('signing');
                  },
                  child: Text("Logout"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
