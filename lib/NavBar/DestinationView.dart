import 'package:flutter/material.dart';
import 'package:letaff/Pages/HomeView.dart';
import 'package:letaff/Pages/ServicesView.dart';
import 'package:letaff/Pages/PortfolioView.dart';
import 'package:letaff/Pages/AboutUsView.dart';
import 'package:letaff/Pages/CareerView.dart';
import 'package:letaff/Pages/ContactView.dart';

class Destination {
  const Destination(this.index, this.title, this.icon);
  final int index;
  final String title;
  final IconData icon;
}


class DestinationView extends StatelessWidget {
  const DestinationView({
    required this.destination,
    required this.navigatorKey,
    super.key,
  });

  final Destination destination;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) {
            switch (destination.index) {
              case 0:
                return HomeView();
              case 1:
                return ServicesView();
              case 2:
                return PortfolioView();
              case 3:
                return CareerView();
              case 4:
                return ContactView();
              case 5:
                return AboutUsView();
              default:
                return HomeView();
            }
          },
        );
      },
    );
  }
}


