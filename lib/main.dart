import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:restero/firebase_options.dart';
import 'package:restero/restero.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Restero());
}



// flutter pub run build_runner build --delete-conflicting-outputs => to generate code