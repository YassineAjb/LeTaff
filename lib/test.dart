// import 'package:flutter/material.dart';

// class ServicesView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
// appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Center(
//           child: Text(
//             "LETAFF",
//             style: TextStyle(color: Colors.deepOrange),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Hero Section
//             Container(
//               height: 200.0,
//               color: Colors.deepOrangeAccent,
//               child: const Center(
//                 child: Text(
//                   "Hero Section",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             // Features Section
//             Container(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Features",
//                     style: TextStyle(
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 10.0),
//                   featureCard("Feature 1", "Description of Feature 1"),
//                   featureCard("Feature 2", "Description of Feature 2"),
//                   featureCard("Feature 3", "Description of Feature 3"),
//                 ],
//               ),
//             ),
//             // Testimonials Section
//             Container(
//               padding: const EdgeInsets.all(16.0),
//               color: Colors.grey[200],
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Testimonials",
//                     style: TextStyle(
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 10.0),
//                   testimonialCard("User 1", "This is a testimonial from User 1"),
//                   testimonialCard("User 2", "This is a testimonial from User 2"),
//                 ],
//               ),
//             ),
//             // Footer Section
//             Container(
//               padding: const EdgeInsets.all(16.0),
//               color: Colors.black,
//               child: const Center(
//                 child: Text(
//                   "Footer",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16.0,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget featureCard(String title, String description) {
//     return Card(
//       margin: const EdgeInsets.only(top: 10.0),
//       child: ListTile(
//         title: Text(title),
//         subtitle: Text(description),
//       ),
//     );
//   }

//   Widget testimonialCard(String user, String testimonial) {
//     return Card(
//       margin: const EdgeInsets.only(top: 10.0),
//       child: ListTile(
//         title: Text(user),
//         subtitle: Text(testimonial),
//       ),
//     );
//   }
//   }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class PortfolioView extends StatefulWidget {
  const PortfolioView({super.key});

  @override
  _PortfolioViewState createState() => _PortfolioViewState();
}

class _PortfolioViewState extends State<PortfolioView> {
    bool _showShadow = false;

void _triggerShadow() {
  print("Triggering shadow");
  setState(() {
    _showShadow = true;
  });

  Future.delayed(const Duration(seconds: 3), () {
    setState(() {
      _showShadow = false;
    });
    print("Shadow hidden");
  });
}

  final ScrollController _scrollController = ScrollController();
  Timer? _scrollTimer;

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> projectData = [];

  @override
  void initState() {
    super.initState();

    _fetchProjects(); // Fetch data when the screen is initialized
    print("-------------------------------------------------");
    print(projectData);
    print("-------------------------------------------------");

        // Trigger the animations when the page is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        // This rebuilds the widget to start the animations
      });
    });
    _startAutoScroll();
    //_triggerShadow();
  }

  Future<void> _fetchProjects() async {
    try {
      // Fetch data from Firestore
      QuerySnapshot snapshot = await _firestore.collection('projects').get();
      setState(() {
        projectData = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      });
    } catch (e) {
      print("Error fetching projects: $e");
    }
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

void _startAutoScroll() {
    _scrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_scrollController.hasClients) {
        final double maxScrollExtent = _scrollController.position.maxScrollExtent;
        final double currentScrollPosition = _scrollController.position.pixels;

        if (currentScrollPosition < maxScrollExtent) {
          _scrollController.animateTo(
            currentScrollPosition + 380, // Adjust this value as needed
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
  void dispose() {
    _scrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: projectData.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification) {
                  if (scrollNotification.metrics.pixels >=
                          scrollNotification.metrics.maxScrollExtent &&
                      scrollNotification.metrics.axisDirection ==
                          AxisDirection.down) {
                    _triggerShadow(); // Trigger the shadow when the bottom is reached
                  }
                }
                return true;
              },
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(child: SizedBox(height: 20)),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 100,
                      color: Colors.black,
                      child: Center(
                        child: Image.asset('assets/le-taff-logo-1.png'),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 30,
                      endIndent: 30,
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 20)),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "PORTFOLIO DE",
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 30.0,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Réalisations",
                            style: TextStyle(
                              color: Color.fromARGB(255, 120, 120, 120),
                              fontSize: 69.0,
                              height: 0.9,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Découvrez notre portfolio de réalisations, une collection visuelle de nos sites web et applications exceptionnels. Explorez nos réalisations pour voir comment nous transformons les idées en expériences numériques de premier ordre.",
                            style: TextStyle(
                              color: Color.fromARGB(255, 221, 221, 221),
                              fontSize: 19.0,
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 340, // Set a fixed height for the project section
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: projectData.length,
                        itemBuilder: (context, index) {
                          final project = projectData[index];
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
                              width: 380,
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
                                      width: 380,
                                      height: 340,
                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                      width: 380,
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
                                                  const SizedBox(height: 8.0),
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
                        },
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 40)),
                  SliverToBoxAdapter(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
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
                            color: Colors.white,
                            width: 1.5,
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
                  ),
                  SliverToBoxAdapter(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
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
                  ),
                  SliverToBoxAdapter(
                    child: Center(
                      child: SizedBox(
                        width: 120,
                        height: 120,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/contact');
                            print('Navigating to ContactView...');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(90),
                              side: const BorderSide(
                                color: Color.fromARGB(255, 115, 115, 115),
                                width: 2.5,
                              ),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          child: const Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Parlons\nNous",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 19,
                                  ),
                                ),
                                SizedBox(width: 2),
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
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 50)),
                  
                  const SliverToBoxAdapter(
                    child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 30,
                    endIndent: 30,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Image.asset('assets/linked4.png', width: 45, height: 45),
                            onPressed: () => _launchURL('https://www.linkedin.com'),
                          ),
                          const SizedBox(width: 0),
                          IconButton(
                            icon: Image.asset('assets/beIcon.png', width: 45, height: 45),
                            onPressed: () => _launchURL('https://www.linkedin.com'),
                          ),
                          const SizedBox(width: 0),
                          IconButton(
                            icon: Image.asset('assets/insta4.png', width: 45, height: 45),
                            onPressed: () => _launchURL('https://www.instagram.com'),
                          ),
                          const SizedBox(width: 0),
                          IconButton(
                            icon: Image.asset('assets/face5.png', width: 45, height: 45),
                            onPressed: () => _launchURL('https://www.facebook.com'),
                          ),
                          IconButton(
                            icon: Image.asset('assets/tiktokicon.png', width: 45, height: 45),
                            onPressed: () => _launchURL('https://www.instagram.com'),
                          ),
                          const SizedBox(width: 0),
                        ],
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 20)),

                  // SliverToBoxAdapter(child:Stack(
                  //   children: [
                  //     if (_showShadow)
                  //       Positioned(
                  //         bottom: 0,
                  //         left: 0,
                  //         right: 0,
                  //         child: CustomPaint(
                  //           size: Size(MediaQuery.of(context).size.width, 400), // Height of the curve
                  //           painter: BottomCurvePainter(),
                  //         ),
                  //       ),
                  //   ],
                  //   ),
                  // ),
                  SliverToBoxAdapter(
                      child: Stack(
                        children: [
                          if (_showShadow)
                            RepaintBoundary(
                              child: CustomPaint(
                                painter: BottomCurvePainter(),
                                child: const SizedBox(
                                  width: double.infinity,
                                  height: 100,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
              
      ),
    ),);
  }
}

class BottomCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color.fromARGB(255, 31, 31, 31).withOpacity(0.5) // Increased opacity
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(-40, size.height);
    path.quadraticBezierTo(size.width / 2, 0, size.width + 40, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Force repaint to ensure the shadow is shown
  }
}

