import 'package:flutter/material.dart';
import 'package:letaff/NavBar/DestinationView.dart';
import 'package:letaff/providers/NavBarProvider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin<Home> {
  static const List<Destination> allDestinations = <Destination>[
  Destination(0, 'Home', Icons.home),
  Destination(1, 'Services', Icons.clear_all_rounded),
  Destination(2, 'Portfolio', Icons.cases_outlined),
  Destination(3, 'Career', Icons.stairs_rounded),
  Destination(4, 'Contact', Icons.chat),  
  Destination(5, 'About Us', Icons.supervised_user_circle),          
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
  return Consumer<NavBarProvider>(
    builder: (context, navBarProvider, child) {
      return NavigatorPopHandler(
        onPop: () {
          final NavigatorState navigator =
              navigatorKeys[navBarProvider.selectedIndex].currentState!;
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
                  if (index == navBarProvider.selectedIndex) {
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
                  return const TextStyle(color: Colors.deepOrange);
                }
                return const TextStyle(color: Color.fromARGB(255, 255, 255, 255));
              }),
              iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return const IconThemeData(color: Color.fromARGB(255, 255, 0, 0), size: 25);
                }
                return const IconThemeData(color: Colors.grey, size: 21);
              }),
            ),
            child: NavigationBar(
              backgroundColor: const Color.fromARGB(255, 24, 24, 24),
              selectedIndex: navBarProvider.selectedIndex,
              onDestinationSelected: (int index) {
                navBarProvider.updateIndex(index); // Update using provider
              },
              destinations: allDestinations.map<NavigationDestination>(
                (Destination destination) {
                  return NavigationDestination(
                    icon: Icon(destination.icon),
                    label: destination.title,
                  );
                },
              ).toList(),
            ),
          ),
        ),
      );
    },
  );
}

}
