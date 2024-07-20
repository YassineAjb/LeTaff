import 'package:flutter/material.dart';
import 'package:letaff/Pages/DestinationView.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin<Home> {
  static const List<Destination> allDestinations = <Destination>[
    Destination(0, 'Home', Icons.home, Colors.teal),
    Destination(1, 'Services', Icons.assistant, Colors.cyan),   // Icon to change
    Destination(2, 'Portfolio', Icons.batch_prediction, Colors.orange),  // Icon to change
    Destination(3, 'About US', Icons.info, Colors.blue),       // Icon to change
  ];

  late final List<GlobalKey<NavigatorState>> navigatorKeys;
  late final List<GlobalKey> destinationKeys;
  late final List<AnimationController> destinationFaders;
  late final List<Widget> destinationViews;
  int selectedIndex = 0;

  AnimationController buildFaderController() {
    final AnimationController controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    controller.addStatusListener(
      (AnimationStatus status) {
        if (status == AnimationStatus.dismissed) {
          setState(() {}); // Rebuild unselected destinations offstage.
        }
      },
    );
    return controller;
  }

  @override
  void initState() {
    super.initState();

    navigatorKeys = List<GlobalKey<NavigatorState>>.generate(
      allDestinations.length,
      (int index) => GlobalKey(),
    ).toList();

    destinationFaders = List<AnimationController>.generate(
      allDestinations.length,
      (int index) => buildFaderController(),
    ).toList();
    destinationFaders[selectedIndex].value = 1.0;

    final CurveTween tween = CurveTween(curve: Curves.fastOutSlowIn);
    destinationViews = allDestinations.map<Widget>(
      (Destination destination) {
        return FadeTransition(
          opacity: destinationFaders[destination.index].drive(tween),
          child: DestinationView(
            destination: destination,
            navigatorKey: navigatorKeys[destination.index],
          ),
        );
      },
    ).toList();
  }

  @override
  void dispose() {
    for (final AnimationController controller in destinationFaders) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NavigatorPopHandler(
      onPop: () {
        final NavigatorState navigator =
            navigatorKeys[selectedIndex].currentState!;
        navigator.pop();
      },
      child: Scaffold(
        body: SafeArea(
          top: false,
          child: Stack(
            fit: StackFit.expand,
            children: allDestinations.map(
              (Destination destination) {
                final int index = destination.index;
                final Widget view = destinationViews[index];
                if (index == selectedIndex) {
                  destinationFaders[index].forward();
                  return Offstage(offstage: false, child: view);
                } else {
                  destinationFaders[index].reverse();
                  if (destinationFaders[index].isAnimating) {
                    return IgnorePointer(child: view);
                  }
                  return Offstage(child: view);
                }
              },
            ).toList(),
          ),
        ),
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return const TextStyle(color: Colors.deepOrange); // Color for selected label
              }
              return const TextStyle(color: Color.fromARGB(255, 255, 255, 255)); // Color for unselected label
            }),


            // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return const IconThemeData(color: Colors.white, size: 30); // Customize selected icon
              }
              return const IconThemeData(color: Colors.grey, size: 24); // Customize unselected icon
            }),          
            //
          ),

          child: NavigationBar(
            backgroundColor: const Color.fromARGB(255, 24, 24, 24),
            selectedIndex: selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                selectedIndex = index;
              });
            },
            destinations: allDestinations.map<NavigationDestination>(
              (Destination destination) {
                return NavigationDestination(
//                  icon: Icon(destination.icon, color: destination.color),
                    icon: Icon(destination.icon, color: Colors.white),
                   label: destination.title,
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
