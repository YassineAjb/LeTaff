import 'package:animated_introduction/animated_introduction.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Introduction Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.black, // Set global background color

        useMaterial3: true,
      ),
  
      home: const ExamplePage(),
    );
  }
}

/// List of pages to be shown in the introduction
///
final List<SingleIntroScreen> pages = [
  const SingleIntroScreen(
    title: 'Welcome to the Event Management App !',
    description: 'You plans your Events, We\'ll do the rest and will be the best! Guaranteed!  ',
    imageAsset: 'assets/onboard_one.png',
    sideDotsBgColor : Colors.deepOrange,
    mainCircleBgColor : Colors.deepOrange,
    headerBgColor: Colors.black,


  ),
  const SingleIntroScreen(
    title: 'Book tickets to cricket matches and events',
    description: 'Tickets to the latest movies, crickets matches, concerts, comedy shows, plus lots more !',
    imageAsset: 'assets/onboard_two.png',
    sideDotsBgColor : Colors.deepOrange,
    mainCircleBgColor : Colors.deepOrange,
    headerBgColor: Colors.black,

  ),
  const SingleIntroScreen(
    title: 'Grabs all events now only in your hands',
    description: 'All events are now in your hands, just a click away ! ',
    imageAsset: 'assets/onboard_three.png',
    sideDotsBgColor : Colors.deepOrange,
    mainCircleBgColor : Colors.deepOrange,
    headerBgColor: Colors.black,

  ),
];

/// Example page
class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedIntroduction(
      footerBgColor : const Color.fromARGB(255, 24, 24, 24),
      textColor : Colors.deepOrange,
      slides: pages,
      indicatorType: IndicatorType.circle,
      containerBg: Colors.black,  //the black transition ****

      onDone: () {
        /// TODO: Go to desire page like login or home
      },
    );
  }
}