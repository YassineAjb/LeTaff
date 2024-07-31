import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:letaff/Pages/AboutUsView.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';


class PortfolioView extends StatefulWidget {
  const PortfolioView({super.key});

  @override
  _PortfolioViewState createState() => _PortfolioViewState();
}

class _PortfolioViewState extends State<PortfolioView> {
  late ScrollController _scrollController;
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

Future<void> _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}

  // void _startAutoScroll() {
  //   const duration = Duration(seconds: 3);
  //   _autoScrollTimer = Timer.periodic(duration, (timer) {
  //     if (_scrollController.hasClients) {
  //       final maxScrollExtent = _scrollController.position.maxScrollExtent;
  //       final currentScrollPosition = _scrollController.position.pixels;
  //       final targetPosition = (currentScrollPosition + 350 + 20) % (maxScrollExtent + 350 + 20);

  //       _scrollController.animateTo(
  //         targetPosition,
  //         duration: const Duration(seconds: 1),
  //         curve: Curves.easeInOut,
  //       );
  //     }
  //   });
  // }
  void _startAutoScroll() {
  const duration = Duration(seconds: 3);
  _autoScrollTimer = Timer.periodic(duration, (timer) {
    if (_scrollController.hasClients) {
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      final currentScrollPosition = _scrollController.position.pixels;
      final targetPosition = currentScrollPosition + 360;

      if (targetPosition >= maxScrollExtent) {
        _scrollController.animateTo(
          0.0,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      } else {
        _scrollController.animateTo(
          targetPosition,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      }
    }
  });
}


  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> projectData = [
      {
        'title': 'ACADEMINY',
        'date': 'Octobre 3,2023',
        'image': 'assets/Academiny-770x980.jpg',
        'isVisible': true,
      },
      {
        'title': 'SAVONNERIE ZEN',
        'date': 'Octobre 3,2023',
        'image': 'assets/Savonnerie-Zen-770x852.jpg',
        'isVisible': true,
      },
      {
        'title': 'ABSQJ',
        'date': 'Octobre 4,2023',
        'image': 'assets/abqsj-770x852.jpg',
        'isVisible': true,
      },
      {
        'title': 'CLINIQUE RADIOLOGIQUE',
        'date': 'Octobre 4,2023',
        'image': 'assets/Clinique-radiologique-770x853.jpg',
        'isVisible': true,
      },
      {
        'title': 'LA FERME DE POULIN',
        'date': 'Octobre 4,2023',
        'image': 'assets/La-ferme-de-Poulin-770x934.jpg',
        'isVisible': true,
      },
      {
        'title': 'BANKAI',
        'date': 'Octobre 4,2023',
        'image': 'assets/bankai-770x853.jpg',
        'isVisible': true,
      },
    ];

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    height: 200,
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
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "PORTFOLIO DE",
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 30.0,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Réalisations",
                      style: TextStyle(
                        color: Color.fromARGB(255, 120, 120, 120),
                        fontSize: 69.0,
                        height: 0.9,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Découvrez notre portfolio de réalisations, une collection visuelle de nos sites web et applications exceptionnels. Explorez nos réalisations pour voir comment nous transformons les idées en expériences numériques de premier ordre.",
                      style: TextStyle(
                        color: Color.fromARGB(255, 221, 221, 221),
                        fontSize: 19.0,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 40),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: projectData.map((project) {
                          return VisibilityDetector(
                            key: Key(project['title']),
                            onVisibilityChanged: (info) {
                              if (info.visibleFraction > 0 && !project['isVisible']) {
                                setState(() {
                                  project['isVisible'] = true;
                                });
                              }
                            },
                            child: Container(
                              width: 350,
                              height: 340,
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
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      project['image'],
                                      width: 350,
                                      height: 340,
                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                      width: 350,
                                      height: 340,
                                      padding: const EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.black.withOpacity(0.1),
                                            Colors.black.withOpacity(0.6),
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                        ),
                                      ),
                                    ),
                                    // Positioned(
                                    //   top: 16.0,
                                    //   left: 16.0,
                                    //   child: project['isVisible']
                                    //       ? Container(
                                    //           padding: const EdgeInsets.all(8.0),
                                    //           decoration: BoxDecoration(
                                    //             color: Colors.black.withOpacity(0.4),
                                    //             borderRadius: BorderRadius.circular(12.0),
                                    //           ),
                                    //           child: Text(
                                    //             project['title'],
                                    //             style: const TextStyle(
                                    //               color: Colors.deepOrange,
                                    //               fontSize: 24.0,
                                    //               fontWeight: FontWeight.bold,
                                    //             ),
                                    //           ).animate()
                                    //             .fade(duration: 1000.ms)
                                    //             .scale(delay: 1000.ms),
                                    //                                                       )
                                    //       : Container(),
                                    // ),
                                    Positioned(
                                    top: 16.0,
                                    left: 16.0,
                                    child: project['isVisible']
                                      ? Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.4),
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              project['title'],
                                              style: const TextStyle(
                                                color: Colors.deepOrange,
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ).animate().fade(duration: 1000.ms).scale(delay: 1000.ms),
                                            const SizedBox(height: 8.0), // Space between title and date
                                            Text(
                                              project['date'],
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                      : Container(),
                                  ),

                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    // New Container added here
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          //color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(90.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          border: Border.all(
                            color: Colors.white, // Set the border color
                            width: 1.5, // Set the border width
                          ),
                        ),
                        child: const Text(
                          'TRAVAILLONS ENSEMBLE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          //color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(90.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Text(
                          'Nous aimerions en savoir\nplus sur votre projet',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 185, 185, 185),
                            fontSize: 27.0,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 120, // Adjust to the desired diameter
                        height: 120, // Must match the width to make it a circle
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AboutUsView()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(90), // Half of width/height for a circle
                           side: const BorderSide(
                              color: Colors.deepOrange, // Border color
                              width: 2.5, // Border width
                            ),
                            ),
                            padding: EdgeInsets.zero, // Remove padding to ensure circular shape
                          ),
                          child: const Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Parlons\nNous",textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 19,
                                  ),
                                ),
                                SizedBox(width: 2), // Add some spacing between text and icon
                                Icon(
                                  Icons.moving,
                                  color: Colors.deepOrange,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 50),
                    // Social Media Buttons
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Image.asset('assets/linked4.png', width: 45, height: 45),
                            onPressed: () => _launchURL('https://www.linkedin.com'),
                          ),
                          const SizedBox(width: 0),
                          IconButton(
                            icon: Image.asset('assets/face5.png', width: 45, height: 45),
                            onPressed: () => _launchURL('https://www.facebook.com'),
                          ),
                          const SizedBox(width: 0),
                          IconButton(
                            icon: Image.asset('assets/insta4.png', width: 45, height: 45),
                            onPressed: () => _launchURL('https://www.instagram.com'),
                          ),
                          const SizedBox(width: 0),
                          // PACKAGE PROBLEM !!!!!!!!!!
                          // IconButton(
                          //   icon: const Icon(Icons.facebook, color: Colors.deepOrange, size: 30,),
                          //   onPressed: () => _launchURL('https://www.facebook.com'),
                          // ),
                          // IconButton(
                          //   icon: Icon(FlutterSocialIcons.linkedin, color: Colors.blue),
                          //   onPressed: () => _launchURL('https://www.linkedin.com'),
                          // ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 50)),

          ],
        ),
      ),
    );
  }
}
