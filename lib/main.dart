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

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => NavBarProvider(),
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'My App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: InitializerScreen(),  // First screen that handles navigation
//     );
//   }
// }

// class InitializerScreen extends StatefulWidget {
//   @override
//   _InitializerScreenState createState() => _InitializerScreenState();
// }

// class _InitializerScreenState extends State<InitializerScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // After some initialization delay or condition
//     Future.delayed(Duration(seconds: 2), () {
//       // Navigate to specific page
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HomeView()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: CircularProgressIndicator()), // You can add a loading indicator here
//     );
//   }
// }

// class SpecificPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Specific Page"),
//       ),
//       body: Center(
//         child: Text("This is the specific page"),
//       ),
//     );
//   }
// }

