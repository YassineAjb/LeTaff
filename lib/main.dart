import 'package:letaff/IntroScreen/Intro.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


// import 'package:flutter/material.dart';
// import 'package:letaff/IntroScreen/Intro.dart';

// void main() {
//   runApp(const MyApp());
// }
