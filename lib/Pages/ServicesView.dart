import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ServicesView extends StatefulWidget {
  @override
  _ServicesViewState createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  final ScrollController _scrollController = ScrollController();
  Timer? _scrollTimer;

  @override
  void initState() {
    super.initState();
    // Trigger the animations when the page is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        // This rebuilds the widget to start the animations
      });
    });
    _startAutoScroll();
  }

  @override
  void dispose() {
    _scrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _scrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_scrollController.hasClients) {
        final double maxScrollExtent = _scrollController.position.maxScrollExtent;
        final double currentScrollPosition = _scrollController.position.pixels;

        if (currentScrollPosition < maxScrollExtent) {
          _scrollController.animateTo(
            currentScrollPosition + 350, // Adjust this value as needed
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        } else {
          _scrollController.animateTo(
            0,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Data for services containers
    final List<Map<String, dynamic>> servicesData = [
      {
        'title': 'SOLUTIONS WEB',
        'description': 'Nous mettons à votre disposition notre expertise pour répondre de manière globale à vos besoins en ligne.',
        'buttonText': 'Details',
        'buttonAction': () {
          // Define your button action here
          print("Details for Service SOLUTIONS WEB");
        },
        'image': 'assets/Sweb.jpg',
      },
      {
        'title': 'APPLICATIONS MOBILE',
        'description': "Nous mettons à votre disposition notre expertise en développement d'applications mobiles pour répondre de manière globale à vos besoins du création des applications personnalisées .",
        'buttonText': 'En savoir plus',
        'buttonAction': () {
          // Define your button action here
          print("Details for Service DÉVELOPPEMENT MOBILE");
        },
        'image': 'assets/SMobile.png',
      },
      {
        'title': 'MARKETING DIGITAL',
        'description': 'Nous élaborons des stratégies ciblées et innovantes pour renforcer votre visibilité en ligne et assurer la croissance de votre entreprise',
        'buttonText': 'Contactez-nous',
        'buttonAction': () {
          // Define your button action here
          print("Details for Service MARKETING DIGITAL");
        },
        'image': 'assets/SDigital.png',
      },
      {
        'title': 'Maintenance',
        'description': 'Nous offrons une assistance technique pour résoudre les problèmes rapidement et efficacement',
        'buttonText': '',
        'buttonAction': () {
          // Define your button action here
          print("Details for Service Maintenance");
        },
        'image': 'assets/Smaintenance.jpg',
      },
    ];

    // Widget buildServiceDescriptions() {
    //   return Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: servicesData.map((service) {
    //       return Padding(
    //         padding: const EdgeInsets.symmetric(vertical: 8.0),
    //         child: Text(
    //           service['description'],
    //           style: TextStyle(
    //             color: Colors.grey[400],
    //             fontSize: 16.0,
    //           ),
    //         ).animate(onPlay: (controller) => controller.repeat())
    //             .shimmer(duration: 4000.ms, color: Colors.deepOrange),
    //       );
    //     }).toList(),
    //   );
    // }
Widget buildServiceDescriptions() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: servicesData.map((service) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              service['title'],
              style:const TextStyle(
                //color: const Color.fromARGB(255, 255, 255, 255),
                color:Color.fromARGB(255, 113, 217, 255),
                fontSize: 20.0,
              ),
            ).animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 4000.ms, color: Colors.deepOrange),
            const SizedBox(height: 8.0), // Add some space between title and description
            Text(
              service['description'],
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16.0,
              ),
            ).animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 4000.ms, color: Colors.deepOrange),
          ],
        ),
      );
    }).toList(),
  );
}

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    height: 100,
                    color: Colors.black,
                    child: Center(
                      child: Image.asset('assets/le-taff-logo-1.png'),
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 30,
                    endIndent: 30,
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 0, 0, 0),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Services De",
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Développement Digital",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 33,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Nos services de développement digital englobent une gamme complète de solutions web, des applications mobiles innovantes, des stratégies SEO avancées, du marketing digital percutant, des créations graphiques originales, ainsi que des services de Développement et Marketing.",
                            style: TextStyle(
                              color: Color.fromARGB(255, 152, 152, 152),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    hr,

                    // Display list of services descriptions
                    buildServiceDescriptions(),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      child: Row(
                        children: servicesData.map((service) {
                          return Container(
                            width: 340,
                            height: 370,
                            padding: const EdgeInsets.all(16.0),
                            margin: const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 24, 24, 24),
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    service['title'],
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 216, 216, 216),
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                Container(
                                  width: 340,
                                  height: 210,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    image: DecorationImage(
                                      image: AssetImage(service['image']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: service['buttonAction'],
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              service['buttonText'],
                                              style: const TextStyle(
                                                color: Colors.deepOrange,
                                              ),
                                            ),
                                            const Icon(
                                              Icons.moving,
                                              color: Colors.deepOrange,
                                              size: 30,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get hr => Container(
    height: 2,
    color: const Color(0x8080DDFF),
    margin: const EdgeInsets.symmetric(vertical: 16),
  ).animate().scale(duration: 600.ms, alignment: Alignment.centerLeft);
}
