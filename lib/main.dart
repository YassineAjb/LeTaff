import 'package:letaff/IntroScreen/Intro.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:letaff/providers/NavBarProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      ChangeNotifierProvider(
        create: (context) => NavBarProvider(),
        child: MyApp(),
      ),
    );
  }


// import 'package:flutter/material.dart';
// import 'package:letaff/IntroScreen/Intro.dart';

// void main() {
//   runApp(const MyApp());
// }

